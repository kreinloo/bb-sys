require 'spec_helper'

describe "Authentication pages" do

  subject { page }

  describe "sign in" do

    before { visit signin_path }
    it { should have_selector "h1", :title => "Sign in" }
    it { should have_selector "title", :title => "Sign in" }

    describe "with invalid information" do
      before { click_button "Sign in"}
      it { should have_selector "title", :title => "Sign in" }
      it { should have_selector "div.alert.alert-error",
        :text => "Invalid" }
      describe "after visiting another page" do
        before { click_link "Home" }
        it { should_not have_selector "div.alert.alert-error" }
      end
    end

    describe "with valid information" do
      let(:user) { FactoryGirl.create(:user) }
      before do
        fill_in "Username", :with => user.name
        fill_in "Password", :with => user.password
        click_button "Sign in"
      end
      it { should have_selector("title", :title => user.name) }
      it { should have_link("Profile", :href => user_path(user)) }
      it { should have_link("Settings",
        :href => edit_user_path(user)) }
      it { should have_link("Sign out", :href => signout_path) }
      it { should_not have_link("Sign in", :href => signin_path) }
    end

  end

  describe "edit" do

    let(:user) { FactoryGirl.create(:user) }

    describe "visiting edit page" do

      describe "for not signed in user" do
        before { visit edit_user_path user }
        it { should have_selector "title", :title => "Sign in" }
        it { should_not have_selector "h1", :text => "Edit your profile" }
      end

      describe "for signed in user" do
        before do
          sign_in user
          visit edit_user_path(user)
        end

        it { should have_selector "h1", :text => "Edit your profile" }
        it { should have_button "Update profile" }

        describe "with wrong user" do
          let(:wrong_user) { FactoryGirl.create(:user,
            :name => "AnotherUser", :email => "another@mail.com") }

          describe "it should not allow editing" do
            before { visit edit_user_path wrong_user }
            it { should_not have_selector "title",
              :text => "Edit your profile" }
            it { should_not have_selector "h1", :text => "Edit your profile" }
          end

          describe "it should not allow PUT request" do
            before { put user_path(wrong_user) }
            specify { response.should redirect_to root_path }
          end
        end

      end

    end
  end

end
