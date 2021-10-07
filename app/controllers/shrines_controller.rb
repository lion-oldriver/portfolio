class ShrinesController < ApplicationController
  def index
    @shrines = Shrine.includes(:shrine_gods, :gods, :shrine_tags, :tags)
  end

  def show
    @shrine = Shrine.find(params[:id])
    @near_shrine = @shrine.nearbys(2, units: :km)
    gon.shrine = @shrine
    gon.shrines = @near_shrine
    @posts = Post.where(shrine_id: @shrine.id).includes(:user, :shrine, :post_images)
  end

  def search_tag
    @tag = Tag.find_by(tag_name: params[:tag_name])
    @shrines = @tag.shrine.includes(:shrine_gods, :gods, :shrine_tags, :tags)
  end
end
