class Sender::AnimalsController < ApplicationController

  layout 'sender'

  def index
    @animals = current_user.animals
  end

  def new
    @animal = current_user.animals.new
  end

  def create
    @animal = current_user.animals.build(animal_params)
    if @animal.save
      redirect_to sender_animals_path
    else
      render :new
    end
  end

  def edit
    @animal = Animal.find(params[:id])
  end

  def update
    @animal = Animal.find(params[:id])
    if @animal.update(animal_params)
      redirect_to sender_animals_path
    else
      render :new
    end
  end

  def destroy
    @animal = Animal.find(params[:id])
    @animal.destroy
    redirect_to sender_animals_path
  end

  def destroy_image
    @animal = Animal.find(params[:id])
    @animal.images.find(params[:image_id]).purge
    render :edit
  end

  private

  def animal_params
    params.require(:animal).permit(:name, :animal_kind, :animal_sex, :animal_age, :animal_sterilization ,:adopt_status, images: [],)
  end

end
