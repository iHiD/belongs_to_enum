class User < ActiveRecord::Base
  
  belongs_to_enum :role, [:user, :admin, :superadmin, :suspended]
  
end