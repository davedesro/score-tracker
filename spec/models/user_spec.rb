require 'spec_helper'

describe User do

  before do
    @user = User.new(name: "Example User", employee_id: "8",
                     password: "foobar", password_confirmation: "foobar")
  end

  subject { @user }

  it { should respond_to(:authenticate) }
  it { should respond_to(:password) }
  it { should respond_to(:password_confirmation) }

  describe "validations" do

    it "should require either a name or an employee id" do
      user = User.new
      user.should have(1).error_on :name
      user.should have(1).error_on :employee_id
    end

    it "should have a unique employee id" do
      User.create(employee_id: "1", password: "foobar", password_confirmation: "foobar")
      User.new(employee_id: "1").should have(1).error_on :employee_id
    end

    it "should have a proper employee id" do
      User.new(employee_id: "hi you").should have(1).error_on :employee_id
    end

    it "should have a unique name" do
      User.create(name: "dave", password: "foobar", password_confirmation: "foobar")
      User.new(name: "dave").should have(1).error_on :name
    end

    it "should have a unique case insensitive name" do
      User.create(name: "Dave", password: "foobar", password_confirmation: "foobar")
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

    it "should require a password and password confirmation" do
      user = User.new
      user.should have(2).error_on :password
    end

    it "should have a password that is at least 6 characters" do
      User.new(password: 'a'*5).should have(1).error_on :password
    end
  end
end
