class RenameColumnOnMicroposts < ActiveRecord::Migration[5.1]
  def change
    rename_column :microposts, :cntent, :content
    #Ex:- rename_column("admin_users", "pasword","hashed_pasword")
  end
end
