require "jekyll"
require_relative "../server-bridge"
require_relative "../args-parser"

module Jekyll
    class HackclubParser < Liquid::Tag
        def initialize(tagName, content, tokens)
            super
            @content = content
        end

        def render(context)
            %Q{#{ArgsParser.parse(@content)}}
        end
    end

    Liquid::Template.register_tag "_parser", HackclubParser
end
