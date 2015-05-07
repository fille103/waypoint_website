class PublicController < ApplicationController
    
    layout 'public'
    
    def index
        # intro text
    end
    
    def show
        @page = Bio.where(:permalink => params[:permalink], :visible => true).first
        if @bio.nil?
            redirect_to(:action => 'index')
            else
            # display the bio content using show.html.erb
        end
    end
end
