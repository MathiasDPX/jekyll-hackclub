require "jekyll"
require_relative "../server-bridge"

module Jekyll
    class HackclubFileTag < Liquid::Tag
        def initialize(tagName, content, tokens)
            super
            content = content.strip()
            @id, keys, pipes = ArgsParser.split_args(content)
            pipes = pipes || ""
            keys = keys || ""
            keys = keys.split(".")

            if keys == []
                rawfile = HackclubRequest.raw_file(@id).dig("file")
                permalink = rawfile.dig("permalink")
                name = rawfile.dig("name")
                @data = '<a href="'+permalink+'" class="hackclub-file" target="_blank">'+name+'</a>'
            else
                @data = HackclubRequest.raw_file(@id).dig("file").dig(*keys)
                @data = ArgsParser.eval_pipes_with_val(@data, pipes.split(" | ").map(&:strip))
            end
        end

        def render(context)
            if @data == nil
                %Q{null}
            else
                %Q{#{@data}}
            end
        end
    end

    Liquid::Template.register_tag "file", HackclubFileTag
end
