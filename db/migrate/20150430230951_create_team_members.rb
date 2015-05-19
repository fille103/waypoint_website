class CreateTeamMembers < ActiveRecord::Migration
    def up
        create_table :team_members do |t|
            t.string "first_name", null: false
            t.string "last_name", null: false
            t.integer "admin_id"
            
            t.timestamps null: false
        end
        add_index("team_members", "last_name")
    end
    def down
        drop_table :team_members
    end
end
