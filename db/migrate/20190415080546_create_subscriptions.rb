class CreateSubscriptions < ActiveRecord::Migration[5.2]
  def change
    create_table :subscriptions do |t|
      t.integer :user_id
      t.integer :frend_id

      t.timestamps
    end
    add_index :subscriptions, :user_id
    add_index :subscriptions, :frend_id
  end
end
