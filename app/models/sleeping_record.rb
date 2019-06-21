class SleepingRecord < ApplicationRecord
  belongs_to :user
  validates :date, :check_in_time, presence: true
  validates :date, uniqueness: { scope: %i(user check_in_time) }
  delegate :is_sleeping?, :is_awake?, to: :user, prefix: true

  scope :weekly, lambda {
    where(date: (Date.today - 1.week)..Date.today)
  }
end
