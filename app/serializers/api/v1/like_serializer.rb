module Api
  module V1
    class LikeSerializer < Api::V1::BaseSerializer
      attributes :id
      belongs_to :user
      belongs_to :likeable, polymorphic: true
    end
  end
end
