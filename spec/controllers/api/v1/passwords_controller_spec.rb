require "spec_helper"

describe Api::V1::PasswordsController do
  describe "forgot password" do
    before :each do
      request.env['devise.mapping'] = Devise.mappings[:user]
      @credentials = {:email => 'asd@def.com', :password => 'password'}
      @user = FactoryGirl.create(:user, @credentials)
      @user.confirm!
    end
    
    it "should send reset password request" do
      post :create, {'user' => {:email => 'asd@def.com'}}, :format => :json
      response.code.should eq("200")
    end

    it "should return error message if invalid user" do
      post :create, {'user' => {:email => 'abc@def.com'}}, :format => :json
      response.code.should eq("422")
    end 
 end
end
