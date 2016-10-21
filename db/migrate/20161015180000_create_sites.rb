class CreateSites < ActiveRecord::Migration[5.0]
  def change
    create_table :sites do |t|
      t.references :publisher, foreign_key: true
      t.string :name
      t.string :url

      t.timestamps
    end
  end
end
