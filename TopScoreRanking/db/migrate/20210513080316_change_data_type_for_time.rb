class ChangeDataTypeForTime < ActiveRecord::Migration[6.1]
  def change
    change_column :players, :time, :datetime
  end
end
