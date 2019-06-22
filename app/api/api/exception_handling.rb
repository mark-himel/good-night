module API
  module ExceptionHandling
    extend ActiveSupport::Concern
    included do
      rescue_from Grape::Exceptions::ValidationErrors do |error|
        Rack::Response.new({ status: 422, message: error.full_messages }.to_json, 422)
      end

      rescue_from ActiveRecord::RecordInvalid do |error|
        Rack::Response.new({ status: 404, message: error.record.errors.full_message }.to_json, 404)
      end

      rescue_from ActiveRecord::RecordNotFound do |error|
        Rack::Response.new({ status: 404, message: error.message }.to_json, 404)
      end

      rescue_from Exception do |error|
        Rack::Response.new({ status: 500, message: error.full_message }.to_json, 500)
      end
    end
  end
end
