class Admin < ActiveRecord::Base
    
    before_destroy :delete_related_waypoint_features_feature_descriptions
    before_destroy :delete_related_registered_users_feedbacks
    before_destroy :delete_related_team_members_bios
    before_destroy :delete_related_contact_information
    
    has_many :waypoint_features
    has_many :feature_descriptions
    has_many :registered_users
    has_many :feedbacks
    has_many :team_members
    has_many :bios
    has_one :contact_information
    
    validates_presence_of :username
    validates_presence_of :password
    #has_secure_password
    
	scope :visible, lambda {where(:visible => true)}
    scope :invisible, lambda {where(:visible => false)}
    scope :sorted, lambda { order("admins.username ASC")}
    scope :newest_first, lambda { order("admins.created_at DESC")}
    scope :search, lambda { |query| where(["name LIKE ?", "%#{query}%"])}
    
    private
    def delete_related_waypoint_features_feature_descriptions
        self.waypoint_features.each do |waypoint_feature|
            if (!waypoint_feature.feature_description.nil?)
                waypoint_feature.feature_description.destroy
            end
            waypoint_feature.destroy
        end
    end
    def delete_related_registered_users_feedbacks
        self.registered_users.each do |registered_user|
            registered_user.feedbacks.each do |feedback|
                feedback.destroy
            end
            registered_user.destroy
        end
    end
    def delete_related_team_members_bios
        self.team_members.each do |team_member|
            if (!team_member.bio.nil?)
                team_member.bio.destroy
            end
            team_member.destroy
        end
    end
    def delete_related_contact_information
        if (!self.contact_information.nil?)
            self.contact_information.destroy
        end
    end
end
