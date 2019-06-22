# Create users
User.create!(name: 'Mathew')
User.create!(name: 'Mark')
User.create!(name: 'Luke')
User.create!(name: 'John')

# Set some followers list
User.first.followers << [User.all - [User.first]].flatten
User.last.followers << [User.all - [User.last]].flatten

# Set some sleeping records
User.all.each do |user|
  2.times do
    check_in = DateTime.now - rand(7)
    user.sleeping_records.create!(check_in_time: check_in,
                                  check_out_time: check_in + rand(20).hours,
                                  date: check_in.to_date)
  end
end
