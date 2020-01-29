class TeamMemberTeamLead < ApplicationRecord
  belongs_to :user
  belongs_to :team_member, class_name: 'User'
end
