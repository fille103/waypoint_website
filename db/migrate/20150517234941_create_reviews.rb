class CreateReviews < ActiveRecord::Migration
    def up
        create_table :reviews do |t|
            t.string "subject", null: false
            t.text "message", null: false
            t.integer "rating_id", null: false
            
            t.timestamps null: false
        end
        add_index("reviews", "rating_id")
    end
    def down
        drop_table :reviews
    end
end
