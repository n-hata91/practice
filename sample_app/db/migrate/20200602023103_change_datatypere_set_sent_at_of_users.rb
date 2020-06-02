class ChangeDatatypereSetSentAtOfUsers < ActiveRecord::Migration[5.1]
  def change
    change_column :users, :reset_sent_at, :datetime
    #Ex:- change_column("admin_users", "email", :string, :limit =>25)
  end
end
