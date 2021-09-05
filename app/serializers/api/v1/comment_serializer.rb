module Api
  module V1
    class CommentSerializer < Api::V1::BaseSerializer
      attributes :id, :content

      belongs_to :user, serializer: UserSerializer
      belongs_to :post, serializer: PostSerializer
    end
  end
end
