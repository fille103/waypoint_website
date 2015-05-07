class CreateAdmins < ActiveRecord::Migration
    def up
        create_table :admins do |t|
            t.string "username", null: false
            t.string "password", null: false
            
            t.timestamps null: false
        end
    end
    def down
        drop_table :admins
    end
end
