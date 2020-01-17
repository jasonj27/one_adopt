class ReservationsController < ApplicationController
  def index
    @reservations = current_user.receiver_reservations.includes(:sender, { reservation_pets: :animal }).order(:datetime)

    if @reservations.count == @reservations.where(status: "canceled").count
      redirect_to root_path, notice: "趕快去收藏寵物，進行預約吧！"
    end
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
