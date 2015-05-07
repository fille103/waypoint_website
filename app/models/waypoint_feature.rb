class WaypointFeature < ActiveRecord::Base
    has_one :feature_description
	belongs_to :admin
    validates_presence_of :name
    validates_presence_of :admin_id
    
	scope :visible, lambda {where(:visible => true)}
    scope :invisible, lambda {where(:visible => false)}
    scope :sorted, lambda { order("waypoint_features.name ASC")}
    scope :newest_first, lambda { order("waypoint_features.created_at DESC")}
    scope :search, lambda { |query| where(["name LIKE ?", "%#{query}%"])}
end
