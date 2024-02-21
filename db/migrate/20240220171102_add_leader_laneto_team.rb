class AddLeaderLanetoTeam < ActiveRecord::Migration[7.1]
  def change
    add_column :teams, :leader_lane, :string
  end
end
