class AddLanesToTeams < ActiveRecord::Migration[7.1]
  def change
    add_column :teams, :lanes, :string
  end
end
