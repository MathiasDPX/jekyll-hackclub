require "jekyll"
require_relative "../server-bridge"

module Jekyll
    class HackclubChannelTag < Liquid::Tag
        def initialize(tagName, content, tokens)
            super
            content = content.strip()
            @id, keys, pipes = ArgsParser.split_args(content)
            pipes = pipes || ""
            keys = keys.split(".")

            @data = HackclubRequest.raw_channel(@id).dig("channel").dig(*keys)
            @data = ArgsParser.eval_pipes_with_val(@data, pipes.split(" | ").map(&:strip))
        end

        def render(context)
            if @data == nil
                %Q{null}
            else
                %Q{#{@data}}
            end
        end
    end

    Liquid::Template.register_tag "channel", HackclubChannelTag
end
