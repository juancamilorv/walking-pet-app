class Service < ApplicationRecord
  belongs_to :pet
  belongs_to :user
  after_save :set_price

  private

  def set_price
    if finished_at && started_at

      time_in_hours = ((finished_at - started_at) / 3600).round
      self.price = user.price_per_hour * time_in_hours
    end
  end
end
