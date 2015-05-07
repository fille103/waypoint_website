class AdminsController < ApplicationController
    
    layout "admin"
    
    def index
        @admins = Admin.sorted
    end
    
    def show
        @admin = Admin.find(params[:id])
    end
    
    def new
        @admin = Admin.new({:username => "WaypointAdmin", :password => "Default"})
        @admin_count = Admin.count + 1
    end
    
    def create
        # Instantiate a new object using form parameters
        @admin = Admin.new(admin_params)
        # Save the object
        if @admin.save
            # If save succeeds, redirect to the index action
            flash[:notice] = "Admin created successfully."
            redirect_to(:action => 'index')
            else
            # If save fails, redisplay the form so user can fix problems
            flash[:notice] = "Could not create admin."
            @admin_count = Admin.count + 1
            render('new')
        end
    end
    
    def edit
        @admin = Admin.find(params[:id])
        @admin_count = Admin.count
    end
    
    def update
        # Find an existing object using form parameters
        @admin = Admin.find(params[:id])
        # Update the object
        if @admin.update_attributes(admin_params)
            # If update succeeds, redirect to the index action
            flash[:notice] = "Admin updated successfully."
            redirect_to(:action => 'show', :id => @admin.id)
            else
            # If update fails, redisplay the form so user can fix problems
            flash[:notice] = "Could not update admin."
            @admin_count = Admin.count
            render('edit')
        end
    end
    
    def delete
        @admin = Admin.find(params[:id])
    end
    
    def destroy
        # Don't need to use an instance variable, can use a local variable
        admin = Admin.find(params[:id]).destroy
        flash[:notice] = "Admin was destroyed successfully."
        redirect_to(:action => 'index')
    end
    
    private
    def admin_params
        params.require(:admin).permit(:username,:password)
    end
end
