module Api
  module V1
    class StatusCreatedSerializer < Api::V1::BaseSerializer
      def attributes(*args)
        object.attributes.symbolize_keys
      end
    end
  end
end
