require_relative "./pipes/strings"
require_relative "./pipes/numbers"

module ArgsParser
    def self.split_args(content)
        content.split(" ; ").map(&:strip)
    end
    
    def self.eval_pipes_with_val(value, pipes)
        pipes.each do |pipe|
            args = pipe.split(" ") || []
            func = args.shift || pipe
            if (match = pipe.match(/\[(-?\d+):(-?\d+)\]/))
                start_idx, end_idx = match[1].to_i, match[2].to_i
                value = value[start_idx..end_idx]
            elsif StringManipulation.respond_to?(func)
                value = StringManipulation.public_send(func, value, args)
            elsif NumbersManipulation.respond_to?(func)
                value = NumbersManipulation.public_send(func, value, args)
            else
                raise ArgumentError, "Unkown function '#{func}'"
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