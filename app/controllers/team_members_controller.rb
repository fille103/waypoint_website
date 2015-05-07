class TeamMembersController < ApplicationController
    
    layout "admin"
    
    def index
        @team_members = TeamMember.sorted
    end
    
    def show
        @team_member = TeamMember.find(params[:id])
    end
    
    def new
        @team_member = TeamMember.new({:first_name => "Default", :last_name => "Default", :admin_id => "0"})
        #@bio = Bio.new({:biography => "Default", :team_member_id => "0"})
        @team_member_count = TeamMember.count + 1
    end
    
    def create
        # Instantiate a new object using form parameters
        @team_member = TeamMember.new(team_member_params)
        #@bio = Bio.new(bio_params)
        # Save the object
        if @team_member.save
            # If save succeeds, redirect to the index action
            flash[:notice] = "Team member created successfully."
            redirect_to(:action => 'index')
            else
            # If save fails, redisplay the form so user can fix problems
            flash[:notice] = "Team member not created successfully."
            @team_member_count = TeamMember.count + 1
            render('new')
        end
    end
    
    def edit
        @team_member = TeamMember.find(params[:id])
        @team_member_count = TeamMember.count
    end
    
    def update
        # Find an existing object using form parameters
        @team_member = TeamMember.find(params[:id])
        # Update the object
        if @team_member.update_attributes(team_member_params)
            # If update succeeds, redirect to the index action
            flash[:notice] = "Team member updated successfully."
            redirect_to(:action => 'show', :id => @team_member.id)
            else
            # If update fails, redisplay the form so user can fix problems
            @team_member_count = TeamMember.count
            render('edit')
        end
    end
    
    def delete
        @team_member = TeamMember.find(params[:id])
    end
    
    def destroy
        # Don't need to use an instance variable, can use a local variable
        team_member = TeamMember.find(params[:id]).destroy
        flash[:notice] = "Team member was destroyed successfully."
        redirect_to(:action => 'index')
    end
    
    
    private
    def team_member_params
        # same as using "params[:speaker]", except that it:
        # - raises an error if :speaker is not present
        # - allows listed attributes to be mass-assigned
        params.require(:team_member).permit(:first_name,:last_name,:admin_id)
    end
    def bio_params
        # same as using "params[:speaker]", except that it:
        # - raises an error if :speaker is not present
        # - allows listed attributes to be mass-assigned
        params.require(:bio).permit(:biography)
    end
end
