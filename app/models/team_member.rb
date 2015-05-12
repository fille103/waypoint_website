class TeamMember < ActiveRecord::Base
    
    before_destroy :delete_related_bio
    after_save :touch_admin
    
    has_one :bio
	belongs_to :admin
    
    validates_presence_of :first_name
    validates_presence_of :last_name
    
	scope :visible, lambda {where(:visible => true)}
    scope :invisible, lambda {where(:visible => false)}
    scope :sorted, lambda { order("team_members.last_name ASC")}
    scope :newest_first, lambda { order("team_members.created_at DESC")}
    scope :search, lambda { |query| where(["name LIKE ?", "%#{query}%"])}
    
    private
    def touch_admin
        admin.touch
    end
    def delete_related_bio
        if (!self.bio.nil?)
            self.bio.destroy
        end
    end
end
