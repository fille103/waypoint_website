class Version < ActiveRecord::Base
    
    before_destroy :delete_related_ratings_features_release_notes
    
    has_many :ratings
    has_many :features
    has_many :release_notes
    
    validates_presence_of :version
    
	scope :visible, lambda {where(:visible => true)}
    scope :invisible, lambda {where(:visible => false)}
    scope :sorted, lambda { order("versions.version ASC")}
    scope :newest_first, lambda { order("versions.created_at DESC")}
    scope :search, lambda { |query| where(["name LIKE ?", "%#{query}%"])}
    
    private
    def delete_related_ratings_features_release_notes
        self.ratings.each do |rating|
            if (!rating.review.nil?)
                rating.review.destroy
            end
            rating.destroy
        end
        self.features.each do |feature|
            if (!feature.description.nil?)
                feature.description.destroy
            end
            feature.destroy
        end
        self.release_notes.each do |release_note|
            release_note.destroy
        end
    end
end
