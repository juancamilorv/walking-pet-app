class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: [:home]

  def home
    @petwalkers = User.where(petwalker: true)
  end
end
