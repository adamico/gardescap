class AddHolidayToGardes < ActiveRecord::Migration
  def change
    add_column :gardes, :holiday, :boolean, default: false
  end
end
