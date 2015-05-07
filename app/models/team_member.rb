class TeamMember < ActiveRecord::Base
    has_one :bio
	belongs_to :admin
    #acts_as_list
    validates_presence_of :first_name
    validates_presence_of :last_name
	validates_presence_of :admin_id
    
	scope :visible, lambda {where(:visible => true)}
    scope :invisible, lambda {where(:visible => false)}
    scope :sorted, lambda { order("team_members.last_name ASC")}
    scope :newest_first, lambda { order("team_members.created_at DESC")}
    scope :search, lambda { |query| where(["name LIKE ?", "%#{query}%"])}
end
