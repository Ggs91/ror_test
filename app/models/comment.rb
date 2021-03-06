class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :post
  has_many :likes, as: :likeable, dependent: :destroy

  validates_presence_of :content, message: "Content must be present"
end
