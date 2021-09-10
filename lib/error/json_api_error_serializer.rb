module Error
  class JsonApiErrorSerializer
    include Helpers::StringFormatter

    attr_reader :exception, :code, :status, :extra

    def initialize(exception, code, status, extra={})
      @exception = exception
      @code = code
      @status = status
      @extra = extra
    end

    def to_json
      json_api_errors_hash.to_json
    end

    private

    def json_api_errors_hash
      {
        errors: [
          {
            status: status,
            title: title,
            detail: detail,
            code: code
          }.merge(extra)
        ]
      }
    end

    def status
      Rack::Utils::SYMBOL_TO_STATUS_CODE[@status] if @status.is_a? Symbol
    end

    def title
      nested_class_name = @exception.class.to_s
      camelized_class_name = delete_module_prefix(nested_class_name)
      insert_spaces(camelized_class_name)
    end

    def detail
      @exception.respond_to?(:record) ? @exception.record.errors.full_messages : @exception.message
    end

    def code
      @code
    end
  end
end
