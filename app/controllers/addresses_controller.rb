class AddressesController < ApplicationController
  before_action :set_contact

  # DELETE /address/1/address
  def destroy
    @contact.address.destroy
  end

  # CREATE /address/1/address
  def create
    @contact.address = Address.new(address_params)

    if @contact.save
      render json: @contact.address, status: :created, location: contact_address_url(@contact)
    else
      render json: @contact.errors, status: :unprocessable_entity
    end
  end

  # PATCH /address/1/address
  def update
    if @contact.address.update(address_params)
      render json: @contact.address
    else
      render json: @contact.errors, status: :unprocessable_entity
    end
  end

  # GET /address/1/address
  def show
    render json: @contact.address
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_contact
      @address = Contact.find(params[:contact_id]).address
    end

    def address_params
      # Deserializar 
      ActiveModelSerializers::Deserialization.jsonapi_parse(params) 
    end
end
