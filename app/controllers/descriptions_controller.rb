class DescriptionsController < ApplicationController
    
    layout "admin"
    
    before_action :find_feature
    
    def index
        @descriptions = Description.where(feature_id: @feature.id);
    end
    
    def show
        @description = Description.find(params[:id])
    end
    
    def new
        @description = Description.new({:description => "Default", :feature_id => @feature.id})
        @description_count = Description.count + 1
    end
    
    def create
        # Instantiate a new object using form parameters
        @description = Description.new(description_params)
        # Save the object
        if @description.save
            # If save succeeds, redirect to the index action
            flash[:notice] = "Description created successfully."
            redirect_to(:action => 'index', :feature_id => @feature.id)
            else
            # If save fails, redisplay the form so user can fix problems
            flash[:notice] = "Could not create description."
            @description_count = Description.count + 1
            render('new')
        end
    end
    
    def edit
        @description = Description.find(params[:id])
        @description_count = Description.count
    end
    
    def update
        # Find an existing object using form parameters
        @description = Description.find(params[:id])
        # Update the object
        if @description.update_attributes(description_params)
            # If update succeeds, redirect to the index action
            flash[:notice] = "Description updated successfully."
            redirect_to(:action => 'show', :id => @description.id, :feature_id => @feature.id)
            else
            # If update fails, redisplay the form so user can fix problems
            flash[:notice] = "Could not update description."
            @description_count = Description.count
            render('edit')
        end
    end
    
    def delete
        @description = Description.find(params[:id])
    end
    
    def destroy
        # Don't need to use an instance variable, can use a local variable
        description = Description.find(params[:id]).destroy
        flash[:notice] = "Description was destroyed successfully."
        redirect_to(:action => 'index', :feature_id => @feature.id)
    end
    
    private
    def description_params
        defaults = {:feature_id => @feature.id}
        params.require(:description).permit(:description).merge(defaults)
    end
    def find_feature
        if params[:feature_id]
            @feature = Feature.find(params[:feature_id])
        end
    end
end
