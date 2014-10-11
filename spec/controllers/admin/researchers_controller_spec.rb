require 'spec_helper'

describe Admin::ResearchersController do
   describe "GET new" do
     it_behaves_like "require sign in" do
       let(:action) { get :new }
     end
     it_behaves_like "require admin" do
       let(:action) { get :new }
     end
     it "sets the @ researcher to a new researcher" do
       set_current_admin
       get :new
       expect(assigns(:researcher)).to be_instance_of Researcher
       expect(assigns(:researcher)).to be_new_record
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
       it "redirects to the admin researchers page" do
         set_current_admin

         post :create, researcher: Fabricate.attributes_for(:researcher) 

         expect(response).to redirect_to admin_researchers_path
       end

       it "creates a new researcher" do
         set_current_admin

         post :create, researcher: Fabricate.attributes_for(:researcher) 

         expect(Researcher.count).to eq(1)
       end

       it "sets the flash success message" do
         set_current_admin

         post :create, researcher: Fabricate.attributes_for(:researcher) 

         expect(flash[:notice]).to be_present
       end
    end

    context "with invalid input" do
      it "does not create a new researcher" do
        set_current_admin
         post :create, researcher: Fabricate.attributes_for(:researcher, first_name: "") 
         expect(Researcher.count).not_to eq(1)
      end
      it "renders the new template" do
        set_current_admin

         post :create, researcher: Fabricate.attributes_for(:researcher, first_name: "") 
         
         expect(response).to render_template :new
      end

      it "sets the @ researcher variable" do
        set_current_admin

        post :create, researcher: Fabricate.attributes_for(:researcher, first_name: "") 

        expect(assigns(:researcher)).to be_present
      end

      it "sets the flash alert message" do
        set_current_admin

         post :create, researcher: Fabricate.attributes_for(:researcher, first_name: "")  

         expect(flash[:alert]).to be_present
      end
    end
  end

  describe "PATCH#update" do

    let(:researcher) { Fabricate(:researcher) }

    it_behaves_like "require sign in" do
      let(:action) { post :create }
    end
    it_behaves_like "require admin" do
      let(:action) { post :create }
    end

    context "with valid input" do
      it "updates an existing record" do
        set_current_admin

        patch :update, id: researcher.id, researcher: Fabricate.attributes_for(:researcher) 
        researcher.reload

        expect(Researcher.find(researcher.id).first_name).to eq(researcher.first_name)
      end

      it "sets a flash success message" do
        set_current_admin

        patch :update, id: researcher.id, researcher: Fabricate.attributes_for(:researcher) 
        
        expect(flash[:notice]).to be_present
      end

      it "redirects to the admin researchers page" do
        set_current_admin

        patch :update, id: researcher.id, researcher: Fabricate.attributes_for(:researcher) 

        expect(response).to redirect_to admin_researchers_path
      end
    end

    context "with invalid input" do
      it "does not update an existing record" do
        set_current_admin

        patch :update, id: researcher.id, researcher: Fabricate.attributes_for(:researcher, first_name: "") 

        expect(Researcher.find(researcher.id).first_name).not_to eq("")
      end

      it "renders the :edit template" do
        set_current_admin

        patch :update, id: researcher.id, researcher: Fabricate.attributes_for(:researcher, first_name: "") 

        expect(response).to render_template :edit
      end

      it "sets a flash error message" do
        set_current_admin

        patch :update, id: researcher.id, researcher: Fabricate.attributes_for(:researcher, first_name: "") 

        expect(flash[:alert]).to be_present
      end
    end
  end

  describe "DELETE #destroy" do

    let(:researcher) { Fabricate(:researcher) }

    it_behaves_like "require sign in" do
      let(:action) { delete :destroy, id: researcher.id }
    end
    it_behaves_like "require admin" do
      let(:action) { delete :destroy, id: researcher.id }
    end

    it "redirects to the admin researchers page" do
      set_current_admin

      delete :destroy, id: researcher.id

      expect(response).to redirect_to admin_researchers_path
    end

    it "deletes the researcher" do
      set_current_admin

      delete :destroy, id: researcher.id

      expect(Researcher.count).to eq(0)
    end

    it "sets the flash message" do
      set_current_admin

      delete :destroy, id: researcher.id
      
      expect(flash[:notice]).to be_present
    end
  end
end
