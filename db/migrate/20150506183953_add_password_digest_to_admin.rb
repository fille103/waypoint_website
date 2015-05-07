class AddPasswordDigestToAdmin < ActiveRecord::Migration
    def up
        #remove_column "admin", "password"
        #add_column "admin", "password_digest", :string
    end
    
    def down
        #add_column "admin", "password", :string
        #remove_column "admin", "password_digest"
    end
end
