class CreateFeatureDescriptions < ActiveRecord::Migration
    def up
        create_table :feature_descriptions do |t|
            t.text "description", null: false
            t.integer "waypoint_feature_id", null: false
            
            t.timestamps null: false
        end
    end
    def down
        drop_table :feature_descriptions
    end
end
