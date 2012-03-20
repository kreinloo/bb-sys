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

class Post < ActiveRecord::Base

	attr_accessible :user_id, :title, :body

	belongs_to :user

	has_many :replies

	validates :user_id,
		presence: true

	validates :title,
		presence: true,
		length: { in: 3..255 }

	validates :body,
		presence: true

end
