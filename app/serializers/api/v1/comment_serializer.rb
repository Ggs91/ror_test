module Api
  module V1
    class CommentSerializer < Api::V1::BaseSerializer
      attributes :id, :content, :liked, :total_likes
      belongs_to :user
      belongs_to :post

      def liked
        object.likes.any? { |like| like.user_id == scope.id }
      end

      def total_likes
        object.likes_count
      end
    end
  end
end
