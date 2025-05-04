require "jekyll"
require_relative "../args-parser"
require_relative "../server-bridge"

module Jekyll
    class HackclubUserTag < Liquid::Tag
        def initialize(tagName, content, tokens)
            super
            content = content.strip()
            @id, keys, pipes = ArgsParser.split_args(content)
            pipes = pipes || ""
            keys = keys.split(".")

            @data = HackclubRequest.raw_user(@id).dig("user").dig(*keys)
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

    Liquid::Template.register_tag "user", HackclubUserTag
end
