class CommunitiesController < ApplicationController
  before_action :set_community, only: [:show, :edit, :update, :destroy]
  skip_before_action :authenticate_user!, only: [:index, :show]
  
  def index
    @communities = Community.all
  end

  def show
    @community = Community.find(params[:id])
    @articles = @community.articles
  end

  def new
    @community = Community.new
  end

  def create
    @community = Community.new(community_params)
    @community.user = current_user
    if @community.save
      redirect_to @community, notice: 'Community member was successfully created.'
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @community.update(community_params)
      redirect_to @community, notice: "Community member was successfully updated."
    else
      render :edit
    end
  end

  def destroy
    @community.destroy
    redirect_to communities_path, notice: "Community member was successfully deleted."
  end

  private

  def set_community
    @community = Community.find(params[:id])
  end

  def community_params
    params.require(:community).permit(:first_name, :last_name, :description, :profile_picture, :group)
  end
end

