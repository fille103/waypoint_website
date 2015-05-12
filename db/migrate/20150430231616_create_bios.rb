class CreateBios < ActiveRecord::Migration
    def up
        create_table :bios do |t|
            t.text "biography", null: false
            t.integer "team_member_id", null: false
            t.integer "admin_id", null: false
            
            t.timestamps null: false
        end
    end
    def down
        drop_table :bios
    end
end
