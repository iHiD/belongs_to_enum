module BelongsToEnum
  module Hook
    def belongs_to_enum(name, keys)
          create_enum(name, keys)
      name = name.to_s
      class_eval <<-EOS
        def #{name}?
          #{name}_id.to_i > 0
        end

        def #{name}
          #{name.camelize}.display(#{name}_id)
        end
      EOS
    end
  end
end
