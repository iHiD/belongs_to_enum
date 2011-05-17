class User < ActiveRecord::Base
  
  belongs_to_enum :role, [:normal, :admin, :superadmin, :suspended]
  
end