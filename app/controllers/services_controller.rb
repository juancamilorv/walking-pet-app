class ServicesController < ApplicationController
  before_action :set_pet, only: %i[new create]
  before_action :set_petwalkers, only: :edit
  before_action :set_service, only: %i[edit update destroy]
  before_action :set_services, only: :index
  before_action :set_state, only: :update

  def index
    set_services
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

  def edit
  end

  def update
    if @service.state.nil?
      @service.state = 'scheduled'
      if @service.update(service_params)
        redirect_to services_path, notice: 'Service was successfully updated!'
      else
        render :new, status: :unprocessable_entity
      end
    else
      if @service.update(params.permit(:data))
        redirect_to services_path, notice: 'Service was successfully updated!'
      else
        render :new, status: :unprocessable_entity
      end
    end
  end

  def destroy
    @service.destroy
    redirect_to services_path, notice: 'Service was successfully destroyed!'
  end

  private

  def set_pet
    @pet = Pet.find(params[:pet_id])
  end

  def set_petwalkers
    set_service
    @petwalkers = User.where(petwalker: true).where.not(id: @service.user)
  end

  def set_state
    @service.state = params['state']
    @service.started_at = Time.now if @service.state == 'in process'
    @service.finished_at = Time.now if @service.state == 'completed'

    if @service.state == 'completed'
      @service.price = (((@service.finished_at - @service.started_at) / 3600) * @service.user.price_per_hour).round
    end
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
