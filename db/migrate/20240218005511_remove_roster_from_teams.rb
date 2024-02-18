class RemoveRosterFromTeams < ActiveRecord::Migration[7.1]
  def change
    remove_column :teams, :roster
  end
end
