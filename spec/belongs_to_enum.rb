require 'spec_helper'

describe "Belongs To Enum models" do

  it "constants should be set" do
    klass = Class.new(ActiveRecord::Base)
    klass.class_exec do
      belongs_to_enum :role, [:normal]
    end
    
    klass.const_defined?("Role").should be_true
  end
  
  it "constant has keys" do
    klass = Class.new(ActiveRecord::Base)
    klass.class_exec do
      belongs_to_enum :role, [:normal]
    end
    klass::Role.should respond_to(:normal)
  end
  
  it "keys should start at 1" do
    klass = Class.new(ActiveRecord::Base)
    klass.class_exec do
      belongs_to_enum :role, [:normal]
    end
    klass::Role.normal.should == 1
  end
  
  it "can check to see if a key is valid" do
    klass = Class.new(ActiveRecord::Base)
    klass.class_exec do
      belongs_to_enum :role, [:normal]
    end
    klass::Role.valid?(1).should be_true
    klass::Role.valid?(2).should be_false
  end
  
  it "has a default value" do
    klass = Class.new(ActiveRecord::Base)
    klass.class_exec do
      belongs_to_enum :role1, [:normal]
      belongs_to_enum :role2, {:normal => 10}
    end
    klass::Role1.default.should == 1
    klass::Role2.default.should == 10
  end

  it "keys should respect hash values" do
    klass = Class.new(ActiveRecord::Base)
    klass.class_exec do
      belongs_to_enum :role, {:normal => 10, :admin => 20}
    end
    klass::Role.normal.should == 10
    klass::Role.admin.should == 20
  end
  
  it "keys can be iterated through" do
    klass = Class.new(ActiveRecord::Base)
    klass.class_exec do
      belongs_to_enum :role, [:normal, :admin]
    end
    i = 1
    klass::Role.each do |role, role_id|
      role.should == (i == 1 ? :normal : :admin)
      role_id.should == i
      i += 1
    end
  end
  
  it "has items_for_select" do
    klass = Class.new(ActiveRecord::Base)
    klass.class_exec do
      belongs_to_enum :role, [:normal]
    end
    klass::Role.items_for_select.first[0].should == "Normal"
    klass::Role.items_for_select.first[1].should == 1
  end
  
  it "has depreciated items method that maps to items_for_select" do
    klass = Class.new(ActiveRecord::Base)
    klass.class_exec do
      belongs_to_enum :role, [:normal]
    end
    klass::Role.items.first[0].should == "Normal"
    klass::Role.items.first[1].should == 1
  end
  
  it "can get item from id" do
    klass = Class.new(ActiveRecord::Base)
    klass.class_exec do
      belongs_to_enum :role, [:normal]
    end
    klass::Role.get(1).should == :normal
  end

  it "pretty displays item" do
    klass = Class.new(ActiveRecord::Base)
    klass.class_exec do
      belongs_to_enum :role, [:normal]
    end
    klass::Role.display(1).should == "Normal"
  end
  
  it "can access raw hash" do
    klass = Class.new(ActiveRecord::Base)
    klass.class_exec do
      belongs_to_enum :role, [:normal]
    end
    klass::Role.raw_hash.is_a?(Hash)
    klass::Role.raw_hash.keys[0].should == :normal
    klass::Role.raw_hash.values[0].should == 1
  end
  
  it "can create scopes when requested" do
    ActiveRecord::Schema.define(:version => 1) do
      create_table :scope_checkers do |t|
        t.integer :role_id, :null => false
      end
    end

    klass = Class.new(ActiveRecord::Base)
    klass.class_exec do
      set_table_name "scope_checkers"
      scope :sanity_scope, where(:sanity_scope_id => 1)
      belongs_to_enum :role1, [:normal], :create_scopes => true
      belongs_to_enum :role2, [:admin]
    end
    klass.should respond_to("sanity_scope")
    klass.should respond_to("normals")
    klass.should_not respond_to("admins")
    
    klass.method("normals").source_location.should == klass.method("sanity_scope").source_location
    klass.send("normals").to_sql.strip.should == 'SELECT "scope_checkers".* FROM "scope_checkers"'
  end
  

end