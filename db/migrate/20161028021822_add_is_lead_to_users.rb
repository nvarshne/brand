class AddIsLeadToUsers < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :lead, :boolean, default: false
  end
end
