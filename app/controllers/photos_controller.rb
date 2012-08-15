class PhotosController < InheritedResources::Base
  respond_to :html, :json

  before_filter :authenticate_user!

  def index 
    @photos = Photo.paginate(page: params[:page], per_page: 10)  
  end

  def create
    create! do |format|
      format.html { redirect_to main_path                            }
      format.json { render json: resource.to_json, status: :ok }
      format.js   { render json: resource.to_json, status: :ok }
    end
  end

  protected

  def begin_of_association_chain
    current_user
  end

end
