class Admin::CoursesController < DashboardController
  def index
    @courses = Course.all.order(:title)
  end

  def show
    @course = Course.find(params[:id])
  end

  def new
    @course = Course.new
  end

  def edit
    @course = Course.find(params[:id])
  end

  def create
    @course = Course.create(course_params)
    if @course.save
      redirect_to admin_courses_path, notice: "you successfully added a new course"
    else
      flash[:alert] = @course.errors.full_messages.join(' ')
      render :new
    end
  end

  def update
    @course = Course.find(params[:id])
    if @course.update_attributes(course_params)
    redirect_to admin_courses_path, notice: "You successfully updated the course"
    else
      flash.alert = @course.errors.full_messages.join(' ') 
      render :edit
    end
  end

  def destroy
    course = Course.find(params[:id])
    course.destroy
    redirect_to admin_courses_path, notice: "you successfully deleted a course"
  end

  private

  def course_params
    params.require(:course).permit(:title)
  end
end
