class ReviewsController < ApplicationController
    
    layout "admin"
    
    before_action :find_rating
    
    def index
        @reviews = Review.where(rating_id: @rating.id);
    end
    
    def show
        @review = Review.find(params[:id])
    end
    
    def new
        @review = Review.new({:subject => "Default", :message => "Default", :rating_id => @rating.id})
        @review_count = Review.count + 1
    end
    
    def create
        # Instantiate a new object using form parameters
        @review = Review.new(review_params)
        # Save the object
        if @review.save
            # If save succeeds, redirect to the index action
            flash[:notice] = "Review created successfully."
            redirect_to(:action => 'index', :rating_id => @rating.id)
            else
            # If save fails, redisplay the form so user can fix problems
            flash[:notice] = "Could not create review."
            @review_count = Review.count + 1
            render('new')
        end
    end
    
    def edit
        @review = Review.find(params[:id])
        @review_count = Review.count
    end
    
    def update
        # Find an existing object using form parameters
        @review = Review.find(params[:id])
        # Update the object
        if @review.update_attributes(review_params)
            # If update succeeds, redirect to the index action
            flash[:notice] = "Review updated successfully."
            redirect_to(:action => 'show', :id => @review.id, :rating_id => @rating.id)
            else
            # If update fails, redisplay the form so user can fix problems
            flash[:notice] = "Could not update review."
            @review_count = Review.count
            render('edit')
        end
    end
    
    def delete
        @review = Review.find(params[:id])
    end
    
    def destroy
        # Don't need to use an instance variable, can use a local variable
        review = Review.find(params[:id]).destroy
        flash[:notice] = "Review was destroyed successfully."
        redirect_to(:action => 'index', :rating_id => @rating.id)
    end
    
    private
    def review_params
        defaults = {:rating_id => @rating.id}
        params.require(:review).permit(:subject,:message).merge(defaults)
    end
    def find_rating
        if params[:rating_id]
            @rating = Rating.find(params[:rating_id])
        end
    end
end
