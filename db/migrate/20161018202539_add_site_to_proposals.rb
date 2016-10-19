class AddSiteToProposals < ActiveRecord::Migration[5.0]
  def change
    add_reference :proposals, :site, foreign_key: true
  end
end
