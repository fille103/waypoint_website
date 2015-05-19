class RegisteredUsersController < ApplicationController
    
    layout "admin"
    
    before_action :confirm_logged_in
    
    def index
        @registered_users = RegisteredUser.sorted
    end
    
    def show
        @registered_user = RegisteredUser.find(params[:id])
    end
    
    def new
        @registered_user = RegisteredUser.new({:username => "User", :password => "Default", :email => "user@email.com", :subscribed => true})
        @registered_user_count = RegisteredUser.count + 1
    end
    
    def create
        # Instantiate a new object using form parameters
        @registered_user = RegisteredUser.new(registered_user_params)
        # Save the object
        if @registered_user.save
            # If save succeeds, redirect to the index action
            flash[:notice] = "Registered user created successfully."
            redirect_to(:action => 'index')
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
            redirect_to(:action => 'show', :id => @registered_user.id)
            else
            # If update fails, redisplay the form so user can fix problems
            flash[:notice] = "Could not update registered user."
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
        redirect_to(:action => 'index')
    end
    
    private
    def registered_user_params
        params.require(:registered_user).permit(:username,:password,:email,:subscribed)
    end
end
