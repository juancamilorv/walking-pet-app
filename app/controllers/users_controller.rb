class UsersController < ApplicationController
  before_action :set_pet, only: :show
  before_action :set_petwalker, only: :show
  before_action :set_petwalkers, only: :show
  before_action :set_reviews, only: :show
  skip_before_action :authenticate_user!, only: [:show]

  def show
    @service = Service.new
  end

  private

  def set_pet
    @pet = Pet.where(user: current_user).first
  end

  def set_petwalker
    @petwalker = User.find(params[:id])
  end

  def set_petwalkers
    @petwalkers = [User.find(@petwalker.id)]
  end

  def set_reviews
    set_petwalker
    services = Service.where(user_id: @petwalker)
    @reviews = services.map { |service| { message: service.review, rating: service.rating } }
    # @petwalker_rating =
  end
end
