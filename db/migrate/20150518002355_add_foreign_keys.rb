class AddForeignKeys < ActiveRecord::Migration
    def up
        add_foreign_key :team_members, :admins
        add_foreign_key :bios, :team_members
        add_foreign_key :feedbacks, :registered_users
        add_foreign_key :ratings, :registered_users
        add_foreign_key :ratings, :versions
        add_foreign_key :reviews, :ratings
        add_foreign_key :features, :versions
        add_foreign_key :descriptions, :features
        add_foreign_key :release_notes, :versions
    end
    def down
        remove_foreign_key :release_notes, :versions
        remove_foreign_key :descriptions, :features
        remove_foreign_key :features, :versions
        remove_foreign_key :reviews, :ratings
        remove_foreign_key :ratings, :versions
        remove_foreign_key :ratings, :registered_users
        remove_foreign_key :feedbacks, :registered_users
        remove_foreign_key :bios, :team_members
        remove_foreign_key :team_members, :admins
    end
end
