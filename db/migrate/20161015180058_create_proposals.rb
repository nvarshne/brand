class CreateProposals < ActiveRecord::Migration[5.0]
  def change
    create_table :proposals do |t|
      t.text :summary
      t.text :description
      t.references :user, foreign_key: true
      t.references :site, foreign_key: true

      t.timestamps # created_at, updated_at
    end
    add_index :proposals, [:user_id, :created_at] # Multiple key index
  end
end
