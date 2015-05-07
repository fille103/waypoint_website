class Feedback < ActiveRecord::Base
    belongs_to :registered_user
    belongs_to :admin
    validates_presence_of :feedback
    validates_presence_of :registered_user_id
	validates_presence_of :admin_id
    
	scope :visible, lambda {where(:visible => true)}
    scope :invisible, lambda {where(:visible => false)}
    scope :sorted, lambda { order("feedback.id ASC")}
    scope :newest_first, lambda { order("feedback.created_at DESC")}
    scope :search, lambda { |query| where(["name LIKE ?", "%#{query}%"])}
end
