class AddForeignKeys < ActiveRecord::Migration
    def up
        add_foreign_key :waypoint_features, :admins
        add_foreign_key :feature_descriptions, :waypoint_features
        add_foreign_key :registered_users, :admins
        add_foreign_key :feedback, :registered_users
        add_foreign_key :feedback, :admins
        add_foreign_key :bios, :team_members
        add_foreign_key :team_members, :admins
        add_foreign_key :contact_information, :admins
    end
    def down
        remove_foreign_key :waypoint_features, :admins
        remove_foreign_key :feature_descriptions, :waypoint_features
        remove_foreign_key :registered_users, :admins
        remove_foreign_key :feedback, :registered_users
        remove_foreign_key :feedback, :admins
        remove_foreign_key :bios, :team_members
        remove_foreign_key :team_members, :admins
        remove_foreign_key :contact_information, :admins
    end
end
