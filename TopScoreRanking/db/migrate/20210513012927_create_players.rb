class CreatePlayers < ActiveRecord::Migration[6.1]
  def change
    create_table :players do |t|
      t.string :name
      t.integer :score
      t.string :time

      t.timestamps
    end
  end
end
