class AddPublisherKeyToUsers < ActiveRecord::Migration[5.0]
  def change
    add_reference :users, :publisher
  end
end
