class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: :home
  before_action :set_petwalkers, only: :home

  def home
  end

  private

  def set_petwalkers
    @petwalkers = User.where(petwalker: true)
  end
end
