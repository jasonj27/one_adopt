class Sender::ReservationsController < ApplicationController
  
  layout 'sender'

  def index
    @reservations = current_user.sender_reservations.includes(:receiver, {reservation_pets: :animal})
  end

  def cancel
    reservation = current_user.sender_reservations.find(params[:id])
    reservation.cancel_reservation!
    redirect_to sender_reservations_path
  end

  def confirm
    reservation = current_user.sender_reservations.find(params[:id])
    reservation.confirm_reservation!
    redirect_to sender_reservations_path
  end

  def cancel_adopt
    reservation = current_user.sender_reservations.find(params[:id])
    reservation.adopt_canceled!
    redirect_to sender_reservations_path
  end

  def adopt
    reservation = current_user.sender_reservations.find(params[:id])
    if reservation.adopt!
      res = current_user.sender_reservations.find(params[:id])
      res.reservation_pets.each do |pet|
        pet.animal.update(adopt_status: '已領養', user_id: params['receiver'])
        User.find(params['receiver']).favorites.where(animal_id: pet.animal.id).destroy_all
      end
    end
    redirect_to sender_reservations_path
  end

end
