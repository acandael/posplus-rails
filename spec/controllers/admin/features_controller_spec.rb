require 'spec_helper'

describe Admin::FeaturesController do
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
      it "creates a new feature" do
        set_current_admin

        post :create, feature: Fabricate.attributes_for(:feature)

        expect(Feature.count).to eq(1)
      end

      it "redirects to the features page" do
        set_current_admin

        post :create, feature: Fabricate.attributes_for(:feature)

        expect(response).to redirect_to admin_features_path
      end

      it "sets the flash success messagge" do
        set_current_admin

        post :create, feature: Fabricate.attributes_for(:feature)

        expect(flash[:notice]).to be_present
      end
    end

    context "with invalid input" do
      it "does not create a feature" do
        set_current_admin

        post :create, feature: { title: "", body: "some bodytext" } 

        expect(Feature.count).not_to eq(1)
      end

      it "renders the :new template" do
        set_current_admin

        post :create, feature: { title: "", body: "some bodytext" } 

        expect(response).to render_template :new
      end

      it "sets the flash alert message" do
        set_current_admin

        post :create, feature: { title: "", body: "some bodytext" } 

        expect(flash[:alert]).to be_present
      end
    end
  end

  describe "PATCH#update" do
    let(:feature) { Fabricate(:feature) }

    it_behaves_like "require sign in" do
      let(:action) { patch :update, id: feature.id }
    end

    it_behaves_like "require sign in" do
      let(:action) { patch :update, id: feature.id }
    end

    context "with valid input" do
      it "updates a feature" do
        set_current_admin

        patch :update, id: feature.id, feature: { title: "new title" }

        expect(Feature.find(feature.id).title).to eq("new title")
      end

      it "redirects to the features page" do
        set_current_admin

        patch :update, id: feature.id, feature: { title: "new title" }

        expect(response).to redirect_to admin_features_path
      end

      it "sets a flash success message" do
        set_current_admin

        patch :update, id: feature.id, feature: { title: "new title" }

        expect(flash[:notice]).to be_present
      end
    end

    context "with invalid path" do
      it "does not update a feature" do
        set_current_admin

        patch :update, id: feature.id, feature: { title: "" }
        feature.reload

        expect(Feature.find(feature.id).title).not_to eq("")
      end

      it "renders the :edit page" do
        set_current_admin

        patch :update, id: feature.id, feature: { title: "" }
        feature.reload

        expect(response).to render_template :edit
      end

      it "sets a flash alert message" do
        set_current_admin

        patch :update, id: feature.id, feature: { title: "" }
        feature.reload

        expect(flash[:alert]).to be_present
      end
    end
  end

  describe "DELETE #destroy" do
    let(:feature) { Fabricate(:feature) }

    it_behaves_like "require sign in" do
      let(:action) { delete :destroy, id: feature.id }
    end

    it_behaves_like "require admin" do
      let(:action) { delete :destroy, id: feature.id }
    end

    it "deletes the feature" do
      set_current_admin

      delete :destroy, id: feature.id

      expect(Feature.count).to eq(0)
    end

    it "redirects to the admin features page" do
      set_current_admin

      delete :destroy, id: feature.id

      expect(response).to redirect_to admin_features_path
    end

    it "sets the flash message" do
      set_current_admin

      delete :destroy, id: feature.id

      expect(flash[:notice]).to be_present
    end
  end
end
