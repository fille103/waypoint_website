class FeatureDescriptionsController < ApplicationController
    
    before_action :find_waypoint_feature
    layout "admin"
    
    def index
        @feature_descriptions = FeatureDescription.where(waypoint_feature_id: @waypoint_feature.id, admin_id: @waypoint_feature.admin_id);
    end
    
    def show
        @feature_description = FeatureDescription.find(params[:id])
    end
    
    def new
        @feature_description = FeatureDescription.new({:description => "Default", :waypoint_feature_id => @waypoint_feature.id, :admin_id => @waypoint_feature.admin_id})
        @feature_description_count = FeatureDescription.count + 1
    end
    
    def create
        # Instantiate a new object using form parameters
        @feature_description = FeatureDescription.new(feature_description_params)
        # Save the object
        if @feature_description.save
            # If save succeeds, redirect to the index action
            flash[:notice] = "Feature description created successfully."
            redirect_to(:action => 'index', :waypoint_feature_id => @waypoint_feature.id, :admin_id => @waypoint_feature.admin_id)
            else
            # If save fails, redisplay the form so user can fix problems
            flash[:notice] = "Could not create feature description."
            @feature_description_count = FeatureDescription.count + 1
            render('new')
        end
    end
    
    def edit
        @feature_description = FeatureDescription.find(params[:id])
        @feature_description_count = FeatureDescription.count
    end
    
    def update
        # Find an existing object using form parameters
        @feature_description = FeatureDescription.find(params[:id])
        # Update the object
        if @feature_description.update_attributes(feature_description_params)
            # If update succeeds, redirect to the index action
            flash[:notice] = "Feature description updated successfully."
            redirect_to(:action => 'show', :id => @feature_description.id, :waypoint_feature_id => @waypoint_feature.id, :admin_id => @waypoint_feature.admin_id)
            else
            # If update fails, redisplay the form so user can fix problems
            flash[:notice] = "Could not update feature description."
            @feature_description_count = FeatureDescription.count
            render('edit')
        end
    end
    
    def delete
        @feature_description = FeatureDescription.find(params[:id])
    end
    
    def destroy
        # Don't need to use an instance variable, can use a local variable
        feature_description = FeatureDescription.find(params[:id]).destroy
        flash[:notice] = "Feature description was destroyed successfully."
        redirect_to(:action => 'index', :waypoint_feature_id => @waypoint_feature.id, :admin_id => @waypoint_feature.admin_id)
    end
    
    private
    def feature_description_params
        defaults = {:waypoint_feature_id => @waypoint_feature.id, :admin_id => @waypoint_feature.admin_id}
        params.require(:feature_description).permit(:description).merge(defaults)
    end
    def find_waypoint_feature
        if params[:waypoint_feature_id]
            @waypoint_feature = WaypointFeature.find(params[:waypoint_feature_id])
        end
    end
end
