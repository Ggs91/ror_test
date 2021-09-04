module Api
  class CommentSerializer < Api::BaseSerializer
    attributes :id, :content

    belongs_to :user, serializer: UserSerializer
    belongs_to :post, serializer: PostSerializer
  end
end
