class RecordsController < ApplicationController

  protect_from_forgery

  rescue_from ActiveRecord::RecordNotFound, with: :record_not_found

  def record_not_found(error)
    render json: { message: 'Record not found' }, status: :not_found
  end

  def index
    @players = PlayerRecord.all
  end

  def view
    @players = PlayerRecord.all
  end

  def create
    @player = PlayerRecord.new(name: params[:name], score: params[:score], time_entry: params[:time].to_s.to_datetime)

    if @player.save
      render json: { message: 'Player record added' }
    else
      render json: { message: 'Record cannot be added' }
    end
  end

  def read
    @player = PlayerRecord.all
    msg = ""
    if params[:id].present?
      @player = @player.where("id = ?", params[:id])
    else
      if params[:playerlist].present?
        @player = @player.where("lower(name) IN (?)", params[:playerlist].map(&:downcase))
      end
      if params[:start_date].present?
        @player = @player.where("time_entry >= :start_date", {start_date: params[:start_date].to_datetime})
      end
      if params[:end_date].present?
        @player = @player.where("time_entry <= :end_date", {end_date: params[:end_date].to_datetime})
      end
      if params[:summary].to_s=="true"
        top = @player.maximum("score")
        low = @player.minimum("score")
        average = @player.average("score").to_i
        @player = @player.select("id", "score", "time_entry")
        msg = {"top" => top, "low" => low, "average" => average, "details" => @player}
      end
    end
    if msg.empty?
      if params[:current].present?
        @player = @player.select("id", "name", "score", "time_entry").page(params[:current].to_i).per(5)
      else
        @player = @player.select("id", "name", "score", "time_entry")
      end
      msg = { :response => @player }
    end
    respond_to do |format|
      format.json  { render :json => msg} # don't do msg.to_json
    end
  end

  def delete
    @player = PlayerRecord.find(params[:id])
    @player.destroy
    render json: { message: 'Player record deleted', status: :success }
  end
  skip_before_action :verify_authenticity_token
end
