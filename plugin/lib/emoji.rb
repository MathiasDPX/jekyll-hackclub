require "jekyll"
require_relative "./server-bridge"

module Jekyll
    class HackclubEmoji < Liquid::Tag
        def initialize(tagName, content, tokens)
            super
            @id = content.gsub(/\A:+|:+\z/, '').strip
            @img_url = HackclubRequest.resolve_emoji(@id)
        end

        def render(context)
            %Q{<img src="#{@img_url}" title=":#{@id}:" alt=":#{@id}:" class="hackclub-emoji">}
        end
    end

    Liquid::Template.register_tag "emoji", HackclubEmoji
end
