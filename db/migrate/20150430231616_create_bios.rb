class CreateBios < ActiveRecord::Migration
    def up
        create_table :bios do |t|
            t.text "bio", null: false
            t.integer "team_member_id", null: false
            
            t.timestamps null: false
        end
        add_index("bios", "team_member_id")
    end
    def down
        drop_table :bios
    end
end
