class Description < ActiveRecord::Base
    
    after_save :touch_feature
    
    belongs_to :feature
    
    validates_presence_of :description
    
	scope :visible, lambda {where(:visible => true)}
    scope :invisible, lambda {where(:visible => false)}
    scope :sorted, lambda { order("descriptions.id ASC")}
    scope :newest_first, lambda { order("descriptions.created_at DESC")}
    scope :search, lambda { |query| where(["name LIKE ?", "%#{query}%"])}
    
    private
    def touch_feature
        feature.touch
    end
end
