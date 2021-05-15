class ChangeNameForTime < ActiveRecord::Migration[6.1]
  def change
    rename_column :players, :time, :time_entry
  end
end
