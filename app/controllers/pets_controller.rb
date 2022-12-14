class PetsController < ApplicationController
  before_action :set_pet, only: %i[show edit update destroy]

  def index
    @pets = Pet.all
  end

  def show
    @pets = Pet.all
  end

  def new
    @pet = Pet.new
  end

  def create
    @pet = Pet.new(pet_params)
    @pet.user = current_user

    if @pet.save
      redirect_to @pet, notice: 'Pet was successfully created!'
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
  end

  def update

    if @pet.update(pet_params)
      redirect_to @pet, notice: 'Pet was successfully updated!'
    else
      render :new, status: :unprocessable_entity
    end
  end

  def destroy
    @pet.destroy
    redirect_to pets_path, notice: 'Pet was successfully destroyed.'
  end

  private

  def set_pet
    @pet = Pet.find(params[:id])
  end

  def pet_params
    params.require(:pet).permit(:name, :breed, :important_note, :photo)
  end
end
