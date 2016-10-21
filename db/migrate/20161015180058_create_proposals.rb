class CreateProposals < ActiveRecord::Migration[5.0]
  def change
    create_table :proposals do |t|
      t.text :summary
      t.text :description
      t.references :seller, foreign_key: true
      t.references :site, foreign_key: true

      t.timestamps # created_at, updated_at
    end
    add_index :proposals, [:seller_id, :created_at] # Multiple key index
  end
end
