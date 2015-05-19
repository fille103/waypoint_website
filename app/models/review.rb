class Review < ActiveRecord::Base
    
    after_save :touch_rating
    
    belongs_to :rating
    
    validates_presence_of :subject
    validates_presence_of :message
    
	scope :visible, lambda {where(:visible => true)}
    scope :invisible, lambda {where(:visible => false)}
    scope :sorted, lambda { order("reviews.id ASC")}
    scope :newest_first, lambda { order("reviews.created_at DESC")}
    scope :search, lambda { |query| where(["name LIKE ?", "%#{query}%"])}
    
    private
    def touch_rating
        rating.touch
    end
end
