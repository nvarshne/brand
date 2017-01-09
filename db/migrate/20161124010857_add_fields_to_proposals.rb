class AddFieldsToProposals < ActiveRecord::Migration[5.0]
  def change
    add_column :proposals, :active, :boolean
    add_column :proposals, :first_to_market, :boolean
    add_column :proposals, :sponsored, :boolean
    add_column :proposals, :est_reach, :integer, limit: 8
    add_column :proposals, :min_price, :integer
    add_column :proposals, :max_price, :integer
    add_column :proposals, :support_doc, :string
    add_column :proposals, :integration, :string
    add_column :proposals, :types, :string
    add_column :proposals, :categories, :string
    add_column :proposals, :p_objective, :string
    add_column :proposals, :p_indicators, :string
    add_column :proposals, :s_objective, :string
    add_column :proposals, :s_indicators, :string
    add_column :proposals, :lead_time, :integer
    add_column :proposals, :flight_length, :integer
    add_column :proposals, :start_date, :timestamp
  end
end
