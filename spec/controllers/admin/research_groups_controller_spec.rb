require 'spec_helper'

describe Admin::ResearchGroupsController do
  describe "Get new" do
    it_behaves_like "require sign in" do
      let(:action) { get :new }
    end

    it_behaves_like "require admin" do
      let(:action) { get :new }
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
      it "creates a new research group" do
        set_current_admin

        post :create, research_group: Fabricate.attributes_for(:research_group) 

        expect(ResearchGroup.count).to eq(1)
      end

      it "redirects to the admin research groups page" do
        set_current_admin

        post :create, research_group: Fabricate.attributes_for(:research_group) 

        expect(response).to redirect_to admin_research_groups_path
      end

      it "sets the flash success message" do
        set_current_admin

        post :create, research_group: Fabricate.attributes_for(:research_group) 

        expect(flash[:notice]).to be_present
      end
    end

    context "with invalid input" do
      it "does not create a research group" do
        set_current_admin

        post :create, research_group: { name: "" } 

        expect(ResearchGroup.count).to eq(0)
      end

      it "renders the :new template" do
        set_current_admin

        post :create, research_group: { name: "" } 

        expect(response).to render_template :new
      end

      it "sets the flash alert message" do
        set_current_admin

        post :create, research_group: { name: "" } 

        expect(flash[:alert]).to be_present
      end
    end
  end

  describe "PATCH#update" do

    let(:research_group) { Fabricate(:research_group) }

    it_behaves_like "require sign in" do
      let(:action) { patch :update, id: research_group }
    end

    it_behaves_like "require admin" do
      let(:action) { patch :update, id: research_group }
    end

    context "with valid input" do
      it "updates an existing research group" do
        set_current_admin

        patch :update, id: research_group.id, research_group: { name: "new research group" }
        research_group.reload

        expect(ResearchGroup.find(research_group.id).name).to eq("new research group")
      end

      it "redirects to the admin research groups index page" do
        set_current_admin

        patch :update, id: research_group.id, research_group: { name: "new research group" }

        expect(response).to redirect_to admin_research_groups_path
      end

      it "sets a flash success message" do
        set_current_admin

        patch :update, id: research_group.id, research_group: { name: "new research group" }

        expect(flash[:notice]).to be_present
      end
    end

    context "with invalid input" do
      it "does not update an existing record" do
        set_current_admin

        patch :update, id: research_group.id, research_group: { name: "" }
        research_group.reload

        expect(ResearchGroup.find(research_group.id).name).not_to eq("")
      end

      it "renders the edit page" do
        set_current_admin

        patch :update, id: research_group.id, research_group: { name: "" }

        expect(response).to render_template :edit
      end

      it "sets a flash alert message" do
        set_current_admin

        patch :update, id: research_group.id, research_group: { name: "" }

        expect(flash[:alert]).to be_present
      end
    end
  end

  describe "DELETE #destroy" do

    let(:research_group) { Fabricate(:research_group) }

    it_behaves_like "require sign in" do
      let(:action) { delete :destroy, id: research_group }
    end

    it_behaves_like "require admin" do
      let(:action) { delete :destroy, id: research_group }
    end

    it "deletes the research group" do
      set_current_admin

      delete :destroy, id: research_group.id

      expect(ResearchGroup.count).to eq(0)
    end

    it "sets the flash message" do
      set_current_admin

      delete :destroy, id: research_group.id

      expect(flash[:notice]).to be_present
    end
  end
end
