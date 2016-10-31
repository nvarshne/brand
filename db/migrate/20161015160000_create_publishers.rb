class CreatePublishers < ActiveRecord::Migration[5.0]
  def change
    create_table :publishers do |t|
      t.string :name
      t.string :activation_digest
      t.boolean :activated, default: :false
      t.datetime :activated_at

      t.timestamps
    end
    add_index :publishers, :name, unique: true
  end
end
