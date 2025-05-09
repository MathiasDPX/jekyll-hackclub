module ArraysManipulation
    def self.first(content, args)
        content = content.first
    end

    def self.last(content, args)
        content = content.last
    end

    def self.get(content, args)
        content = content[args[0]]
    end

    def self.cut(content, args)
        content = content[args[0]..args[1]]
    end
end