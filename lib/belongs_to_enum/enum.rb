module BelongsToEnum
  class Enum
    def Enum.add_item(key,value)
      @hash ||= {}
      @hash[key]=value
    end

    def Enum.get_from_key(key)
      @hash[key]
    end

    def Enum.method_missing(key, *args)
      @hash[key] || super
    end

    def Enum.each
      @hash.each {|key,value| yield(key,value)}
    end

    def Enum.map
      @hash.map {|key,value| yield(key,value)}
    end

    def Enum.keys
      @hash.values
    end

    def Enum.items
      @hash.sort{|a,b| a[1]<=>b[1]}.map{|i|[i[0].to_s.gsub("_", " ").capitalize,i[1]]}
    end

    def Enum.get(value)
      @hash.key(value).to_s
    end

    def Enum.display(value)
      get(value).gsub("_", " ").titleize
    end

    def Enum.raw_hash
      @hash
    end

    def self.create(name, parent, keys)
      
      # Check to see if this has already been defined...
      return if parent.const_defined?(name.to_s.camelize)

      klass = Class.new(Enum)
      parent.const_set(name.to_s.camelize, klass)

      if keys.respond_to? :raw_hash
        keys.raw_hash.each do |k,v|
          klass.add_item(k,v)
        end

      elsif(keys.is_a? Hash)
        keys.each do |k,v|
          klass.add_item(k,v)
        end
      #elsif(keys.respond_to? :raw_hash)
      #  keys.send(:raw_hash).each do |k,v|
      #    klass.add_item(k,v)
      #  end
      else
        keys.each_with_index do |key, index|
          klass.add_item(key, index + 1)
        end
      end
    end
  end
end