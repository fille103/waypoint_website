class ContactInformationsController < ApplicationController
    
    before_action :find_admin
    layout "admin"
    
    def index
        @contact_informations = ContactInformation.where(admin_id: @admin.id);
    end
    
    def show
        @contact_information = ContactInformation.find(params[:id])
    end
    
    def new
        @contact_information = ContactInformation.new({:street_address => "123 Main St.", :city => "New York", :state => "NY", :zip => "12345", :phone => "123-456-7890", :email => "example@email.com", :admin_id => @admin.id})
        @contact_information_count = ContactInformation.count + 1
    end
    
    def create
        # Instantiate a new object using form parameters
        @contact_information = ContactInformation.new(contact_information_params)
        # Save the object
        if @contact_information.save
            # If save succeeds, redirect to the index action
            flash[:notice] = "Contact information created successfully."
            redirect_to(:action => 'index', :admin_id => @admin.id)
            else
            # If save fails, redisplay the form so user can fix problems
            flash[:notice] = "Could not create contact information."
            @contact_information_count = ContactInformation.count + 1
            render('new')
        end
    end
    
    def edit
        @contact_information = ContactInformation.find(params[:id])
        @contact_information_count = ContactInformation.count
    end
    
    def update
        # Find an existing object using form parameters
        @contact_information = ContactInformation.find(params[:id])
        # Update the object
        if @contact_information.update_attributes(contact_information_params)
            # If update succeeds, redirect to the index action
            flash[:notice] = "Contact information updated successfully."
            redirect_to(:action => 'show', :id => @contact_information.id, :admin_id => @admin.id)
            else
            # If update fails, redisplay the form so user can fix problems
            @contact_information_count = ContactInformation.count
            render('edit')
        end
    end
    
    def delete
        @contact_information = ContactInformation.find(params[:id])
    end
    
    def destroy
        # Don't need to use an instance variable, can use a local variable
        contact_information = ContactInformation.find(params[:id]).destroy
        flash[:notice] = "Contact information was destroyed successfully."
        redirect_to(:action => 'index', :admin_id => @admin.id)
    end
    
    private
    def contact_information_params
        defaults = {:admin_id => @admin.id}
        params.require(:contact_information).permit(:street_address,:city,:state,:zip,:phone,:email).merge(defaults)
    end
    def find_admin
        if params[:admin_id]
            @admin = Admin.find(params[:admin_id])
        end
    end
end
