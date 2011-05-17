class User < ActiveRecord::Base
  belongs_to_enum :role, [:normal, :admin, :superadmin, :suspended]
end

class Vehicle < ActiveRecord::Base
  belongs_to_enum :make, {:honda => 10, :toyota => 20, :ford => 30}
end