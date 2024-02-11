class RemoveTeamOwnerAndMemberFromAds < ActiveRecord::Migration[7.1]
  def change
    remove_column :ads, :teamMember_id
    remove_column :ads, :teamOwner_id
  end
end
