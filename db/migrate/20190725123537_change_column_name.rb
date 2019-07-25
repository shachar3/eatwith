class ChangeColumnName < ActiveRecord::Migration[5.1]
  def change
    rename_column :restaurants, :accepts_10_bis, :accepts_10bis
  end
end
