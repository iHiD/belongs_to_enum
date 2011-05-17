require 'spec_helper'

describe "Belongs To Enum models" do

  it "constants should be set" do
    User.const_defined?("Role").should == true
  end
  
  it "constant has keys" do
    User::Role.should respond_to(:admin)
  end

end