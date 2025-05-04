require "jekyll"
require_relative "./server-bridge"

module Jekyll
    class HackclubUserTag < Liquid::Tag
        def initialize(tagName, content, tokens)
            super
            content = content.strip()
            @id, *rest = content.split(" ", 2)
            keys = rest.join.split(".")
            @data = HackclubRequest.raw_user(@id).dig("user").dig(*keys)
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
