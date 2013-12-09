class AddPeriodIdToGardes < ActiveRecord::Migration
  def change
    add_column :gardes, :period_id, :integer
    add_index :gardes, :period_id
  end
end
