class CreateNotificas < ActiveRecord::Migration[7.1]
  def change
    create_table :notificas do |t|
      t.string :from
      t.string :to
      t.text :content
      t.boolean :read

      t.timestamps
    end
  end
end
