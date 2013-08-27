class Api::V1::RegistrationsController < Devise::RegistrationsController
  include ApiHelper
  skip_before_filter :verify_authenticity_token, :if => Proc.new { |c| c.request.format == 'application/json' }
  skip_before_filter :authenticate_scope!, :only => [:update]
  before_filter :validate_auth_token, :except => :create
  respond_to :json

  def create
    build_resource(sign_up_params)
 
    if resource.save
      if resource.active_for_authentication?
        return render :json => {:success => true}
      else
        expire_session_data_after_sign_in!
        return render :json => {:success => true}
      end
    else
      clean_up_passwords resource
      return render :status => 401, :json => {:errors => resource.errors}
    end
  end

  # PUT /resource
  # We need to use a copy of the resource because we don't want to change
  # the current user in place.
  def update
    prev_unconfirmed_email = resource.unconfirmed_email if resource.respond_to?(:unconfirmed_email)
    logger.debug(params[:user])
    if resource.update_with_password(account_update_params)
      if is_navigational_format?
        update_needs_confirmation?(resource, prev_unconfirmed_email)
      end
      sign_in resource_name, resource
      return render :json => {success: true}
    else
      clean_up_passwords resource
      return render :status => 401, :json => {errors: resource.errors}
    end
  end

  def account_update_params
    params.require(:user).permit( :email, :password, :password_confirmation, :current_password)
  end

  def sign_up_params
    params.require(:user).permit( :email, :password, :password_confirmation)
  end
end
