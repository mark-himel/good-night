module API
  module V1
    module Resources
      class Base < Grape::API
        mount Resources::Users
      end
    end
  end
end
