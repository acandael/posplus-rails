require 'spec_helper'

describe SessionsController do
  describe "GET new" do
    it "renders the new template for unauthenticated users" do
      get :new
      expect(response).to render_template :new
    end
  end

  describe "POST create" do
    before do
      @admin = Fabricate(:admin)
      session[:user_id] = @admin.id 
    end
    it "redirects to the dashboard for authenticated admins" do
      post :create, email: @admin.email, password: @admin.password 
      expect(response).to redirect_to admin_path
    end

    it "renders the new template with invalid credentials" do
      post :create, email: "hello" , password: @admin.password 
      expect(response).to render_template :new 
    end
  end

  describe "GET destroy" do
    before do
      session[:user_id] = Fabricate(:user).id    
      get :destroy
    end
    it "redirects signed out users to the root path" do
      expect(response).to redirect_to root_path
    end

    it "clears the session for the user" do
      expect(session[:user_id]).to be_nil
    end
  end
end
