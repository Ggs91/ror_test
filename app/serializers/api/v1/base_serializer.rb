module Api
  module V1
    class BaseSerializer < ActiveModel::Serializer
      #The version of the serializer. Should be incremented
      # if the serializer is changed in a way that causes
      # the output to change
      class_attribute :version
      # The version starts at 1
      self.version = 1

      # Notice that this is a class method and is not overriding
      # the instance method from ActiveModel::Serializer
      #def self.cache_key
      #['version', self.version]
      #end
    end
  end
end
