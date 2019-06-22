module API
  module V1
    module Entities
      class User < Entities::Base
        expose :id
        expose :name
        expose :followers, using: Entities::Follower
        expose :following, using: Entities::Follower
      end
    end
  end
end
