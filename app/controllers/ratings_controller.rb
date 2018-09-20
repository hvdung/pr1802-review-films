class RatingsController < ApplicationController
  before_action :logged_in_user, only: :create
  before_action :find_rate, only: [:edit, :update]

  def create
    @rate = Rating.new rate_params
    if @rate.save
      flash[:info] = t ".rating_created"
      redirect_to film_path @rate.film_id
    else
      flash[:alert] = t ".rating_created_error"
      render "films/show"
    end
  end

  def edit
  end

  def update
    if @rate.update rate_params
      flash[:alert] = t ".rating_updated"
      redirect_to film_path @rate.film_id
    else
      flash[:alert] = t ".rating_updated_error"
      render "films/show"
    end
  end

  private

  def rate_params
    params.require(:rating).permit(:rate, :film_id).merge user_id: current_user.id
  end

  def find_rate
    @rate = current_user.ratings.find_by film_id: params[:id]
  end
end
