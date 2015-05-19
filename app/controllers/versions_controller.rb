class VersionsController < ApplicationController
    
    layout "admin"
    
    before_action :confirm_logged_in
    
    def index
        @versions = Version.sorted
    end
    
    def show
        @version = Version.find(params[:id])
    end
    
    def new
        @version = Version.new({:version => "1"})
        @version_count = Version.count + 1
    end
    
    def create
        # Instantiate a new object using form parameters
        @version = Version.new(version_params)
        # Save the object
        if @version.save
            # If save succeeds, redirect to the index action
            flash[:notice] = "Version created successfully."
            redirect_to(:action => 'index')
            else
            # If save fails, redisplay the form so user can fix problems
            flash[:notice] = "Could not create version."
            @version_count = Version.count + 1
            render('new')
        end
    end
    
    def edit
        @version = Version.find(params[:id])
        @version_count = Version.count
    end
    
    def update
        # Find an existing object using form parameters
        @version = Version.find(params[:id])
        # Update the object
        if @version.update_attributes(version_params)
            # If update succeeds, redirect to the index action
            flash[:notice] = "Version updated successfully."
            redirect_to(:action => 'show', :id => @version.id)
            else
            # If update fails, redisplay the form so user can fix problems
            flash[:notice] = "Could not update version."
            @version_count = Version.count
            render('edit')
        end
    end
    
    def delete
        @version = Version.find(params[:id])
    end
    
    def destroy
        # Don't need to use an instance variable, can use a local variable
        version = Version.find(params[:id]).destroy
        flash[:notice] = "Version was destroyed successfully."
        redirect_to(:action => 'index')
    end
    
    private
    def version_params
        params.require(:version).permit(:version)
    end
end
