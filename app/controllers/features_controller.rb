class FeaturesController < ApplicationController
    
    layout "admin"
    
    before_action :find_version
    
    def index
        @features = @version.features.sorted
    end
    
    def show
        @feature = Feature.find(params[:id])
    end
    
    def new
        @feature = Feature.new({:name => "Default", :version_id => @version.id})
        @feature_count = Feature.count + 1
    end
    
    def create
        # Instantiate a new object using form parameters
        @feature = Feature.new(feature_params)
        # Save the object
        if @feature.save
            # If save succeeds, redirect to the index action
            flash[:notice] = "Feature created successfully."
            redirect_to(:action => 'index', :version_id => @version.id)
            else
            # If save fails, redisplay the form so user can fix problems
            flash[:notice] = "Could not create feature."
            @feature_count = Feature.count + 1
            render('new')
        end
    end
    
    def edit
        @feature = Feature.find(params[:id])
        @feature_count = Feature.count
    end
    
    def update
        # Find an existing object using form parameters
        @feature = Feature.find(params[:id])
        # Update the object
        if @feature.update_attributes(feature_params)
            # If update succeeds, redirect to the index action
            flash[:notice] = "Feature updated successfully."
            redirect_to(:action => 'show', :id => @feature.id, :version_id => @version.id)
            else
            # If update fails, redisplay the form so user can fix problems
            flash[:notice] = "Could not update feature."
            @feature_count = Feature.count
            render('edit')
        end
    end
    
    def delete
        @feature = Feature.find(params[:id])
    end
    
    def destroy
        # Don't need to use an instance variable, can use a local variable
        feature = Feature.find(params[:id]).destroy
        flash[:notice] = "Feature was destroyed successfully."
        redirect_to(:action => 'index', :version_id => @version.id)
    end
    
    private
    def feature_params
        defaults = {:version_id => @version.id}
        params.require(:feature).permit(:name).merge(defaults)
    end
    def find_version
        if params[:version_id]
            @version = Version.find(params[:version_id])
        end
    end
end
