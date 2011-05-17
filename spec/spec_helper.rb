ENV["RAILS_ENV"] ||= 'test'

require 'rails'
require 'rspec-rails'
require 'active_record'

$:.unshift File.dirname(__FILE__) + '/../lib'

# Thie first line isn't working so I have added the second...
require File.dirname(__FILE__) + '/../lib/belongs_to_enum'
ActiveRecord::Base.send(:extend, BelongsToEnum::Hook)
 
ActiveRecord::Base.establish_connection(:adapter => "sqlite3", :database => ":memory:")
 
# AR keeps printing annoying schema statements
$stdout = StringIO.new

ActiveRecord::Base.logger
ActiveRecord::Schema.define(:version => 1) do
end

require 'test_classes'