require 'spec_helper'

describe "Belongs To Enum models" do

  it "constants should be set" do
    User.const_defined?("Role").should be_true
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
  
  it "has items_for_select" do
    User::Role.items_for_select.first[0].should == "Normal"
    User::Role.items_for_select.first[1].should == 1
  end
  
  it "has depreciated items method that maps to items_for_select" do
    User::Role.items.first[0].should == "Normal"
    User::Role.items.first[1].should == 1
  end
  
  it "can get item from id" do
    User::Role.get(1).should == :normal
  end

  it "pretty displays item" do
    User::Role.display(1).should == "Normal"
  end
  
  it "can access raw hash" do
    User::Role.raw_hash.is_a?(Hash)
    User::Role.raw_hash.keys[0].should == :normal
    User::Role.raw_hash.values[0].should == 1
  end
  

end