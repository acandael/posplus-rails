class Admin::PublicationsController < DashboardController
  def index
    @publications = Publication.all.order(:created_at)
  end

  def show
    @publication = Publication.find(params[:id])  
  end

  def new
    @publication = Publication.new
  end

  def create
    @publication = Publication.create(publication_params)
    if @publication.save
      redirect_to admin_publications_path, notice: "You successfully added a publication"
    else
      flash[:alert] = @publication.errors.full_messages.join(' ')
      render :new
    end
  end

  def edit
    @publication = Publication.find(params[:id])
  end

  def update
    @publication = Publication.find(params[:id])
    if @publication.update_attributes(publication_params)
      redirect_to admin_publications_path, notice: "You successfully updated the publication"
    else
      flash[:alert] = @publication.errors.full_messages.join(' ')
      render :edit
    end
  end

  def destroy
    publication = Publication.find(params[:id])
    publication.destroy
    redirect_to admin_publications_path, notice: "You successfully deleted the publication"
  end

  def hide
    @publication = Publication.find(params[:id])
    @publication.toggle_visibility!
    render "hide.js.erb"
  end
  
  private

  def publication_params
    params.require(:publication).permit(:title, :reference, :visible, :research_project_ids => [])
  end
end
