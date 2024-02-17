class AddCompToTeams < ActiveRecord::Migration[7.1]
  def change
    add_column :teams, :comp, :string
  end
end
