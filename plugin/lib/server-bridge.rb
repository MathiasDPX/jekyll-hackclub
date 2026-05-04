require "net/http"
require "json"
require "uri"

module HackclubRequest
    DEFAULT_EMOJI = "https://cdn.hackclub.com/019ce841-fe66-72e6-bb16-d57a93ac574f/alibaba-question.png" # :alibaba-question:
    @host = Jekyll.configuration({})['HACKCLUB_API'] || "https://hackclub.mathiasd.fr"
    DEFAULT_RETRIES = 3
    RETRYABLE_STATUS_CODES = [408, 425, 429, 500, 502, 503, 504].freeze

    class << self
        attr_accessor :host
    end

    def self.make_request(path, retries: DEFAULT_RETRIES, base_delay: 0.25)
        uri = URI("#{host}#{path}")
        attempts = 0

        while attempts < retries
            attempts += 1

            begin
                req = Net::HTTP::Get.new(uri)
                req['Referer'] = "jekyll-hackclub"

                res = Net::HTTP.start(uri.hostname, uri.port, use_ssl: uri.scheme == "https", open_timeout: 3, read_timeout: 6) do |http|
                    http.request(req)
                end

                if RETRYABLE_STATUS_CODES.include?(res.code.to_i)
                    sleep(base_delay * attempts) if attempts < retries
                    next
                end

                return JSON.parse(res.body), res
            rescue JSON::ParserError
                return {}, res
            rescue => e
                if attempts < retries
                    sleep(base_delay * attempts)
                    next
                end

                warn "Request to #{uri} failed after #{attempts} attempts: #{e}"
                return {}, nil
            end
        end

        return {}, nil
    end

    def self.get_emoji_url(id)
        return "#{host}/emoji/#{id.strip}"
    end

    def self.get_pfp_url(id, quality)
        return "#{host}/profile.picture/#{id.strip}?q=#{quality}"
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
