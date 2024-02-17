class CreateTeams < ActiveRecord::Migration[7.1]
  def change
    create_table :teams do |t|

      t.references :leader, foreign_key: { to_table: :users }, null:false

      t.timestamps
    end
  end
end
