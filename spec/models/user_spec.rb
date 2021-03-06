# == Schema Information
#
# Table name: users
#
#  id              :integer         not null, primary key
#  name            :string(255)
#  email           :string(255)
#  created_at      :datetime        not null
#  updated_at      :datetime        not null
#  password_digest :string(255)
#  remember_token  :string(255)
#

require 'spec_helper'

describe User do

  before do
    @user = User.new(
      name: "test_user",
      email: "mail@example.org",
      password: "password123",
      password_confirmation: "password123"
    )
  end

  subject { @user }

  it { should respond_to(:name) }
  it { should respond_to(:email) }
  it { should respond_to(:password_digest) }
  it { should respond_to(:password) }
  it { should respond_to(:password_confirmation) }
  it { should respond_to(:authenticate) }
  it { should respond_to(:remember_token)}
  it { should be_valid }

  describe "when name is not present" do
    before { @user.name = " " }
    it { should_not be_valid }
  end

  describe "when email is not present" do
    before { @user.email = " " }
    it { should_not be_valid }
  end

  describe "when name is too long" do
    before { @user.name = "a" * 21 }
    it { should_not be_valid }
  end

  describe "when name is too short" do
    before { @user.name = "a" * 2 }
    it { should_not be_valid }
  end

  describe "when name is invalid" do
    names = ["a a", "aaa___", "12name", "test-user-"]
    names.each do |name|
      before { @user.name = name }
      it { should_not be_valid }
    end
  end

  describe "when name is valid" do
    names = ["test-user", "testuser12", "testuser_2", "t-estuser"]
    names.each do |name|
      before { @user.name = name }
      it { should be_valid }
    end
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
    let(:found_user) { User.find_by_name(@user.name) }

    describe "with valid password" do
      it { should == found_user.authenticate(@user.password) }
    end

    describe "with invalid password" do
      let(:user_for_invalid_password) { found_user.authenticate("invalid_password") }
      it { should_not ==  user_for_invalid_password }
      specify { user_for_invalid_password.should be_false }
    end
  end

  describe "remember token" do
    before { @user.save }
    its(:remember_token) { should_not be_blank }
  end

  describe "post associations" do

    before { @user.save }
    let!(:older_post) do
      FactoryGirl.create(:post, :user => @user, :created_at => 1.day.ago)
    end
    let!(:newer_post) do
      FactoryGirl.create(:post, :user => @user, :created_at => 1.hour.ago)
    end

    it "shoud have posts in right order" do
      @user.posts.should == [ newer_post, older_post ]
    end

  end

  describe "reply associations" do
    before do
      @user.save
      @post = FactoryGirl.create(:post, :user => @user)
    end
    let!(:older_reply) do
      FactoryGirl.create(
        :reply,
        :user => @user,
        :post => @post,
        :created_at => 1.day.ago)
    end
    let!(:newer_reply) do
      FactoryGirl.create(
        :reply,
        :user => @user,
        :post => @post,
        :created_at => 1.hour.ago)
    end
    it "should have replies in right order" do
      @user.replies.should == [ older_reply, newer_reply ]
    end
  end

end
