class Bio < ActiveRecord::Base
    
    after_save :touch_team_member
    
    belongs_to :team_member
    belongs_to :admin
    
    validates_presence_of :biography
    
	scope :visible, lambda {where(:visible => true)}
    scope :invisible, lambda {where(:visible => false)}
    scope :sorted, lambda { order("bios.id ASC")}
    scope :newest_first, lambda { order("bios.created_at DESC")}
    scope :search, lambda { |query| where(["name LIKE ?", "%#{query}%"])}
    
    private
    def touch_team_member
        team_member.touch
    end
end
