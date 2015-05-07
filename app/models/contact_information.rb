class ContactInformation < ActiveRecord::Base
    belongs_to :admin
    validates_presence_of :street_address
    validates_presence_of :city
    validates_presence_of :state
    validates_presence_of :zip
    validates_presence_of :phone
    validates_presence_of :email
    
	scope :visible, lambda {where(:visible => true)}
    scope :invisible, lambda {where(:visible => false)}
    scope :sorted, lambda { order("contact_information.city ASC")}
    scope :newest_first, lambda { order("contact_information.created_at DESC")}
    scope :search, lambda { |query| where(["name LIKE ?", "%#{query}%"])}
end
