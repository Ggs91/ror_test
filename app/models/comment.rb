class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :posts

  validates_presence_of :content, message: "Content must be present"
end
