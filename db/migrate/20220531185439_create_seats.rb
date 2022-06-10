class CreateSeats < ActiveRecord::Migration[7.0]
  def change
    create_table :seats do |t|
      t.belongs_to :flight, foreign_key: true
      t.integer :row
      t.string :column
      t.boolean :disponibility

      t.timestamps
    end
  end
end
