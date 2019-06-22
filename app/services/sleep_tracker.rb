class SleepTracker
  attr_accessor :user

  def initialize(user)
    @user = user
  end

  def self.check_in(user)
    new(user).check_in
  end

  def self.check_out(user)
    new(user).check_out
  end

  def check_in
    return if user.is_sleeping?

    user.sleeping_records.create!(check_in_time: DateTime.now, date: Date.today)
  end

  def check_out
    return if user.is_awake?

    record = user.sleeping_records.last
    record.update!(check_out_time: DateTime.now) if record
    record
  end
end
