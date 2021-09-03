module Api
  class PostSerializer < Api::BaseSerializer

    attributes :id
    attributes :description
    belongs_to :user

  end
end
