class User < ApplicationRecord
  validates :name, presence: true, uniqueness: true
  has_and_belongs_to_many :followers,
                          class_name: 'User',
                          join_table: :followers,
                          foreign_key: :user_id,
                          association_foreign_key: :follower_id
  has_many :sleeping_records, -> { order(date: :asc) }

  def is_sleeping?
    sleeping_records.last&.check_out_time.nil?
  end

  def is_awake?
    sleeping_records.last&.check_out_time.present?
  end
end
