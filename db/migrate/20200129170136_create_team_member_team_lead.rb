class CreateTeamMemberTeamLead < ActiveRecord::Migration[5.2]
  def change
    create_table :team_member_team_leads do |t|
      t.belongs_to :user
      t.belongs_to :team_member
      t.index %i(user_id team_member_id), unique: true, name: 'lead_member_index'
    end
  end
end
