class AddModeToTeam < ActiveRecord::Migration[7.1]
  def change
    add_column :teams, :mode, :string
  end
end
