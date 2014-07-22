class Admin::ResearchThemesController < DashboardController
  def index
    @research_themes = ResearchTheme.all
  end

  def new
    @research_theme = ResearchTheme.new
  end

  def show
    @research_theme = ResearchTheme.find(params[:id])
  end

  def edit
    @research_theme = ResearchTheme.find(params[:id])
  end

  def create
    @research_theme = ResearchTheme.create(research_theme_params)
    if @research_theme.save
    redirect_to admin_research_themes_path, notice: "you successfully added a new research theme"
    else
      flash.alert = "there was a problem, the research theme could not be added"
      render :new
    end
  end


  def update
    @research_theme = ResearchTheme.find(params[:id])
    if @research_theme.update_attributes(research_theme_params)
    redirect_to admin_research_themes_path, notice: "you successfully updated the research theme"
    else
      flash.alert ="there was a problem, the research theme could not be updated"
      render :edit
    end
  end

  def destroy
    research_theme = ResearchTheme.find(params[:id])
    if research_theme.destroy
      flash[:notice] = "you successfully removed the research theme"
    else
      flash[:alert] = research_theme.errors.full_messages.join(' ')
    end

    redirect_to admin_research_themes_path
  end

  private

  def research_theme_params
    params.require(:research_theme).permit(:title, :description, :image)
  end
end
