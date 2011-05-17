require 'spec_helper'

describe "Belongs To Enum models" do

  it "constants should be set" do
    User.const_defined?("Role").should == true
  end
  
  it "constant has keys" do
    User::Role.should respond_to(:admin)
  end
  
  it "keys should start at 1" do
    User::Role.normal.should == 1
  end

  it "keys should respect hash values" do
    Vehicle::Make.honda.should == 10
  end
  
  it "keys can be iterated through" do
    User::Role.each do |role, role_id|
      role.should == :normal
      role_id.should == 1
      break
    end
  end

end