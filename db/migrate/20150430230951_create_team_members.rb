class CreateTeamMembers < ActiveRecord::Migration
    def up
        create_table :team_members do |t|
            t.string "first_name", null: false
            t.string "last_name", null: false
            t.integer "admin_id", null: false
            
            t.timestamps null: false
        end
    end
    def down
        drop_table :team_members
    end
end
