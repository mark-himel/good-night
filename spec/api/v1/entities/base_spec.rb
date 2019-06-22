require 'rails_helper'

RSpec.describe API::V1::Entities::Base do
  let(:klass) do
    Class.new(API::V1::Entities::Base) do
      with_options(format_with: :date) do
        expose :date
      end

      def date
        Date.today
      end
    end
  end

  subject { JSON.parse(klass.represent({}).to_json) }

  describe 'date formatter' do
    it 'formats a date correctly' do
      expect(subject['date']).to match(/\A\d{4}-\d{2}-\d{2}\z/)
    end
  end
end
