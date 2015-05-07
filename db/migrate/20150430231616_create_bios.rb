class CreateBios < ActiveRecord::Migration
    def up
        create_table :bios do |t|
            t.string "biography", null: false
            t.integer "team_member_id", null: false
            
            t.timestamps null: false
        end
    end
    def down
        drop_table :bios
    end
end
