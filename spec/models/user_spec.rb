require 'spec_helper'

describe User do

  describe "validations" do

    it "should require either a name or an employee id" do
      user = User.new
      user.should have(1).error_on :name
      user.should have(1).error_on :employee_id
    end

    it "should have a unique employee id" do
      User.create(employee_id: "1")
      User.new(employee_id: "1").should have(1).error_on :employee_id
    end

    it "should have a proper employee id" do
      User.new(employee_id: "hi you").should have(1).error_on :employee_id
    end

    it "should have a unique name" do
      User.create(name: "dave")
      User.new(name: "dave").should have(1).error_on :name
    end

    it "should have a unique case insensitive name" do
      User.create(name: "Dave")
      User.new(name: "dave").should have(1).error_on :name
    end

    it "should have a max length for the name" do
      User.new(name: "a" * 33).should have(1).error_on :name
    end

    it "should have a max length for the employee id" do
      User.new(employee_id: "1" * 5).should have(1).error_on :employee_id
    end

    it "should have a max length for the tagline" do
      User.new(tagline: "a" * 129).should have(1).error_on :tagline
    end
  end
end
