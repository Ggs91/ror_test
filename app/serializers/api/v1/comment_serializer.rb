module Api
  module V1
    class CommentSerializer < Api::V1::BaseSerializer
      attributes :id, :content, :liked
      belongs_to :user
      belongs_to :post

      def liked
        object.likes.any? { |like| like.user_id == scope.id }
      end
    end
  end
end
