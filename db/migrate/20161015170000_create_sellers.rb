class CreateSellers < ActiveRecord::Migration[5.0]
  def change
    create_table :sellers do |t|
      t.references :user, foreign_key: true
      t.references :publisher, foreign_key: true

      t.timestamps
    end
  end
end
