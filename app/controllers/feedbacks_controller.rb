class FeedbacksController < ApplicationController
    
    before_action :find_registered_user
    layout "admin"
    
    def index
        @feedbacks = @registered_user.feedbacks.sorted
    end
    
    def show
        @feedback = Feedback.find(params[:id])
    end
    
    def new
        @feedback = Feedback.new({:feedback => "Default", :registered_user_id => @registered_user.id, :admin_id => @registered_user.admin_id})
        @feedback_count = Feedback.count + 1
    end
    
    def create
        # Instantiate a new object using form parameters
        @feedback = Feedback.new(feedback_params)
        # Save the object
        if @feedback.save
            # If save succeeds, redirect to the index action
            flash[:notice] = "Feedback created successfully."
            redirect_to(:action => 'index', :registered_user_id => @registered_user.id, :admin_id => @registered_user.admin_id)
            else
            # If save fails, redisplay the form so user can fix problems
            flash[:notice] = "Could not create feedback."
            @feedback_count = Feedback.count + 1
            render('new')
        end
    end
    
    def edit
        @feedback = Feedback.find(params[:id])
        @feedback_count = Feedback.count
    end
    
    def update
        # Find an existing object using form parameters
        @feedback = Feedback.find(params[:id])
        # Update the object
        if @feedback.update_attributes(feedback_params)
            # If update succeeds, redirect to the index action
            flash[:notice] = "Feedback updated successfully."
            redirect_to(:action => 'show', :id => @feedback.id, :registered_user_id => @registered_user.id, :admin_id => @registered_user.admin_id)
            else
            # If update fails, redisplay the form so user can fix problems
            flash[:notice] = "Could not update feedback."
            @feedback_count = Feedback.count
            render('edit')
        end
    end
    
    def delete
        @feedback = Feedback.find(params[:id])
    end
    
    def destroy
        # Don't need to use an instance variable, can use a local variable
        feedback = Feedback.find(params[:id]).destroy
        flash[:notice] = "Feedback was destroyed successfully."
        redirect_to(:action => 'index', :registered_user_id => @registered_user.id, :admin_id => @registered_user.admin_id)
    end
    
    private
    def feedback_params
        defaults = {:registered_user_id => @registered_user.id, :admin_id => @registered_user.admin_id}
        params.require(:feedback).permit(:feedback).merge(defaults)
    end
    def find_registered_user
        if params[:registered_user_id]
            @registered_user = RegisteredUser.find(params[:registered_user_id])
        end
    end
end
