class WaypointFeaturesController < ApplicationController
    
    before_action :find_admin
    layout "admin"
    
    def index
        @waypoint_features = @admin.waypoint_features.sorted
    end
    
    def show
        @waypoint_feature = WaypointFeature.find(params[:id])
    end
    
    def new
        @waypoint_feature = WaypointFeature.new({:name => "Default", :admin_id => @admin.id})
        @waypoint_feature_count = WaypointFeature.count + 1
    end
    
    def create
        # Instantiate a new object using form parameters
        @waypoint_feature = WaypointFeature.new(waypoint_feature_params)
        # Save the object
        if @waypoint_feature.save
            # If save succeeds, redirect to the index action
            flash[:notice] = "Waypoint feature created successfully."
            redirect_to(:action => 'index', :admin_id => @admin.id)
            else
            # If save fails, redisplay the form so user can fix problems
            flash[:notice] = "Could not create waypoint feature."
            @waypoint_feature_count = WaypointFeature.count + 1
            render('new')
        end
    end
    
    def edit
        @waypoint_feature = WaypointFeature.find(params[:id])
        @waypoint_feature_count = WaypointFeature.count
    end
    
    def update
        # Find an existing object using form parameters
        @waypoint_feature = WaypointFeature.find(params[:id])
        # Update the object
        if @waypoint_feature.update_attributes(waypoint_feature_params)
            # If update succeeds, redirect to the index action
            flash[:notice] = "Waypoint feature updated successfully."
            redirect_to(:action => 'show', :id => @waypoint_feature.id, :admin_id => @admin.id)
            else
            # If update fails, redisplay the form so user can fix problems
            @waypoint_feature_count = WaypointFeature.count
            render('edit')
        end
    end
    
    def delete
        @waypoint_feature = WaypointFeature.find(params[:id])
    end
    
    def destroy
        # Don't need to use an instance variable, can use a local variable
        waypoint_feature = WaypointFeature.find(params[:id]).destroy
        flash[:notice] = "Waypoint feature was destroyed successfully."
        redirect_to(:action => 'index', :admin_id => @admin.id)
    end
    
    private
    def waypoint_feature_params
        defaults = {:admin_id => @admin.id}
        params.require(:waypoint_feature).permit(:name).merge(defaults)
    end
    def find_admin
        if params[:admin_id]
            @admin = Admin.find(params[:admin_id])
        end
    end
end
