class PhonesController < ApplicationController
  before_action :set_contact

  # GET /contacts/1/phones
  def show
    render json: @contact.phones
  end

  # DELETE /phones/1/phones
  def destroy
    phone = Phone.find(phone_params[:id])
    phone.destroy
  end

  # CREATE /phones/1/phones
  def create
    @contact.phones << Phone.new(phone_params)

    if @contact.save
      render json: @contact.phones, status: :created, location: contact_phones_url(@contact)
    else
      render json: @contact.errors, status: :unprocessable_entity
    end
  end

  # PATCH /phones/1/phones
  def update
    phone = Phone.find(phone_params[:id])
 
    if @contact.phones.update(phone_params)
      render json: @contact.phones
    else
      render json: @contact.errors, status: :unprocessable_entity
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_contact
      @contacts = Contact.find(params[:contact_id])
    end

    def phone_params
      # Deserializar 
      ActiveModelSerializers::Deserialization.jsonapi_parse(params) 
    end
end
