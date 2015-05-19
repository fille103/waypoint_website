class CreateRatings < ActiveRecord::Migration
    def up
        create_table :ratings do |t|
            t.integer "rating", null: false
            t.integer "registered_user_id"
            t.integer "version_id", null: false
            
            t.timestamps null: false
        end
        add_index("ratings", "rating")
    end
    def down
        drop_table :ratings
    end
end
