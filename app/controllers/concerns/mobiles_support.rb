module MobilesSupport

  private

    def mobile_params
      params.require(:mobile).permit(:number, :country)
    end

    def valid_mobile?
      phone_object = TelephoneNumber.parse(params[:mobile][:number], params[:mobile][:country])
      phone_object.valid?
    end
end 