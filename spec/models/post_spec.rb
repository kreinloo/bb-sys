# == Schema Information
#
# Table name: posts
#
#  id         :integer         not null, primary key
#  user_id    :integer
#  title      :string(255)
#  body       :text
#  created_at :datetime        not null
#  updated_at :datetime        not null
#

require 'spec_helper'

describe Post do

  let(:user) { FactoryGirl.create(:user) }

  before do
    @post = user.posts.build(
      :title => "Sample post",
      :body => "This is a sample post"
    )
  end

  subject { @post }

  it { should respond_to :user_id }
  it { should respond_to :title }
  it { should respond_to :body }
  it { should be_valid }
  its(:user) { should == user }

  describe "when user_id is not present" do
    before { @post.user_id = nil }
    it { should_not be_valid }
  end

  describe "when title is not present" do
    before { @post.title = "" }
    it { should_not be_valid }
  end

  describe "when title is too short" do
    before { @post.title = "aa" }
    it { should_not be_valid }
  end

  describe "when title is too long" do
    before { @post.title = "a" * 256 }
    it { should_not be_valid }
  end

  describe "when body is not present" do
    before { @post.body = "" }
    it { should_not be_valid }
  end

  describe "accessible attributes" do
    it "should not allow access to user_id" do
      expect do
        Post.new(:user_id => user.id)
      end.should raise_error(ActiveModel::MassAssignmentSecurity::Error)
    end
  end

end
