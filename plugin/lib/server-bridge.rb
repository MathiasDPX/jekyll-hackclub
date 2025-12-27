require "net/http"
require "json"
require "uri"

module HackclubRequest
    DEFAULT_EMOJI = "https://emoji.slack-edge.com/T0266FRGM/alibaba-question/c5ba32ce553206b8.png" # :alibaba-question:
    @host = Jekyll.configuration({})['HACKCLUB_API'] || "https://hackclub.mathiasd.fr"

    class << self
        attr_accessor :host
    end

    def self.make_request(path)
        uri = URI("#{host}#{path}")
        req = Net::HTTP::Get.new(uri)
        req['Referer'] = "jekyll-hackclub"

        res = Net::HTTP.start(uri.hostname, uri.port, use_ssl: uri.scheme == "https") do |http|
            http.request(req)
        end

        return JSON.parse(res.body), res
    rescue JSON::ParserError
        return {}, res
    rescue => e
        warn "Request to #{uri} failed: #{e}"
        return {}, nil
    end

    def self.resolve_emoji(id)
        _, res = make_request("/emoji/#{id.strip}")
        res&.is_a?(Net::HTTPSuccess) ? res.body : DEFAULT_EMOJI
    end

    def self.raw_file(fileid)
        data, res = make_request("/files.info/#{fileid}")
        res&.is_a?(Net::HTTPSuccess) ? data : {}
    end

    def self.raw_user(userid)
        data, res = make_request("/users.info/#{userid}")
        res&.is_a?(Net::HTTPSuccess) ? data : {}
    end

    def self.raw_usergroup(groupid)
        data, res = make_request("/usergroup/#{groupid}")
        res&.is_a?(Net::HTTPSuccess) ? data : {}
    end

    def self.resolve_usergroup(groupid)
        data = raw_usergroup(groupid)
        data["handle"] || "unknown"
    end

    def self.resolve_username(userid)
        data, res = make_request("/users.info/#{userid}")
        res&.is_a?(Net::HTTPSuccess) ? (data.dig("user", "name") || "unknown") : "unknown"
    rescue
        "unavailable"
    end

    def self.raw_channel(channelid)
        data, res = make_request("/conversations.info/#{channelid}")
        res&.is_a?(Net::HTTPSuccess) ? data : {}
    end

    def self.resolve_channel(channelid)
        data, res = make_request("/conversations.info/#{channelid}")
        res&.is_a?(Net::HTTPSuccess) ? (data.dig("channel", "name") || "unknown") : "unknown"
    rescue
        "unavailable"
    end
end
