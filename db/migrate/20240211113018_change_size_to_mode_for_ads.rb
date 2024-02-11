class ChangeSizeToModeForAds < ActiveRecord::Migration[7.1]
  def change
    rename_column :ads, :size, :mode
    change_column :ads, :mode, :string
  end
end
