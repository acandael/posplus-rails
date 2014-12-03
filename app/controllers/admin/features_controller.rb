class Admin::FeaturesController < DashboardController
  def index
    @features = Feature.all
  end

  def show
    @feature = Feature.find(params[:id])
  end

  def new
    @feature = Feature.new
  end

  def edit
    @feature = Feature.find(params[:id])
  end

  def create
    @feature = Feature.create(feature_params)
    if @feature.save
      redirect_to admin_features_path, notice: "You successfully added a new feature!"
    else
      flash[:alert] = @feature.errors.full_messages.join(' ') 
      render :new
    end
  end

  def update
    @feature = Feature.find(params[:id])
    if @feature.update(feature_params)
      redirect_to admin_features_path, notice: "You successfully updated the feature!"
    else
      flash[:alert] = @feature.errors.full_messages.join(' ')
      render :edit
    end
  end

  def destroy
    feature = Feature.find(params[:id])
    feature.destroy
    redirect_to admin_features_path, notice: "You successfully deleted the feature"
  end

  private

  def feature_params
    params.require(:feature).permit(:title, :body, :image, :remove_image, :document)
  end
end
