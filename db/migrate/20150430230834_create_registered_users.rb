class CreateRegisteredUsers < ActiveRecord::Migration
    def up
        create_table :registered_users do |t|
            t.string "username", null: false
            t.string "password", null: false
            t.string "email"
            t.boolean "subscribed", null: false
            
            t.timestamps null: false
        end
        add_index :registered_users, ["username", "email"]
    end
    def down
        drop_table :registered_users
    end
end
