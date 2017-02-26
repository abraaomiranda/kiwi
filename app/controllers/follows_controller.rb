class FollowsController < ApplicationController
  before_action :authenticate_user!

  def create
    follow = current_user.follows_relation.create(follow_params)
    FollowCreator.new(follow).create
    redirect_to follow.followed, notice: 'Você está seguindo essa pessoa'
  end

  def destroy
    follow = Follow.find params[:id]
    follow.destroy
    redirect_to follow.followed, notice: 'Você não está mais seguindo essa pessoa'
  end

  private

  def follow_params
    params.require(:follow).permit(:followed_id)
  end
end