class CreateContactInformations < ActiveRecord::Migration
    def up
        create_table :contact_informations do |t|
            t.string "street_address", null: false
            t.string "city", null: false
            t.string "state", null: false
            t.integer "zip", null: false
            t.integer "phone", null: false
            t.string "email", null: false
            
            t.timestamps null: false
        end
        add_index("contact_informations", "state")
    end
    def down
        drop_table :contact_informations
    end
end
