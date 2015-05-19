class CreateFeatures < ActiveRecord::Migration
    def up
        create_table :features do |t|
            t.string "name", null: false
            t.integer "version_id", null: false
            
            t.timestamps null: false
        end
        add_index("features", "version_id")
    end
    def down
        drop_table :features
    end
end
