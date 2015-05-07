class RegisteredUser < ActiveRecord::Base
    has_many :feedback
	belongs_to :admin
    validates_presence_of :username
    validates_presence_of :password
    validates_presence_of :subscribed
	validates_presence_of :admin_id
    
	scope :visible, lambda {where(:visible => true)}
    scope :invisible, lambda {where(:visible => false)}
    scope :sorted, lambda { order("registered_users.username ASC")}
    scope :newest_first, lambda { order("registered_users.created_at DESC")}
    scope :search, lambda { |query| where(["name LIKE ?", "%#{query}%"])}
end
