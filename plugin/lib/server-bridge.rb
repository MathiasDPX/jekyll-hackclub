require "net/http"
require "json"
require "uri"

module HackclubRequest
    DEFAULT_EMOJI = "https://emoji.slack-edge.com/T0266FRGM/alibaba-question/c5ba32ce553206b8.png" # :alibaba-question:
    @host = Jekyll.configuration({})['HACKCLUB_API'] || "https://slack.mathias.hackclub.app"

    class << self
        attr_accessor :host
    end

    def self.resolve_emoji(id)
        uri = URI("#{host}/emoji/#{id.strip}")
        res = Net::HTTP.get_response(uri)

        if res.is_a?(Net::HTTPSuccess)
            res.body
        else
            DEFAULT_EMOJI
        end
    end

    def self.raw_user(userid)
        uri = URI("#{host}/users.info/#{userid}")
        res = Net::HTTP.get_response(uri)

        data = JSON.parse(res.body)
        if res.is_a?(Net::HTTPSuccess)
            data
        else
            {}
        end
    end

    def self.resolve_username(userid)
        uri = URI("#{host}/users.info/#{userid}")
        res = Net::HTTP.get_response(uri)

        begin
            data = JSON.parse(res.body)
            if res.is_a?(Net::HTTPSuccess)
                data.dig("user", "name") || "unknown"
            else
                "unknown"
            end
        rescue
            "unavailable"
        end
    end

    def self.raw_channel(channelid)
        uri = URI("#{host}/conversations.info/#{channelid}")
        res = Net::HTTP.get_response(uri)

        data = JSON.parse(res.body)
        if res.is_a?(Net::HTTPSuccess)
            data
        else
            {}
        end
    end

    def self.resolve_channel(channelid)
        uri = URI("#{host}/conversations.info/#{channelid}")
        res = Net::HTTP.get_response(uri)

        begin
            data = JSON.parse(res.body)
            if res.is_a?(Net::HTTPSuccess)
                data.dig("channel", "name") || "unknown"
            else
                "unknown"
            end
        rescue
            "unavailable"
        end
    end
end
