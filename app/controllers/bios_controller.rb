class BiosController < ApplicationController
    
    before_action :find_team_member
    layout "admin"
    
    def index
        @bios = Bio.where(team_member_id: @team_member.id, admin_id: @team_member.admin_id);
    end
    
    def show
        @bio = Bio.find(params[:id])
    end
    
    def new
        @bio = Bio.new({:biography => "Default", :team_member_id => @team_member.id, :admin_id => @team_member.admin_id})
        @bio_count = Bio.count + 1
    end
    
    def create
        # Instantiate a new object using form parameters
        @bio = Bio.new(bio_params)
        # Save the object
        if @bio.save
            # If save succeeds, redirect to the index action
            flash[:notice] = "Bio created successfully."
            redirect_to(:action => 'index', :team_member_id => @team_member.id, :admin_id => @team_member.admin_id)
            else
            # If save fails, redisplay the form so user can fix problems
            flash[:notice] = "Could not create bio."
            @bio_count = Bio.count + 1
            render('new')
        end
    end
    
    def edit
        @bio = Bio.find(params[:id])
        @bio_count = Bio.count
    end
    
    def update
        # Find an existing object using form parameters
        @bio = Bio.find(params[:id])
        # Update the object
        if @bio.update_attributes(bio_params)
            # If update succeeds, redirect to the index action
            flash[:notice] = "Bio updated successfully."
            redirect_to(:action => 'show', :id => @bio.id, :team_member_id => @team_member.id, :admin_id => @team_member.admin_id)
            else
            # If update fails, redisplay the form so user can fix problems
            flash[:notice] = "Could not update bio."
            @bio_count = Bio.count
            render('edit')
        end
    end
    
    def delete
        @bio = Bio.find(params[:id])
    end
    
    def destroy
        # Don't need to use an instance variable, can use a local variable
        bio = Bio.find(params[:id]).destroy
        flash[:notice] = "Bio was destroyed successfully."
        redirect_to(:action => 'index', :team_member_id => @team_member.id, :admin_id => @team_member.admin_id)
    end
    
    private
    def bio_params
        defaults = {:team_member_id => @team_member.id, :admin_id => @team_member.admin_id}
        params.require(:bio).permit(:biography).merge(defaults)
    end
    def find_team_member
        if params[:team_member_id]
            @team_member = TeamMember.find(params[:team_member_id])
        end
    end
end
