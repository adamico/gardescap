class ChangeStateTypeInGardes < ActiveRecord::Migration
  def up
    change_column :gardes, :state, 'integer USING CAST(state AS integer)'
    change_column_default :gardes, :state, 0
  end

  def down
    change_column :gardes, :state, :string
  end
end
