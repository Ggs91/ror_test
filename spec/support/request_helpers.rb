module Requests
  module JsonHelpers
    def response_body
      JSON.parse(response.body)
    end
  end

  module ObjectsCreator
    def authenticate
      User.create
    end
  end
end
