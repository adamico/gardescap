class AddStateToPeriods < ActiveRecord::Migration
  def change
    add_column :periods, :state, :string
  end
end
