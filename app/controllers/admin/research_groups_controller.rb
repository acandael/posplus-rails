class Admin::ResearchGroupsController < DashboardController
  def index
    @research_groups = ResearchGroup.all.by_name
  end

  def show
    @research_group = ResearchGroup.find(params[:id])
  end

  def new
    @research_group = ResearchGroup.new
  end

  def edit
    @research_group = ResearchGroup.find(params[:id])
  end

  def create
    @research_group = ResearchGroup.create(research_group_params)
    if @research_group.save
      redirect_to admin_research_groups_path, notice: "you successfully added research group"
    else
      flash.alert = @research_group.errors.full_messages.join(' ')
      render :new
    end
  end

  def update
    @research_group = ResearchGroup.find(params[:id])
    if @research_group.update(research_group_params)
    redirect_to admin_research_groups_path, notice: "you successfully updated the research group"
    else
      flash[:alert] = @research_group.errors.full_messages.join(' ')
      render :edit
    end
  end

  def destroy
    research_group = ResearchGroup.find(params[:id])
    research_group.destroy
    redirect_to admin_research_groups_path, notice: "you successfully deleted research group"
  end


  private

  def research_group_params
    params.require(:research_group).permit(:name, :image, :remove_image, :website)
  end
end
