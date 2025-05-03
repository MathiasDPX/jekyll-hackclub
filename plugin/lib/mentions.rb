require "jekyll"
require_relative "./server-bridge"

module Jekyll
    class HackclubMention < Liquid::Tag
        def initialize(tagName, content, tokens)
            super
            @args = content.split(" ; ").map(&:strip)
            @id = @args[0]
        end

        def render(context)
            if @id && @id.start_with?("U")
                display_name = @args[1] || HackclubRequest.resolve_username(@id)
                %Q{<a href="https://hackclub.slack.com/team/#{@id}" class="hackclub-mention hackclub-user" target="_blank">@#{display_name}</a>}
            elsif @id && @id.start_with?("C")
                display_name = @args[1] || HackclubRequest.resolve_channel(@id)
                %Q{<a href="https://hackclub.slack.com/archives/#{@id}" class="hackclub-mention hackclub-channel" target="_blank">##{display_name}</a>}
            end
        end
    end

    Liquid::Template.register_tag "mention", HackclubMention
end
