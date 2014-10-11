require 'spec_helper'

describe Admin::ResearchThemesController do
  describe "Get new" do
    it_behaves_like "require sign in" do
      let(:action) { get :new }
    end
    it_behaves_like "require admin" do
      let(:action) { get :new }
    end

    it "sets the @ researchtheme to a new research theme" do
      set_current_admin
      get :new
      expect(assigns(:research_theme)).to be_instance_of ResearchTheme
    end

    it "sets the flash error message for regular user" do
      set_current_user
      get :new
      expect(flash[:alert]).to be_present
    end
  end

  describe "POST create" do
    it_behaves_like "require sign in" do
      let(:action) { post :create }
    end
    it_behaves_like "require admin" do
      let(:action) { post :create }
    end

    context "with valid input" do
      it "creates a new research theme" do
        set_current_admin
        post :create, research_theme: { title: "research theme 1", description: "description for research theme 1" }
        expect(ResearchTheme.count).to eq(1)
      end

      it "redirects to the research themes page" do
        set_current_admin
        post :create, research_theme: { title: "research theme 1", description: "description for research theme 1" }
        expect(response).to redirect_to admin_research_themes_path
      end

      it "sets the flash success message" do
        set_current_admin
        post :create, research_theme: { title: "research theme 1", description: "description for research theme 1" }
        expect(flash[:notice]).to be_present
      end
    end
    context "with invalid input" do
      it "does not create a new research theme" do
        set_current_admin
        post :create, research_theme: { description: "description for research theme 1" }
        expect(ResearchTheme.count).to eq(0)
      end

      it "renders the :new template" do
        set_current_admin
        post :create, research_theme: { description: "description for research theme 1" }
        expect(response).to render_template :new
      end

      it "sets the flash alert message" do
        set_current_admin
        post :create, research_theme: { description: "description for research theme 1" }
        expect(flash[:alert]).to be_present
      end
    end
  end

  describe "PUT#update" do
    let(:research_theme) { Fabricate(:research_theme) }
    it_behaves_like "require sign in" do
      let(:action) { post :update, id: research_theme.id }
    end

    it_behaves_like "require admin" do
      let(:action) { post :update, id: research_theme.id }
    end

    context "with valid input" do
      it "updates an existing record" do
        set_current_admin
        put :update, id: research_theme.id, research_theme: { id: research_theme.id, title: "new title", description: research_theme.description }
        expect(ResearchTheme.find(research_theme.id).title).to eq("new title")
      end

      it "sets a flash success message" do
        set_current_admin
        put :update, id: research_theme.id, research_theme: { id: research_theme.id, title: "new title", description: research_theme.description }
        expect(flash[:notice]).to be_present
      end

      it "redirects to the research themes index page" do
        set_current_admin
        put :update, id: research_theme.id, research_theme: { id: research_theme.id, title: "new title", description: research_theme.description }
        expect(response).to redirect_to admin_research_themes_path
      end
    end

    context "with invalid input" do
      it "does not update an existing record" do
        set_current_admin
        put :update, id: research_theme.id, research_theme: { id: research_theme.id, title: "new title", description: nil }
        expect(ResearchTheme.find(research_theme.id).description).not_to eq("")
      end

      it "renders the edit page" do
        set_current_admin
        put :update, id: research_theme.id, research_theme: { id: research_theme.id, title: "new title", description: nil }
        expect(response).to render_template :edit
      end

      it "set a flash alert message" do
        set_current_admin
        put :update, id: research_theme.id, research_theme: { id: research_theme.id, title: "new title", description: nil }
        expect(flash[:alert]).to be_present
      end
    end
  end

  describe "DELETE #destroy" do

    let(:research_theme) { Fabricate(:research_theme) }

    it_behaves_like "require sign in" do
      let(:action) { post :update, id: research_theme.id }
    end

    it_behaves_like "require admin" do
      let(:action) { post :update, id: research_theme.id }
    end

    it "deletes the research theme" do
      set_current_admin
      delete :destroy, id: research_theme.id
      expect(ResearchTheme.count).to eq(0)
    end

    it "redirects to the admin research themes page" do
      set_current_admin
      delete :destroy, id: research_theme.id
      expect(response).to redirect_to admin_research_themes_path
    end

    it "set the flash message" do
      set_current_admin
      delete :destroy, id: research_theme.id
      expect(flash[:notice]).to be_present
    end
  end
end

