class AddMinRanktoTeams < ActiveRecord::Migration[7.1]
  def change
    add_column :teams, :minRank, :string
  end
end
