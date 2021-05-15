class RecordsController < ApplicationController

  protect_from_forgery
  rescue_from ActiveRecord::RecordNotFound, with: :record_not_found

  def record_not_found(error)
    render json: { message: 'Record not found' }, status: :not_found
  end

  def index
    @players = Player.all
  end

  def create
    @player = Player.new(name: params[:player], score: params[:score], time_entry: params[:time_entry])
    if @player.save
      render json: { message: 'Player record added' }
    else
      render json: { message: 'Record cannot be added' }
    end
  end

  def test
    @name = params[:score]
    #@player = Player.new(name: "player4", score: 5, time: "2021/05/13-13:05")
    respond_to do |format|
      msg = { :response => @name }
      format.json  { render :json => msg } # don't do msg.to_json
    end
  end

  def read
    @player = Player.all
    msg = ""
    if params[:id].present?
      @player = @player.find(params[:id])
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
      if params[:summary]==true
        top = @player.maximum("score")
        low = @player.minimum("score")
        average = @player.average("score").to_i
        @player = @player.select("id", "score", "time_entry")
        msg = {"top" => top, "low" => low, "average" => average, "details" => @player}
      end
    end
    if msg.empty?
      if params[:current].present?
        @player = @player.select("id", "name", "score", "time_entry").page(params[:current]).per(5)
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
    @player = Player.find(params[:id])
    @player.destroy
    render json: { message: 'Player record deleted', status: :success }
  end

end
