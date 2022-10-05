class ServicesController < ApplicationController
  before_action :set_pet, only: %i[new create]
  before_action :set_service, only: %i[show update]

  def index
    set_services
  end

  def show
  end

  def new
    @service = Service.new
  end

  def create
    @service = Service.new(service_params)
    @service.pet = @pet
    @service.state = 'scheduled'

    if @service.save
      redirect_to services_path, notice: 'Service was successfully created!'
    else
      render :new, status: :unprocessable_entity
    end
  end

  # Do not implement the view yet
  def edit
  end

  def update
    @service.state = 'accepted' if @service.state == 'scheduled'

    if @service.update(params.permit(:data))
      redirect_to @service, notice: 'Service was successfully updated!'
    else
      render :new, status: :unprocessable_entity
    end
  end

  # def destroy
  #   @service.destroy
  #   redirect_to services_path, notice: 'Service was successfully destroyed.'
  # end

  private

  def set_pet
    @pet = Pet.find(params[:pet_id])
  end

  def set_service
    @service = Service.find(params[:id])
  end

  def set_services
    if current_user.petwalker
      @services = Service.where(user: current_user)
    else
      @services = Service.where(pet: Pet.where(user: current_user))
    end
  end

  def service_params
    params.require(:service).permit(:pet_id, :user_id, :schedule, :state, :price,
                                    :started_at, :finished_at, :rating, :review)
  end
end
