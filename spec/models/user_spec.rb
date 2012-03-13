# == Schema Information
#
# Table name: users
#
#  id         :integer         not null, primary key
#  username   :string(255)
#  email      :string(255)
#  created_at :datetime        not null
#  updated_at :datetime        not null
#

require 'spec_helper'

describe User do

	before do
		@user = User.new(username: "test_user",
			email: "mail@example.org",
			password: "password123",
			password_confirmation: "password123")
	end

	subject { @user }

	it { should respond_to(:username) }
	it { should respond_to(:email) }
	it { should respond_to(:password_digest) }
	it { should respond_to(:password) }
	it { should respond_to(:password_confirmation) }
	it { should respond_to(:authenticate) }
	it { should be_valid }

	describe "when name is not present" do
		before { @user.username = " " }
		it { should_not be_valid }
	end

	describe "when email is not present" do
		before { @user.email = " " }
		it { should_not be_valid }
	end

	describe "when name is too long" do
		before { @user.username = "a" * 21 }
		it { should_not be_valid }
	end

	describe "when name is too short" do
		before { @user.username = "a" * 2 }
		it { should_not be_valid }
	end

	describe "when email is invalid" do
		addresses = ["asd@asd,com", "a_sd.com", "user@foo"]
		addresses.each do |address|
			before { @user.email = address }
			it { should_not be_valid }
		end
	end

	describe "when email is valid" do
		addresses = ["foo@bar.com", "x@ampl.net", "first.last@dom.org"]
		addresses.each do |address|
			before { @user.email = address }
			it { should be_valid }
		end
	end

	describe "when email is taken" do
		before do
			another_user = @user.dup
			another_user.email = @user.email.upcase
			another_user.save
		end
		it { should_not be_valid }
	end

	describe "when password is not present" do
		before { @user.password = @user.password_confirmation = " " }
		it { should_not be_valid }
	end

	describe "when password does not match confirmation" do
		before { @user.password_confirmation = "something_else" }
		it { should_not be_valid }
	end

	describe "when password confirmation is nil" do
		before { @user.password_confirmation = nil }
		it { should_not be_valid }
	end

	describe "with password that's too short" do
		before { @user.password = @user.password_confirmation = "a" * 5 }
		it { should_not be_valid }
	end

	describe "return value of authenticate method" do
		before { @user.save }
		let(:found_user) { User.find_by_username(@user.username) }

		describe "with valid password" do
			it { should == found_user.authenticate(@user.password) }
		end

		describe "with invalid password" do
			let(:user_for_invalid_password) { found_user.authenticate("invalid_password") }
			it { should_not ==  user_for_invalid_password }
			specify { user_for_invalid_password.should be_false }
		end
	end

end
