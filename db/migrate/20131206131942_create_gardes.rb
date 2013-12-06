class CreateGardes < ActiveRecord::Migration
  def change
    create_table :gardes do |t|
      t.date :date
      t.string :time
      t.string :state

      t.timestamps
    end
  end
end
