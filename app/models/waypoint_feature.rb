class WaypointFeature < ActiveRecord::Base
    
    before_destroy :delete_related_feature_description
    after_save :touch_admin
    
    has_one :feature_description
	belongs_to :admin
    
    validates_presence_of :name
    
	scope :visible, lambda {where(:visible => true)}
    scope :invisible, lambda {where(:visible => false)}
    scope :sorted, lambda { order("waypoint_features.name ASC")}
    scope :newest_first, lambda { order("waypoint_features.created_at DESC")}
    scope :search, lambda { |query| where(["name LIKE ?", "%#{query}%"])}
    
    private
    def touch_admin
        admin.touch
    end
    def delete_related_feature_description
        if (!self.feature_description.nil?)
            self.feature_description.destroy
        end
    end
end
