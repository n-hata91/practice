class AddActivationToUsers < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :activation_digest, :string
    add_column :users, :activated, :boolean, default: false #defaultはなくてもnilになり問題ないが、今後の保守運用のため強調としてつける
    add_column :users, :activated_at, :datetime
  end
end
