module API
  module V1
    module Entities
      class Follower < Entities::Base
        expose :id
        expose :name
      end
    end
  end
end
