module StringManipulation
    def self.uppercase(content)
        return content.upcase
    end

    def self.downcase(content)
        return content.downcase
    end

    def self.capitalize(content)
        return content.capitalize
    end

    def self.size(content)
        return content.size
    end
end

module ArgsParser
    def self.split_args(content)
        return content.split(" ; ").map(&:strip)
    end

    def self.eval_pipes_with_val(value, pipes)        
        for pipe in pipes
            substring_match = pipe.match(/\[(-?\d+)\:(-?\d+)\]/)
            if substring_match
                start_idx = substring_match[1].to_i
                end_idx = substring_match[2].to_i
                value = value[start_idx..end_idx]
            else
                value = StringManipulation.public_send(pipe, value)
            end
        end

        return value
    end

    def self.eval_pipes(arg)
        pipes = arg.split(" | ").map(&:strip)
        val = pipes.first
        pipes = pipes[1..-1]

        return self.eval_pipes_with_val(val, pipes)
    end

    def self.parse(content)
        args = self.split_args(content)
        post_pipes = args.map { |arg| self.eval_pipes(arg) }
        return post_pipes
    end
end