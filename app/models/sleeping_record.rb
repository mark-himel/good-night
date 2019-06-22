class SleepingRecord < ApplicationRecord
  belongs_to :user
  validates :date, :check_in_time, presence: true
  validates :date, uniqueness: { scope: %i(user check_in_time) }

  scope :weekly, lambda {
    where(date: (Date.today - 1.week)..Date.today)
  }

  def total_slept
    return unless check_out_time.present?

    seconds_diff = (check_in_time - check_out_time).to_i.abs

    hours = seconds_diff / 3600
    seconds_diff -= hours * 3600

    minutes = seconds_diff / 60
    seconds_diff -= minutes * 60

    seconds = seconds_diff

    "#{hours.to_s.rjust(2, '0')}:#{minutes.to_s.rjust(2, '0')}:#{seconds.to_s.rjust(2, '0')}"
  end

  def self.sort_by_duration_of_sleep
    weekly.all.sort_by(&:total_slept)
  end
end
