FactoryGirl.define do
  check_in = DateTime.now - rand(7)
  factory :sleeping_record do
    user
    check_in_time { check_in }
    check_out_time { check_in + rand(20) }
    date { check_in.to_date }
  end
end
