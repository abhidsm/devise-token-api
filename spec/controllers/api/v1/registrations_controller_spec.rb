require "spec_helper"

describe Api::V1::RegistrationsController do
  describe "Sign up" do
    before :each do
      request.env['devise.mapping'] = Devise.mappings[:user]
      @credentials = {:email => 'asd@def.com', :password => 'password', :password_confirmation => 'password'}
    end
    
    it "should create the user" do
      post :create, {:user => @credentials}, :format => :json
      response.code.should eq("200")
    end

    it "should return error message if the passwords are not matching" do
      @credentials[:password] = "wrong password"
      post :create, {'user' => @credentials}, :format => :json
      response.code.should eq("401")
      response.body['password_confirmation'].should_not be_nil
    end 
  end

  describe "Change Password" do
    before :each do
      request.env['devise.mapping'] = Devise.mappings[:user]
      @credentials = {:email => 'asd@def.com', :password => 'password', :password_confirmation => 'password', :authentication_token => 'asd'}
      @user = FactoryGirl.create(:user, @credentials)
      @user.confirm!
    end
    
    it "should change the password" do
      put :update, {'user' => {'email' => 'asd@def.com', 'password' => 'new_password', 'password_confirmation' => 'new_password', :current_password => 'password'}, :auth_token => @user.authentication_token}, :format => :json
      response.code.should eq("200")
    end

    it "should return error message if the passwords are not matching" do
      @credentials[:password] = "wrong password"
      put :update, {'user' => @credentials, :auth_token => @user.authentication_token}, :format => :json
      response.code.should eq("401")
      response.body['password_confirmation'].should_not be_nil
    end 

    it "should return error message if the token is not passed" do
      put :update, {'user' => @credentials}, :format => :json
      response.code.should eq("401")
      response.body['errors'].should_not be_nil
    end 
  end
end
