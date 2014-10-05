require 'spec_helper'

describe Admin::NewsItemsController do
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
      it "creates a new research theme" do
        set_current_admin

        post :create, news_item: { title: "news item 1", body: "this is the content" }
        expect(NewsItem.count).to eq(1)
      end

      it "redirects to the news items page" do
        set_current_admin

        post :create, news_item: { title: "news item 1", body: "this is the content" }
        
        expect(response).to redirect_to admin_news_items_path
      end

      it "sets the flash success message" do
        set_current_admin

        post :create, news_item: { title: "news item 1", body: "this is the content" }
        expect(flash[:notice]).to be_present
      end
    end

    context "with invalid input" do
      it "does not create a new news item" do
        set_current_admin

        post :create, news_item: { title: "", body: "this is the content" }

        expect(NewsItem.count).to eq(0)
      end

      it "renders the :new template" do
        set_current_admin

        post :create, news_item: { title: "", body: "this is the content" }

        expect(response).to render_template :new
      end

      it "sets the flash alert message" do
        set_current_admin

        post :create, news_item: { title: "", body: "this is the content" }

        expect(flash[:alert]).to be_present
      end
    end
  end

  describe "PUT#update" do
    before do
      @news_item = Fabricate(:news_item)
    end

    it_behaves_like "require sign in" do
      let(:action) { patch :update, id: @news_item.id }
    end

    it_behaves_like "require admin" do
      let(:action) { patch :update, id: @news_item.id }
    end

    context "with valid input" do
      it "updates an existing record" do
        set_current_admin

        patch :update, id: @news_item.id, news_item: { title: "new title" }
        @news_item.reload

        expect(NewsItem.find(@news_item.id).title).to eq("new title") 
      end

      it "sets a flash success message" do
        set_current_admin
        
        patch :update, id: @news_item.id, news_item: { title: "new title" }

        expect(flash[:notice]).to be_present
      end

      it "redirects to the news items index page" do
        set_current_admin
        
        patch :update, id: @news_item.id, news_item: { title: "new title" }

        expect(response).to redirect_to admin_news_items_path
      end
    end

    context "with invalid input" do
      it "does not update and existing record" do
        set_current_admin
        
        patch :update, id: @news_item.id, news_item: { title: "" }
        @news_item.reload 

        expect(NewsItem.find(@news_items.id).title).not_to eq("")
      end

      it "renders the edit page" do
        set_current_admin
        
        patch :update, id: @news_item.id, news_item: { title: "" }

        expect(response).to render_template :edit
      end

      it "sets a flash alert message" do
        set_current_admin
        
        patch :update, id: @news_item.id, news_item: { title: "" }

        expect(flash[:alert]).to be_present
      end
    end
  end

  describe "DELETE #destroy" do
    before do
      @news_item = Fabricate(:news_item)
    end

    it_behaves_like "require sign in" do
      let(:action) { delete :destroy, id: @news_item }
    end

    it "deletes the researcher" do
      set_current_admin

      delete :destroy, id: @news_item.id

      expect(NewsItem.count).to eq(0)
    end

    it "redirects to the admin news items page" do
      set_current_admin

      delete :destroy, id: @news_item.id

      expect(response).to redirect_to admin_news_items_path
    end

    it "sets the flash message" do
      set_current_admin

      delete :destroy, id: @news_item.id

      expect(flash[:notice]).to be_present
    end
  end
end
