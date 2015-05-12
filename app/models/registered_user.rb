class RegisteredUser < ActiveRecord::Base
    
    before_destroy :delete_related_feedbacks
    after_save :touch_admin
    
    has_many :feedbacks
	belongs_to :admin
    
    validates_presence_of :username
    validates_presence_of :password
    validates_presence_of :subscribed
    
	scope :visible, lambda {where(:visible => true)}
    scope :invisible, lambda {where(:visible => false)}
    scope :sorted, lambda { order("registered_users.username ASC")}
    scope :newest_first, lambda { order("registered_users.created_at DESC")}
    scope :search, lambda { |query| where(["name LIKE ?", "%#{query}%"])}
    
    private
    def touch_admin
        admin.touch
    end
    def delete_related_feedbacks
        self.feedbacks.each do |feedback|
            feedback.destroy
        end
    end
end
