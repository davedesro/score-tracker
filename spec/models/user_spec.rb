require 'spec_helper'

describe User do

  before do
    @user = User.new(name: "Example User", first_name: "Example User", employee_id: "8",
                     password: "foobar", password_confirmation: "foobar", email: 'dike@example.com')
  end

  subject { @user }

  it { should respond_to(:authenticate) }
  it { should respond_to(:password) }
  it { should respond_to(:password_confirmation) }
  it { should respond_to(:remember_token) }

  it { should respond_to(:google_id) }
  it { should respond_to(:google_token) }
  it { should respond_to(:first_name) }
  it { should respond_to(:last_name) }
  it { should respond_to(:email) }
  it { should respond_to(:google_hd) }
  it { should respond_to(:google_image_url) }

  describe "validations" do

    it "should require an email" do
      User.new.should have(1).error_on :email
    end

    it "should have a first name" do
      User.new.should have(1).error_on :first_name
    end

    it "should have a valid email" do
      user = User.new(email: 'dave examplecom')
      user.should have(1).error_on :email
    end

    it "should have a unique email" do
      FactoryGirl.create(:user, email: 'hi@example.com')
      User.new(email: 'hi@example.com').should have(1).error_on :email
    end

    it "should require either a name or an employee id" do
      user = User.new
      user.should have(1).error_on :name
      user.should have(1).error_on :employee_id
    end

    it "should have a unique employee id" do
      User.create!(employee_id: "1", password: "foobar", password_confirmation: "foobar", first_name: "bla", email: 'bla@example.com')
      User.new(employee_id: "1").should have(1).error_on :employee_id
    end

    it "should have a proper employee id" do
      User.new(employee_id: "hi you").should have(1).error_on :employee_id
    end

    it "should have a unique name" do
      User.create!(name: "dave", password: "foobar", password_confirmation: "foobar", first_name: "bla", email: 'bla@example.com')
      User.new(name: "dave").should have(1).error_on :name
    end

    it "should have a unique case insensitive name" do
      User.create!(name: "dave", password: "foobar", password_confirmation: "foobar", first_name: "bla", email: 'bla@example.com')
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

  describe "remember token" do
    before { @user.save }
    its(:remember_token) { should_not be_blank }
  end
end
