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

class Reply < ActiveRecord::Base

  attr_accessible :body, :post_id

  belongs_to :user

  belongs_to :post

  validates :user_id,
    presence: true

  validates :post_id,
    presence: true

  validates :body,
    presence: true

  default_scope :order => "replies.created_at ASC"

end
