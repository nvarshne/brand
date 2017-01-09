class AddBuyOrgIdToUsers < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :buy_org_id, :integer
  end
end
