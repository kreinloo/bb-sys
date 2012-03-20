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

	before do
		@post = Post.new(
			user_id: 1,
			title: "This is a sample post!",
			body: "This is a body of sample post!"
		)
	end

	subject { @post }

	it { should respond_to :user_id }
	it { should respond_to :title }
	it { should respond_to :body }
	it { should be_valid }

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

end
