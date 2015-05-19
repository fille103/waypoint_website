class CreateDescriptions < ActiveRecord::Migration
    def up
        create_table :descriptions do |t|
            t.text "description", null: false
            t.integer "feature_id", null: false
            
            t.timestamps null: false
        end
        add_index("descriptions", "feature_id")
    end
    def down
        drop_table :descriptions
    end
end
