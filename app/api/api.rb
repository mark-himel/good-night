module API
  class Dispatch < Grape::API
    format :json
    include API::ExceptionHandling

    helpers do
      def permitted_params
        declared(params, include_missing: false)
      end
    end

    mount API::V1::Resources::Base

    route :any, '*path' do
      error!({ error: 'Not Found', details: "No such route '#{request.path}'", status: 404 }, 404)
    end
  end
end
