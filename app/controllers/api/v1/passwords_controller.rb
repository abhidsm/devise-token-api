class Api::V1::PasswordsController < Devise::SessionsController
  skip_before_filter :verify_authenticity_token, :if => Proc.new { |c| c.request.format == 'application/json' }
  respond_to :json

  def create
    @user = User.send_reset_password_instructions(params[:user])
    if successfully_sent?(@user)
      render :status => 200, :json => {:success => true}
    else
      render :status => 422, :json => { :errors => @user.errors.full_messages }
    end
  end
end
