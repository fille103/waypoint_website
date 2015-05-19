class Admin < ActiveRecord::Base
    
    before_destroy :delete_related_team_member_bio
    
    has_one :team_member
    has_one :bio, through: :team_member
    
    has_secure_password
    
    validates_presence_of :username
    validates_presence_of :password
    validates_presence_of :email
    
	scope :visible, lambda {where(:visible => true)}
    scope :invisible, lambda {where(:visible => false)}
    scope :sorted, lambda { order("admins.username ASC")}
    scope :newest_first, lambda { order("admins.created_at DESC")}
    scope :search, lambda { |query| where(["name LIKE ?", "%#{query}%"])}
    
    private
    def delete_related_team_member_bio
        if (!self.team_member.nil?)
            if (!team_member.bio.nil?)
                team_member.bio.destroy
            end
            self.team_member.destroy
        end
    end
end
