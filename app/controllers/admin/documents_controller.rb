class Admin::DocumentsController < DashboardController
  def index
   @publication = Publication.find(params[:publication_id])
   @documents = Document.by_publication(params[:publication_id])
  end

  def show
    @document = Document.find(params[:id])
  end

  def new
    @document = Document.new
    @publication = Publication.find(params[:publication_id])
  end

  def create
    @document = Document.create(document_params) 
    @document.publication_id = params[:publication_id]
    if @document.save
      redirect_to admin_publication_documents_path(@document.publication_id), notice: "A new document was added to the publication"
    else
      flash[:alert] = @document.errors.full_messages.join(' ')
      @publication = Publication.find(params[:publication_id])
      render :new
    end
  end

  def edit
    @document = Document.find(params[:id])
    @publication = Publication.find(params[:publication_id])
  end

  def update
    @document = Document.find(params[:id])
    if @document.update_attributes(document_params)
      redirect_to admin_publication_documents_path(@document.publication_id), notice: "You successfully updated the document"
    else
      render :edit
    end
  end

  def destroy
   document = Document.find(params[:id])
   document.destroy
   redirect_to admin_publication_documents_path(document.publication_id), notice: "You successfully deleted the document"
  end

  private

  def document_params
  params.require(:document).permit(:file, :description, :publication_id)
  end
end
