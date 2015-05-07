class CreateWaypointFeatures < ActiveRecord::Migration
    def up
        create_table :waypoint_features do |t|
            t.string "name", null: false
            t.integer "admin_id", null: false
            
            t.timestamps null: false
        end
        add_index("waypoint_features", "name")
    end
    def down
        drop_table :waypoint_features
    end
end
