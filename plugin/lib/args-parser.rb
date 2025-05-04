module StringManipulation
    def self.uppercase(content)
        content.upcase
    end

    def self.downcase(content)
        content.downcase
    end

    def self.capitalize(content)
        content.capitalize
    end

    def self.size(content)
        content.size
    end
end

module ArgsParser
    def self.split_args(content)
        content.split(" ; ").map(&:strip)
    end
    
    def self.eval_pipes_with_val(value, pipes)
        pipes.each do |pipe|
            if (match = pipe.match(/\[(-?\d+):(-?\d+)\]/))
                start_idx, end_idx = match[1].to_i, match[2].to_i
                value = value[start_idx..end_idx]
            elsif StringManipulation.respond_to?(pipe)
                value = StringManipulation.public_send(pipe, value)
            else
                raise ArgumentError, "Unkown pipe '#{pipe}'"
            end
        end
        value
    end

    def self.eval_pipes(arg)
        parts = arg.split(" | ").map(&:strip)
        value = parts.shift
        eval_pipes_with_val(value, parts)
    end

    def self.parse(content)
        split_args(content).map { |arg| eval_pipes(arg) }
    end
end