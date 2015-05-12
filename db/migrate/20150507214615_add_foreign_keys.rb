class AddForeignKeys < ActiveRecord::Migration
    def up
        add_foreign_key :waypoint_features, :admins
        add_foreign_key :feature_descriptions, :waypoint_features
        add_foreign_key :feature_descriptions, :admins
        add_foreign_key :registered_users, :admins
        add_foreign_key :feedbacks, :registered_users
        add_foreign_key :feedbacks, :admins
        add_foreign_key :team_members, :admins
        add_foreign_key :bios, :team_members
        add_foreign_key :bios, :admins
        add_foreign_key :contact_informations, :admins
    end
    def down
        remove_foreign_key :contact_informations, :admins
        remove_foreign_key :bios, :admins
        remove_foreign_key :bios, :team_members
        remove_foreign_key :team_members, :admins
        remove_foreign_key :feedbacks, :admins
        remove_foreign_key :feedbacks, :registered_users
        remove_foreign_key :registered_users, :admins
        remove_foreign_key :feature_descriptions, :admins
        remove_foreign_key :feature_descriptions, :waypoint_features
        remove_foreign_key :waypoint_features, :admins
    end
end
