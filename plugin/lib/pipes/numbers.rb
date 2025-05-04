module NumbersManipulation
    def self.to_int(content, args)
        content.to_i
    end

    def self.multiply(content, args)
        content * args[0].to_i
    end

    def self.add(content, args)
        content + args[0].to_i
    end

    def self.substract(content, args)
        content - args[0].to_i
    end
end