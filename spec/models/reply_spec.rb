# == Schema Information
#
# Table name: replies
#
#  id         :integer         not null, primary key
#  user_id    :integer
#  post_id    :integer
#  body       :text
#  created_at :datetime        not null
#  updated_at :datetime        not null
#

require 'spec_helper'

describe Reply do

  let(:user) { FactoryGirl.create(:user) }
  let(:post) { FactoryGirl.create(:post, :user => user) }

  before do
    @reply = FactoryGirl.create(
      :reply,
      :user => user,
      :post => post)
  end

  subject { @reply }

  it { should respond_to :user_id }
  it { should respond_to :post_id }
  it { should respond_to :body }
  it { should be_valid }
  its(:user) { should == user }
  its(:post) { should == post }

  describe "when user_id is not present" do
    before { @reply.user_id = nil }
    it { should_not be_valid }
  end

  describe "when post_id is not present" do
    before { @reply.post_id = nil }
    it { should_not be_valid }
  end

  describe "when body is not present" do
    before { @reply.body = nil }
    it { should_not be_valid }
  end

  describe "accessible attributes" do
    it "should not allow access to user_id" do
      expect do
        Reply.new(:user_id => user.id)
      end.should raise_error(ActiveModel::MassAssignmentSecurity::Error)
    end
  end

end
