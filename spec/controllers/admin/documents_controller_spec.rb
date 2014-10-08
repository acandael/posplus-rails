require 'spec_helper'

describe Admin::DocumentsController do
  describe "Get new" do
    before do
      @publication = Fabricate(:publication)
    end

    it_behaves_like "require sign in" do
      let(:action) { get :new , publication_id: @publication.id }
    end

    it_behaves_like "require admin" do
      let(:action) { get :new , publication_id: @publication.id }
    end

    it "sets the flash error message for regular user" do
      set_current_user

      get :new, publication_id: @publication.id

      expect(flash[:alert]).to be_present
    end
  end

  describe "POST create" do
    before do
      @publication = Fabricate(:publication)
    end

    it_behaves_like "require sign in" do
      let(:action) { post :create , publication_id: @publication.id }
    end

    it_behaves_like "require admin" do
      let(:action) { post :create , publication_id: @publication.id }
    end

    context "with valid input" do
      it "creates a new document for a publication" do
        fileupload = Rack::Test::UploadedFile.new(
          "./spec/support/uploads/vergadering.docx",
          "application/docx")

        set_current_admin

        post :create, publication_id: @publication.id, document: { file: fileupload, description: "some document" } 

        expect(@publication.documents.count).to eq(1)
      end

      it "redirects to publication documents page" do

        fileupload = Rack::Test::UploadedFile.new(
          "./spec/support/uploads/vergadering.docx",
          "application/docx")
        set_current_admin

        post :create, publication_id: @publication.id, document: { file: fileupload, description: "administration document" }

        expect(response).to redirect_to admin_publication_documents_path(@publication.id)
      end

      it "sets the flash success message" do
        fileupload = Rack::Test::UploadedFile.new(
          "./spec/support/uploads/vergadering.docx",
          "application/docx")
        set_current_admin

        post :create, publication_id: @publication.id, document: { file: fileupload, description: "administration document" }

        expect(flash[:notice]).to be_present
      end
    end

    context "with invalid input" do
      it "does not add a document to the publication" do
        set_current_admin

        post :create, publication_id: @publication.id, document: { file: "", description: "administration document" }

        expect(@publication.documents.count).to eq(0)
      end

      it "renders the :new template" do
        set_current_admin

        post :create, publication_id: @publication.id, document: { file: "", description: "administration document" }

        expect(response).to render_template :new
      end

      it "sets the alert message" do
        set_current_admin

        post :create, publication_id: @publication.id, document: { file: "", description: "administration document" }

        expect(flash[:alert]).to be_present
      end
    end
  end

  describe "PUT#update" do
    before do
      @publication = Fabricate(:publication)
      @doc = Fabricate(:document)
      @doc.publication_id = @publication.id
    end

    it_behaves_like "require sign in" do
      let(:action) { patch :update , publication_id: @doc.publication_id, id: @doc.id }
    end

    it_behaves_like "require admin" do
      let(:action) { patch :update , publication_id: @doc.publication_id, id: @doc.id }
    end

    context "with valid input" do
      it "updates an existing document" do
        fileupload = Rack::Test::UploadedFile.new(
          "./spec/support/uploads/bijlage.docx",
          "application/docx")
        @publication.documents << @doc
        @publication.save
        set_current_admin

        patch :update, publication_id: @doc.publication_id, id: @doc.id, document: { file: fileupload, description: "new description", publication_id: @doc.publication_id } 
        @doc.reload

        expect(Document.find(@doc.id).file.url).to eq("/uploads/document/file/bijlage.docx")
      end

      it "sets a flash success message" do
        fileupload = Rack::Test::UploadedFile.new(
          "./spec/support/uploads/bijlage.docx",
          "application/docx")
        @publication.documents << @doc
        @publication.save
        set_current_admin

        patch :update, publication_id: @doc.publication_id, id: @doc.id, document: { file: fileupload, description: "new description", publication_id: @doc.publication_id } 
        @doc.reload

        expect(flash[:notice]).to be_present
      end

      it "redirects to the publication documents page" do
        fileupload = Rack::Test::UploadedFile.new(
          "./spec/support/uploads/bijlage.docx",
          "application/docx")
        @publication.documents << @doc
        @publication.save
        set_current_admin

        patch :update, publication_id: @doc.publication_id, id: @doc.id, document: { file: fileupload, description: "new description", publication_id: @doc.publication_id } 
        @doc.reload

        expect(response).to redirect_to admin_publication_documents_path(@publication.id)
      end
    end

    context "with invalid input" do
      it "does not update an existing record" do
        @publication.documents << @doc
        @publication.save
        set_current_admin

        patch :update, publication_id: @doc.publication_id, id: @doc.id, document: { file: "", description: "new description", publication_id: @doc.publication_id } 

        @doc.reload

        expect(Document.find(@doc.id).file.url).not_to eq("")
      end
    end
  end

  describe "DELETE #destroy" do
    before do
      @publication = Fabricate(:publication)
      @document = Fabricate(:document)
      @document.publication_id = @publication.id
    end
    it_behaves_like "require sign in" do
      let(:action) { delete :destroy, publication_id: @document.publication_id, id: @document.id }
    end

    it_behaves_like "require admin" do
      let(:action) { delete :destroy, publication_id: @document.publication_id, id: @document.id }
    end

    it "deletes the document" do

      @document.publication_id = @publication.id
      @document.description = "some description"
      @document.save
      set_current_admin



      delete :destroy, publication_id: @publication.id, id: @document.id

      expect(Document.count).to eq(0)
    end

    it "redirects to the admin publication documents page" do
      @document.publication_id = @publication.id
      @document.description = "some description"
      @document.save
      set_current_admin

      delete :destroy, publication_id: @publication.id, id: @document.id

      expect(response).to redirect_to admin_publication_documents_path(@document.publication_id)
    end

    it "sets the flash message" do
      @document.publication_id = @publication.id
      @document.description = "some description"
      @document.save
      set_current_admin

      delete :destroy, publication_id: @publication.id, id: @document.id

      expect(flash[:notice]).to be_present
    end
  end
end
