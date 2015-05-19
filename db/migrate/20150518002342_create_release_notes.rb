class CreateReleaseNotes < ActiveRecord::Migration
    def up
        create_table :release_notes do |t|
            t.integer "note", null: false
            t.integer "version_id", null: false
            
            t.timestamps null: false
        end
        add_index("release_notes", "version_id")
    end
    def down
        drop_table :release_notes
    end
end
