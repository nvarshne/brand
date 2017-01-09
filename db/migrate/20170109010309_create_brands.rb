class CreateBrands < ActiveRecord::Migration[5.0]
  def change
    create_table :brands do |t|
      t.references :buy_org, foreign_key: true
      t.string :name

      t.timestamps
    end
  end
end
