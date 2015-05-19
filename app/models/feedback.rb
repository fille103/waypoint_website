class Feedback < ActiveRecord::Base
    
    after_save :touch_registered_user
        
    belongs_to :registered_user
    
    validates_presence_of :feedback
    
	scope :visible, lambda {where(:visible => true)}
    scope :invisible, lambda {where(:visible => false)}
    scope :sorted, lambda { order("feedbacks.id ASC")}
    scope :newest_first, lambda { order("feedbacks.created_at DESC")}
    scope :search, lambda { |query| where(["name LIKE ?", "%#{query}%"])}
    
    private
    def touch_registered_user
        registered_user.touch
    end
end
