class CreateFeedbacks < ActiveRecord::Migration
    def up
        create_table :feedbacks do |t|
            t.text "feedback", null: false
            t.integer "registered_user_id", null: false
            
            t.timestamps null: false
        end
        add_index("feedbacks", "registered_user_id")
    end
    def down
        drop_table :feedbacks
    end
end
