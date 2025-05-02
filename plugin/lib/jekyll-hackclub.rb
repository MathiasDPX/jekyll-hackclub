require "net/http"
require "jekyll"
require "json"
require "uri"

module Jekyll
    class HackclubMention < Liquid::Tag
        def resolve_username(userid)
            uri = URI(@host+"/users.info/"+userid)
            res = Net::HTTP.get_response(uri)
            begin
                data = JSON.parse(res.body)
            rescue
                return "unavailable"
            end

            if res.is_a?(Net::HTTPSuccess)
                data = JSON.parse(res.body)
                return data.dig("user", "name")
            else
                return "unknown"
            end
        end

        def resolve_channel(channelid)
            uri = URI(@host+"/conversations.info/"+channelid)
            res = Net::HTTP.get_response(uri)
            begin
                data = JSON.parse(res.body)
            rescue
                return "unavailable"
            end

            if res.is_a?(Net::HTTPSuccess)
                data = JSON.parse(res.body)
                return data.dig("channel", "name")
            else
                return "unknown"
            end
        end

        def initialize(tagName, content, tokens)
            super
            @host = Jekyll.configuration({})['HACKCLUB_API'] || "https://slack.mathias.hackclub.app"
            @args = content.split(" ; ").map(&:strip)
            @id = @args[0]
        end

        def render(context)
            if @id && @id.start_with?("U")
                display_name = @args[1] || resolve_username(@id)
                %Q{<a href="https://hackclub.slack.com/team/#{@id}" class="hackclub-mention hackclub-user" target="_blank">@#{display_name}</a>}
            elsif @id && @id.start_with?("C")
                display_name = @args[1] || resolve_channel(@id)
                %Q{<a href="https://hackclub.slack.com/archives/#{@id}" class="hackclub-mention hackclub-channel" target="_blank">##{display_name}</a>}
            end
        end

        Liquid::Template.register_tag "hackclub", self
    end
end