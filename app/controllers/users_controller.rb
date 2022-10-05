class UsersController < ApplicationController
  before_action :set_pet, only: %i[show]
  skip_before_action :authenticate_user!, only: [:show]

  def show
    @service = Service.new
    @petwalker = User.find(params[:id])
  end

  private

  def set_pet
    @pet = Pet.where(user: current_user).first
  end
end
