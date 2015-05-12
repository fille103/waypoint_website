class FeatureDescription < ActiveRecord::Base
    
    after_save :touch_waypoint_feature
    
    belongs_to :waypoint_feature
    belongs_to :admin
    
    validates_presence_of :description
    
	scope :visible, lambda {where(:visible => true)}
    scope :invisible, lambda {where(:visible => false)}
    scope :sorted, lambda { order("feature_descriptions.id ASC")}
    scope :newest_first, lambda { order("feature_descriptions.created_at DESC")}
    scope :search, lambda { |query| where(["name LIKE ?", "%#{query}%"])}
    
    private
    def touch_waypoint_feature
        waypoint_feature.touch
    end
end
