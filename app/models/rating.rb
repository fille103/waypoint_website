class Rating < ActiveRecord::Base
    
    before_destroy :delete_related_review
    after_save :touch_registered_user_version
    
    has_one :review
    belongs_to :registered_user
    belongs_to :version
    
    validates_presence_of :rating
    
	scope :visible, lambda {where(:visible => true)}
    scope :invisible, lambda {where(:visible => false)}
    scope :sorted, lambda { order("ratings.id ASC")}
    scope :newest_first, lambda { order("ratings.created_at DESC")}
    scope :search, lambda { |query| where(["name LIKE ?", "%#{query}%"])}
    
    private
    def touch_registered_user_version
        if (!registered_user.nil?)
            registered_user.touch
        end
        version.touch
    end
    def delete_related_review
        if (!self.review.nil?)
            self.review.destroy
        end
    end
end
