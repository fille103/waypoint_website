class CreateAdmins < ActiveRecord::Migration
    def up
        create_table :admins do |t|
            t.string "username", null: false
            t.string "password_digest", null: false
            t.string "email", null: false
            
            t.timestamps null: false
        end
        add_index :admins, ["username", "email"]
    end
    def down
        drop_table :admins
    end
end
