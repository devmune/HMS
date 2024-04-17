class DropTreatmentsTable < ActiveRecord::Migration[7.0]
  def change
    drop_table :hospitals_users
  end
end
