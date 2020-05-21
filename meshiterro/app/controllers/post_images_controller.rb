class PostImagesController < ApplicationController
  def new
    @post_image = PostImage.new
  end

  def create
    @post_image = PostImage.new(post_image_params)
    @post_image.user_id = current_user.id
    if @post_image.save
      redirect_to post_images_path
    else
      flash[:notice] = "e?"
      render :new
    end
  end
  

  def index
    @post_images = PostImage.all
  end
  
  def show
    @post_image = PostImafe.find(params[:id])
  end
  
  private 

  def post_image_params
    params.require(:post_image).permit(:image, :shop_name, :caption)
  end
  
end
