class ChangeStateToEnum < ActiveRecord::Migration
  def up
    remove_column :periods, :state
    add_column :periods, :state, :integer, default: 0
  end

  def down
    remove_column :periods, :state
    add_column :periods, :state, :string
  end
end
