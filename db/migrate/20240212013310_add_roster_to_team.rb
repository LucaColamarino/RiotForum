class AddRosterToTeam < ActiveRecord::Migration[7.1]
  def change
    #
    add_column :teams, :roster, :string, default: ""
  end
end
