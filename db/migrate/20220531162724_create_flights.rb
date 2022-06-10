class CreateFlights < ActiveRecord::Migration[7.0]
  def change
    create_table :flights do |t|
      t.date :date
      t.time :time
      t.string :origin
      t.string :destiny

      t.timestamps
    end
  end
end
