class Admin::ResearchersController < DashboardController
  def index
    @researchers = Researcher.all.order(:last_name)
  end

  def show
    @researcher = Researcher.find(params[:id])
  end

  def new
    @researcher = Researcher.new
  end

  def edit
    @researcher = Researcher.find(params[:id])
  end

  def create
    @researcher = Researcher.create(researcher_params)
    if @researcher.save
      redirect_to admin_researchers_path, notice: "You successfully added a new researcher"
    else
      flash[:alert] = @researcher.errors.full_messages.join(' ') 
      render :new
    end
  end

  def update
    @researcher = Researcher.find(params[:id])
    if @researcher.update_attributes(researcher_params)
      redirect_to admin_researchers_path, notice: "you successfully updated the researcher #{@researcher.fullname}"
    else
      flash[:alert] = @researcher.errors.full_messages.join(' ')
      render :edit
    end
  end

  def destroy
    researcher = Researcher.find(params[:id])
    researcher.destroy
    redirect_to admin_researchers_path, notice: "You successfully removed the researcher"
  end

  def hide
    @researcher = Researcher.find(params[:id])
    @researcher.toggle_visibility!
    render "hide.js.erb"
  end

  private

  def researcher_params
    params.require(:researcher).permit(:active, :first_name, :last_name, :bio, :phone, :email, :address, :image, :title, :visible, :bibliography, :research_project_ids => [], :course_ids => [])
  end
end
