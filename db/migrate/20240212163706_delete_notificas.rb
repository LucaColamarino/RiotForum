class DeleteNotificas < ActiveRecord::Migration[7.1]
  def change
    drop_table :notificas
  end
end
