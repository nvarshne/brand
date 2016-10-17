class CreateProposals < ActiveRecord::Migration[5.0]
  def change
    create_table :proposals do |t|
      t.text :summary
      t.references :user, foreign_key: true

      t.timestamps # rails created_at, updated_at
    end
    add_index :proposals, [:user_id, :created_at] # Multiple key index
  end
end
