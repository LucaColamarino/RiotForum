class CreateUser < ActiveRecord::Migration[6.1]
  def change
    create_table :users do |t|
      t.name 'string'
      t.surname integer
      t.timestamps
    end
  end
end
