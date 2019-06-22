module API
  module V1
    module Entities
      class Base < Grape::Entity
        format_with(:date) { |date| date.strftime('%F') }
        format_with(:date_time) do |dt|
          case
            when dt.is_a?(DateTime), dt.is_a?(Time)
              dt.strftime('%FT%T')
            when dt.is_a?(Date)
              dt.strftime('%F')
            else
              begin
                dt.to_datetime.strftime('%Y-%m-%dT%H:%M:%S')
              rescue
                nil
              end
          end
        end
      end
    end
  end
end
