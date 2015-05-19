class RegisteredUser < ActiveRecord::Base
    
    before_destroy :delete_related_feedbacks_ratings
    
    has_many :feedbacks
    has_many :ratings
    
    validates_presence_of :username
    validates_presence_of :password
    validates_presence_of :subscribed
    
	scope :visible, lambda {where(:visible => true)}
    scope :invisible, lambda {where(:visible => false)}
    scope :sorted, lambda { order("registered_users.username ASC")}
    scope :newest_first, lambda { order("registered_users.created_at DESC")}
    scope :search, lambda { |query| where(["name LIKE ?", "%#{query}%"])}
    
    private
    def delete_related_feedbacks_ratings
        self.feedbacks.each do |feedback|
            feedback.destroy
        end
        self.ratings.each do |rating|
            if (!rating.review.nil?)
                rating.review.destroy
            end
            rating.destroy
        end
    end
end
