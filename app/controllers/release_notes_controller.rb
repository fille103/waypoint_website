class ReleaseNotesController < ApplicationController
    
    layout "admin"
    
    before_action :find_version
    
    def index
        @release_notes = @version.release_notes.sorted
    end
    
    def show
        @release_note = ReleaseNote.find(params[:id])
    end
    
    def new
        @release_note = ReleaseNote.new({:note => "Default", :version_id => @version.id})
        @release_note_count = ReleaseNote.count + 1
    end
    
    def create
        # Instantiate a new object using form parameters
        @release_note = ReleaseNote.new(release_note_params)
        # Save the object
        if @release_note.save
            # If save succeeds, redirect to the index action
            flash[:notice] = "Release note created successfully."
            redirect_to(:action => 'index', :version_id => @version.id)
            else
            # If save fails, redisplay the form so user can fix problems
            flash[:notice] = "Could not create release note."
            @release_note_count = ReleaseNote.count + 1
            render('new')
        end
    end
    
    def edit
        @release_note = ReleaseNote.find(params[:id])
        @release_note_count = ReleaseNote.count
    end
    
    def update
        # Find an existing object using form parameters
        @release_note = ReleaseNote.find(params[:id])
        # Update the object
        if @release_note.update_attributes(release_note_params)
            # If update succeeds, redirect to the index action
            flash[:notice] = "Release note updated successfully."
            redirect_to(:action => 'show', :id => @release_note.id, :version_id => @version.id)
            else
            # If update fails, redisplay the form so user can fix problems
            flash[:notice] = "Could not update release note."
            @release_note_count = ReleaseNote.count
            render('edit')
        end
    end
    
    def delete
        @release_note = ReleaseNote.find(params[:id])
    end
    
    def destroy
        # Don't need to use an instance variable, can use a local variable
        release_note = ReleaseNote.find(params[:id]).destroy
        flash[:notice] = "Release note was destroyed successfully."
        redirect_to(:action => 'index', :version_id => @version.id)
    end
    
    private
    def release_note_params
        defaults = {:version_id => @version.id}
        params.require(:release_note).permit(:note).merge(defaults)
    end
    def find_version
        if params[:version_id]
            @version = Version.find(params[:version_id])
        end
    end
end
