class Admin < ActiveRecord::Base
    has_many :waypoint_features
    has_many :registered_users
    has_many :team_members
    has_many :contact_information
    validates_presence_of :username
    validates_presence_of :password
    #has_secure_password
    
	scope :visible, lambda {where(:visible => true)}
    scope :invisible, lambda {where(:visible => false)}
    scope :sorted, lambda { order("admins.username ASC")}
    scope :newest_first, lambda { order("admins.created_at DESC")}
    scope :search, lambda { |query| where(["name LIKE ?", "%#{query}%"])}
end
