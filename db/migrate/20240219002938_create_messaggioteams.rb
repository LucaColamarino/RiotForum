class CreateMessaggioteams < ActiveRecord::Migration[7.1]
  def change
    create_table :messaggioteams do |t|
      t.integer :team_id
      t.text :text

      t.timestamps
    end
  end
end
