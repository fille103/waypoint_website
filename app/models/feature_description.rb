class FeatureDescription < ActiveRecord::Base
    belongs_to :waypoint_feature
    validates_presence_of :description
    validates_presence_of :waypoint_feature_id
    
	scope :visible, lambda {where(:visible => true)}
    scope :invisible, lambda {where(:visible => false)}
    scope :sorted, lambda { order("feature_descriptions.id ASC")}
    scope :newest_first, lambda { order("feature_descriptions.created_at DESC")}
    scope :search, lambda { |query| where(["name LIKE ?", "%#{query}%"])}
end
