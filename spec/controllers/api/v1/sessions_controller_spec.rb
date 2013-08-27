require "spec_helper"

describe Api::V1::SessionsController do
  describe "Session" do
    before :each do
      request.env['devise.mapping'] = Devise.mappings[:user]
      @credentials = {:email => 'asd@def.com', :password => 'password', :authentication_token => 'asd'}
      @user = FactoryGirl.create(:user, @credentials)
      @user.confirm!
    end
    
    describe "sign in" do
      it "should sign in successfully and return authentication token" do
        post :create, {'user' => @credentials}, :format => :json
        response.code.should eq("200")
        controller.current_user.should_not be_nil
        controller.should be_signed_in
        response.body['token'].should_not be_nil
      end

      it "should return authentication failure message" do
        post :create, {'user' => {:email => 'asd@sad.com', :password => 'asd'}}, :format => :json
        response.code.should eq("401")
        controller.current_user.should be_nil
        controller.should_not be_signed_in
      end
    end

    describe "Sign Out" do
      it "should signout the user successfully" do
        sign_in @user
        delete :destroy, {:auth_token => @user.authentication_token}, :format => :json
        controller.current_user.should be_nil
        controller.should_not be_signed_in
        response.code.should eq("200")
      end

      it "should return error message if the toekn is not passed" do
        sign_in @user
        delete :destroy, :format => :json
        response.code.should eq("401")
        response.body['errors'].should_not be_nil
      end
    end

  end
end
