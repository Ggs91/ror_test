module Error
  module Helpers
    module StringFormatter
      def delete_module_prefix(nested_class_name)
        nested_class_name.gsub!(/.*?(?=::)/im, "").delete_prefix("::")
      end

      def insert_spaces(camelized_class_name)
        camelized_class_name.gsub(/[A-Z]/, ' \0').strip
      end
    end
  end
end
