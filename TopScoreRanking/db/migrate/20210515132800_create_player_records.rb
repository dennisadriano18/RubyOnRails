class CreatePlayerRecords < ActiveRecord::Migration[6.1]
  def change
    create_table :player_records do |t|
      t.string :name
      t.integer :score
      t.datetime :time_entry

      t.timestamps
    end
  end
end
