module API
  module V1
    module Entities
      class Friend < Entities::Base
        expose :id
        expose :name
        expose :weekly_sleeping_records, using: Entities::SleepingRecord

        def weekly_sleeping_records
          object.sleeping_records.sort_by_duration_of_sleep
        end
      end
    end
  end
end
