class CreateInvitations < ActiveRecord::Migration[5.0]
  def change
    create_table :invitations do |t|
      t.string :email
      t.references :publisher, foreign_key: true

      t.timestamps
    end
    add_index :invitations, :email
  end
end
