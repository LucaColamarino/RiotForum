class CreateAds < ActiveRecord::Migration[7.1]
  def change
    create_table :ads do |t|
      t.string :game
      t.integer :size
      t.references :teamMember
      t.references :teamOwner

      t.timestamps
    end
  end
end
