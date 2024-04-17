class RenameUTypeColumnToUserTypeInUsers < ActiveRecord::Migration[7.0]
  def change
    rename_column :users, :u_type, :user_type
  end
end
