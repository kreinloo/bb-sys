require "spec_helper"
require "capybara/rails"

describe "User pages" do

  subject { page }
  let(:user) { FactoryGirl.create(:user) }

  describe "sign up" do
    before { visit signup_path }
    let(:submit) { "Create account" }

    it { should have_selector("h1", :text => "Sign up") }
    it { should have_selector("title", :text => "Sign up") }

    describe "with invalid information" do
      it "should not create new user" do
        expect { click_button submit }.not_to change(User, :count)
      end
    end

    describe "with valid information" do
      before do
        fill_in "Name", :with => "NewUser"
        fill_in "Email", :with => "mail@asd.com"
        fill_in "Password", :with => "superSecure"
        fill_in "Password confirmation", :with => "superSecure"
      end

      it "should create new user" do
        expect { click_button submit }.to change(User, :count).by(1)
        should have_link "Sign out", :href => signout_path
      end

      describe "followed by sign out" do
        before do
          click_button submit
          click_link "Sign out"
        end
        it { should have_link "Sign in" }
        it { should_not have_link "Sign out" }
      end

    end

  end

  describe "profile" do

    before { visit user_path(user) }

    describe "has selectors" do
      it { should have_selector("h1", :text => user.name) }
      it { should have_selector("title", :text => user.name) }
      it { should have_selector("h3", :text => user.email) }
    end

  end

  describe "edit" do

    before do
      visit edit_user_path user
      sign_in user
    end

    describe "view has selectors" do
      it { should have_selector "title", :text => "Edit your profile" }
      it { should have_selector "h1", :text => "Edit your profile" }
      it { should have_link "Sign out", :href => signout_path }
    end

    describe "with invalid information" do
      before { click_button "Update profile" }
      it { should have_selector "div.alert.alert-error" }
    end

    describe "with valid information" do
      let(:new_email) { "newmail@asd.com" }
      let(:new_password) { "mynewpassword" }

      before do
        fill_in "Email", :with => new_email
        fill_in "Password", :with => new_password
        fill_in "Password confirmation", :with => new_password
        click_button "Update profile"
      end

      it { should have_selector "div.alert.alert-success"}
      specify { user.reload.email.should == new_email }
    end
  end

end
