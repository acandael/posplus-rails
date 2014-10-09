require 'spec_helper'

describe Admin::PublicationsController do
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
      it "creates a new publication" do
        set_current_admin

        post :create, publication: Fabricate.attributes_for(:publication) 

        expect(Publication.count).to eq(1)
      end

      it "redirects to the publications page" do
        set_current_admin

        post :create, publication: Fabricate.attributes_for(:publication) 

        expect(response).to redirect_to admin_publications_path
      end

      it "sets the flash success message" do
        set_current_admin

        post :create, publication: Fabricate.attributes_for(:publication) 

        expect(flash[:notice]).to be_present
      end
    end

    context "with invalid input" do
      it "does not create a publication" do
        set_current_admin

        post :create, publication: { title: "", body: "some bodytext", year: 2014 }

        expect(Publication.count).not_to eq(1)
      end

      it "renders the :new template" do
        set_current_admin

        post :create, publication: { title: "", body: "some bodytext", year: 2014 }

        expect(response).to render_template :new
      end

      it "sets the flash alert message" do
        set_current_admin

        post :create, publication: { title: "", body: "some bodytext", year: 2014 }

        expect(flash[:alert]).to be_present
      end
    end
  end

  describe "PATCH#update" do
    let(:publication) { Fabricate(:publication) }

    it_behaves_like "require sign in" do
      let(:action) { patch :update, id: publication.id }
    end

    it_behaves_like "require admin" do
      let(:action) { patch :update, id: publication.id }
    end

    context "with valid input" do
      it "updates an existing publication" do
        set_current_admin

        patch :update, id: publication.id, publication: { title: "new title" }

        expect(Publication.find(publication.id).title).to eq("new title")
      end

      it "redirects to the publications page" do
        set_current_admin

        patch :update, id: publication.id, publication: { title: "new title" }

        expect(response).to redirect_to admin_publications_path
      end

      it "sets a flash success message" do
        set_current_admin

        patch :update, id: publication.id, publication: { title: "new title" }

        expect(flash[:notice]).to be_present
      end
    end

    context "with invalid input" do
      it "does not update a publication" do
        set_current_admin

        patch :update, id: publication.id, publication: { title: "" }
        publication.reload

        expect(Publication.find(publication.id).title).not_to eq("")
      end

      it "renders the :edit page" do
        set_current_admin

        patch :update, id: publication.id, publication: { title: "" }
        publication.reload

        expect(response).to render_template :edit
      end

      it "sets a flash alert message" do
        set_current_admin

        patch :update, id: publication.id, publication: { title: "" }
        publication.reload

        expect(flash[:alert]).to be_present
      end
    end
  end

  describe "DELETE #destroy" do
    let(:publication) { Fabricate(:publication) }

    it_behaves_like "require sign in" do
      let(:action) { delete :destroy, id: publication.id }
    end

    it_behaves_like "require admin" do
      let(:action) { delete :destroy, id: publication.id }
    end

    it "deletes the publication" do
      set_current_admin

      delete :destroy, id: publication.id

      expect(Publication.count).to eq(0)
    end

    it "redirects to the admin publications page" do
      set_current_admin

      delete :destroy, id: publication.id

      expect(response).to redirect_to admin_publications_path
    end

    it "sets the flash message" do
      set_current_admin

      delete :destroy, id: publication.id

      expect(flash[:notice]).to be_present
    end
  end
end
