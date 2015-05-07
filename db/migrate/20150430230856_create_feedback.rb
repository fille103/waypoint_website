class CreateFeedback < ActiveRecord::Migration
    def up
        create_table :feedback do |t|
            t.text "feedback", null: false
            t.integer "registered_user_id", null: false
            t.integer "admin_id", null: false
            
            t.timestamps null: false
        end
    end
    def down
        drop_table :feedback
    end
end
