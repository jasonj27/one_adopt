class ReservationsController < ApplicationController
  def testfav
    if not user_signed_in?
      redirect_to user_session_path
    end

    @favorites = current_user.favorites.includes({ animal: :user }, :animal)
    @sort_fav = {}
    @favorites.each do |fav|
      if @sort_fav.has_key?(fav.animal.user.name)
        @sort_fav[fav.animal.user.name]["animals"].push([fav.animal.name, fav.animal.id])
      else
        @sort_fav.store(fav.animal.user.name, { "id" => fav.animal.user.id, "animals" => [[fav.animal.name, fav.animal.id]] })
      end
    end
  end

  def index
    @reservations = current_user.receiver_reservations.includes(:sender, { reservation_pets: :animal })
  end

  def new
    @reservation = Reservation.new(sender_id: params["sender"], receiver_id: current_user.id)
  end

  def create
    @reservation = Reservation.new(reservation_params)
    p reservation_params
    if @reservation.save
      @favorites = current_user.favorites.includes({ animal: :user }, :animal)
      @favorites.each do |fav|
        if fav.animal.user.id == @reservation.sender_id
          ReservationPet.create(animal_id: fav.animal.id, reservation_id: @reservation.id)
        end
      end
    end
    redirect_to reservations_path
  end

  def cancel
    reservation = current_user.receiver_reservations.find(params[:id])
    reservation.cancel_reservation!
    redirect_to reservations_path
  end

  private

  def reservation_params
    params.require(:reservation).permit(:note, :date, :time, :sender_id).merge("datetime" => ("#{params["reservation"]["date"]} #{params["reservation"]["time"]}"), "receiver_id" => current_user.id).except(:date, :time)
  end
end
