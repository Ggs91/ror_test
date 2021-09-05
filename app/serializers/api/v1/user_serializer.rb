module Api
  module V1
    class UserSerializer < Api::V1::BaseSerializer
      attributes :id
      attributes :last_name
      attributes :first_name
    end
  end
end
