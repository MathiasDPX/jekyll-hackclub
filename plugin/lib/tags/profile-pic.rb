require "jekyll"
require_relative "../server-bridge"

module Jekyll
    class HackclubPFP < Liquid::Tag
        def initialize(tagName, content, tokens)
            super
            if content.strip =~ /^(U\w+)(?:@(.+))?$/
                id = Regexp.last_match(1)
                data = HackclubRequest.raw_user(id)
                @resolution = Regexp.last_match(2) || "original"

                @img_url = data.dig("user", "profile", "image_"+@resolution)
                @name = data.dig("user", "name")
            else
                raise ArgumentError, "Invalid profilepic tag format: #{content}"
            end
        end

        def render(context)
            %Q{<img src="#{@img_url}" title="#{@name}'s profile picture" alt="#{@name}'s profile picture" class="hackclub-pfp res-#{@resolution}">}
        end
    end

    Liquid::Template.register_tag "profilepic", HackclubPFP
end
