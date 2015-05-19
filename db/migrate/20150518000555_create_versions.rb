class CreateVersions < ActiveRecord::Migration
    def up
        create_table :versions do |t|
            t.integer "version", null: false
            
            t.timestamps null: false
        end
        add_index("versions", "version")
    end
    def down
        drop_table :versions
    end
end
