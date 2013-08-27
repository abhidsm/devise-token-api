require "spec_helper"

describe "routes for Devise" do
  it "routes /api/v1/users/sign_in to the sessions controller" do
    { :get => "/api/v1/users/sign_in" }.
      should route_to(:controller => "api/v1/sessions", :action => "new")
  end

  it "routes /api/v1/users/sign_out to the sessions controller" do
    { :delete => "/api/v1/users/sign_out" }.
      should route_to(:controller => "api/v1/sessions", :action => "destroy")
  end

  it "routes /api/v1/users to the registrations controller" do
    { :post => "/api/v1/users" }.
      should route_to(:controller => "api/v1/registrations", :action => "create")
  end

  it "routes /api/v1/users to the registrations controller" do
    { :put => "/api/v1/users" }.
      should route_to(:controller => "api/v1/registrations", :action => "update")
  end

  it "routes /api/v1/users/password/new to the passwords controller" do
    { :get => "/api/v1/users/password/new" }.
      should route_to(:controller => "api/v1/passwords", :action => "new")
  end
end
