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

	before do
		@reply = Reply.new(
			user_id: 1,
			post_id: 1,
			body: "This is a reply to a sample post."
		)
	end

	subject { @reply }

	it { should respond_to :user_id }
	it { should respond_to :post_id }
	it { should respond_to :body }
	it { should be_valid }

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

end
