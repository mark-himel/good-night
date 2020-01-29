class User < ApplicationRecord
  validates :name, presence: true, uniqueness: true
  has_and_belongs_to_many :followers,
                          class_name: 'User',
                          join_table: :followers,
                          foreign_key: :user_id,
                          association_foreign_key: :follower_id
  has_and_belongs_to_many :following,
                          class_name: 'User',
                          join_table: :followers,
                          foreign_key: :follower_id,
                          association_foreign_key: :user_id
  has_many :team_member_team_leads
  has_many :team_members, through: :team_member_team_leads, source: :team_member
  has_many :sleeping_records, -> { order(date: :asc) }

  def is_sleeping?
    sleeping_records.last&.check_out_time.nil?
  end

  def is_awake?
    sleeping_records.last&.check_out_time.present?
  end

  def friends
    # The concept of friends would mean if they both have followed each other
    following & followers
  end

  def team_leads
    User.where(id: TeamMemberTeamLead.where(team_member_id: id).pluck(:user_id))
  end
end
