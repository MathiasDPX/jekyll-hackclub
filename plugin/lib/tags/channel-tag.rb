require "jekyll"
require_relative "../server-bridge"

module Jekyll
    class HackclubChannelTag < Liquid::Tag
        def initialize(tagName, content, tokens)
            super
            content = content.strip()
            @id, *rest = content.split(" ", 2)
            keys = rest.join.split(".")
            @data = HackclubRequest.raw_channel(@id).dig("channel").dig(*keys)
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
