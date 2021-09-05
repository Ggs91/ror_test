module Api
  module V1
    class CommentSerializer < Api::V1::BaseSerializer
      attributes :id, :content
      belongs_to :user
      belongs_to :post
    end
  end
end
