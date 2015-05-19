class RatingsController < ApplicationController
    
    layout "admin"
    
    before_action :find_registered_user
    
    def index
        @ratings = @registered_user.ratings.sorted
    end
    
    def show
        @rating = Rating.find(params[:id])
    end
    
    def new
        @rating = Rating.new({:rating => "5", :registered_user_id => @registered_user.id})
        @rating_count = Rating.count + 1
    end
    
    def create
        # Instantiate a new object using form parameters
        @rating = Rating.new(rating_params)
        # Save the object
        if @rating.save
            # If save succeeds, redirect to the index action
            flash[:notice] = "Rating created successfully."
            redirect_to(:action => 'index', :registered_user_id => @registered_user.id)
            else
            # If save fails, redisplay the form so user can fix problems
            flash[:notice] = "Could not create rating."
            @rating_count = Rating.count + 1
            render('new')
        end
    end
    
    def edit
        @rating = Rating.find(params[:id])
        @rating_count = Rating.count
    end
    
    def update
        # Find an existing object using form parameters
        @rating = Rating.find(params[:id])
        # Update the object
        if @rating.update_attributes(rating_params)
            # If update succeeds, redirect to the index action
            flash[:notice] = "Rating updated successfully."
            redirect_to(:action => 'show', :id => @rating.id, :registered_user_id => @registered_user.id)
            else
            # If update fails, redisplay the form so user can fix problems
            flash[:notice] = "Could not update rating."
            @rating_count = Rating.count
            render('edit')
        end
    end
    
    def delete
        @rating = Rating.find(params[:id])
    end
    
    def destroy
        # Don't need to use an instance variable, can use a local variable
        rating = Rating.find(params[:id]).destroy
        flash[:notice] = "Rating was destroyed successfully."
        redirect_to(:action => 'index', :registered_user_id => @registered_user.id)
    end
    
    private
    def rating_params
        defaults = {:registered_user_id => @registered_user.id}
        params.require(:rating).permit(:rating,:version_id).merge(defaults)
    end
    def find_registered_user
        if params[:registered_user_id]
            @registered_user = RegisteredUser.find(params[:registered_user_id])
        end
    end
end
