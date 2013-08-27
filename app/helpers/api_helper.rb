module ApiHelper
  def validate_auth_token
    self.resource = User.find_by_authentication_token(params[:auth_token])
    render :status => 401, :json => {errors: [t('api.v1.token.invalid_token')]} if self.resource.nil?
  end
end
