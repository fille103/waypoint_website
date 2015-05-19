class Feature < ActiveRecord::Base
        
    before_destroy :delete_related_description
    after_save :touch_version
    
    has_one :description
	belongs_to :version
    
    validates_presence_of :name
    
	scope :visible, lambda {where(:visible => true)}
    scope :invisible, lambda {where(:visible => false)}
    scope :sorted, lambda { order("features.name ASC")}
    scope :newest_first, lambda { order("features.created_at DESC")}
    scope :search, lambda { |query| where(["name LIKE ?", "%#{query}%"])}
    
    private
    def touch_version
        version.touch
    end
    def delete_related_description
        if (!self.description.nil?)
            self.description.destroy
        end
    end
end
