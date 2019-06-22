module API
  module V1
    module Entities
      class SleepingRecord < Entities::Base
        expose :user_id
        with_options(format_with: :date_time) do
          expose :check_in_time
          expose :check_out_time
        end
        with_options(format_with: :date) do
          expose :date
        end
        expose :total_slept

        def user_id
          object.user.id
        end
      end
    end
  end
end
