class RegisteredUsersController < ApplicationController
    
    before_action :find_admin
    layout "admin"
    
    def index
        @registered_users = @admin.registered_users.sorted
    end
    
    def show
        @registered_user = RegisteredUser.find(params[:id])
    end
    
    def new
        @registered_user = RegisteredUser.new({:username => "WaypointUser", :password => "Default", :email => "User@email.com", :subscribed => true, :admin_id => @admin.id})
        @registered_user_count = RegisteredUser.count + 1
    end
    
    def create
        # Instantiate a new object using form parameters
        @registered_user = RegisteredUser.new(registered_user_params)
        # Save the object
        if @registered_user.save
            # If save succeeds, redirect to the index action
            flash[:notice] = "Registered user created successfully."
            redirect_to(:action => 'index', :admin_id => @admin.id)
            else
            # If save fails, redisplay the form so user can fix problems
            flash[:notice] = "Could not create registered user."
            @registered_user_count = RegisteredUser.count + 1
            render('new')
        end
    end
    
    def edit
        @registered_user = RegisteredUser.find(params[:id])
        @registered_user_count = RegisteredUser.count
    end
    
    def update
        # Find an existing object using form parameters
        @registered_user = RegisteredUser.find(params[:id])
        # Update the object
        if @registered_user.update_attributes(registered_user_params)
            # If update succeeds, redirect to the index action
            flash[:notice] = "Registered user updated successfully."
            redirect_to(:action => 'show', :id => @registered_user.id, :admin_id => @admin.id)
            else
            # If update fails, redisplay the form so user can fix problems
            @registered_user_count = RegisteredUser.count
            render('edit')
        end
    end
    
    def delete
        @registered_user = RegisteredUser.find(params[:id])
    end
    
    def destroy
        # Don't need to use an instance variable, can use a local variable
        registered_user = RegisteredUser.find(params[:id]).destroy
        flash[:notice] = "Registered user was destroyed successfully."
        redirect_to(:action => 'index', :admin_id => @admin.id)
    end
    
    private
    def registered_user_params
        defaults = {:admin_id => @admin.id}
        params.require(:registered_user).permit(:username,:password,:email,:subscribed).merge(defaults)
    end
    def find_admin
        if params[:admin_id]
            @admin = Admin.find(params[:admin_id])
        end
    end
end
