require "spec_helper"

describe "Post pages" do

  let(:user) { FactoryGirl.create(:user) }
  let!(:post1) { FactoryGirl.create(:post, :user => user, :title => "Post #1") }
  let!(:post2) { FactoryGirl.create(:post, :user => user, :title => "Post #2") }

  before do
    visit posts_path
  end
  subject { page }

  it { should have_selector "h1", :text => "Latest posts" }
  it { should have_button "Create new post" }

  describe "has post titles and links" do
    it { should have_content post1.title }
    it { should have_content post2.title }
    it { should have_link post1.title, :href => post_path(post1) }
    it { should have_link post2.title, :href => post_path(post2) }
  end

  describe "does not allow to create new post without signing in" do
    before { click_button "Create new post" }
    it { should have_selector "title", :text => "Sign in" }
    it { should have_selector "h1", :text => "Sign in" }
  end

  describe "allows creating new post if user is signed in" do
    before do
      sign_in user
      visit posts_path
      click_button "Create new post"
    end
    it { should have_selector "title", :text => "Create new post" }
    it { should have_selector "h1", :text => "Create new post" }

    describe "creates new post with valid info" do
      title = "Hello World!"
      body = "Sample body!"
      before do
        fill_in "Title", :with => title
        fill_in "Body",  :with => body
        click_button "Create new post"
      end
      it { should have_selector "div.alert.alert-success" }
      it { should have_content title }
      it { should have_content body  }
    end

    describe "does not create new post with invalid info" do
      before { click_button "Create new post" }
      it { should have_selector "div.alert.alert-error" }
      it { should have_selector "title", :text => "Create new post" }
      it { should have_selector "h1", :text => "Create new post" }
    end

  end

end
