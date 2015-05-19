class ReleaseNote < ActiveRecord::Base
    
    after_save :touch_version
        
    belongs_to :version
    
    validates_presence_of :note
    
	scope :visible, lambda {where(:visible => true)}
    scope :invisible, lambda {where(:visible => false)}
    scope :sorted, lambda { order("release_notes.id ASC")}
    scope :newest_first, lambda { order("release_notes.created_at DESC")}
    scope :search, lambda { |query| where(["name LIKE ?", "%#{query}%"])}
    
    private
    def touch_version
        version.touch
    end
end
