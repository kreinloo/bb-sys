require 'spec_helper'

describe "AuthenticationPages" do

  subject { page }

  describe "login page" do
    before { visit signin_path }
    it { should have_selector "h1", :title => "Sign in" }
    it { should have_selector "title", :title => "Sign in" }
  end

  describe "log in" do

    before { visit signin_path }

    describe "with invalid information" do
      before { click_button "Sign in"}
      it { should have_selector "title", :title => "Sign in" }
      it { should have_selector "div.alert.alert-error", :text => "Invalid" }

      describe "after visiting another page" do
        before { click_link "Home" }
        it { should_not have_selector "div.alert.alert-error" }
      end

    end

  end

end
