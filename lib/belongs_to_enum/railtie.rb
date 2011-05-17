require 'rails'
require 'belongs_to_enum'

module BelongsToEnum
  class Railtie < Rails::Railtie
    railtie_name :belongs_to_enum
    
    config.to_prepare do
      ActiveRecord::Base.send(:extend, BelongsToEnum::Hook)
    end
  end
end
