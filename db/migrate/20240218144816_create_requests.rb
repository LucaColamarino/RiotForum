class CreateRequests < ActiveRecord::Migration[7.1]
  def change
    create_table :requests do |t|

      t.string :position
      t.references :team
      t.references :user
      t.timestamps
    end
  end
end
