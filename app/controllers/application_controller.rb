require 'pry'

class ApplicationController < ActionController::Base
  protect_from_forgery

  @@stop_times_soon = ""

  def widget
    @all_routes = Route.all
  end

  def get_stops
    #@selected_route = "E1"
    @selected_route = params[:route_id]

    #@selected_stops = Stop.find_all_by_route_id(params[:route_id]) #.sort_by { |a| a['code'] }

    @trips = Trip.find_all_by_route_id(@selected_route)
    @trip_ids = []
    @trips.each { |t| @trip_ids << t.trip_id if t.route_id == @selected_route }

    @@stop_times_soon = StopTime.where('arrival_time > ? and arrival_time < ?', ApplicationHelper.get_stringified_now, ApplicationHelper.get_stringified_soon)

    @@stop_times_soon = @@stop_times_soon.select { |st| @trip_ids.include? st.trip_id }

    @stop_ids = Array.new
    @@stop_times_soon.each { |st| @stop_ids << st.stop_id unless @stop_ids.include? st.stop_id }
    @stops_to_return = []
    Stop.all.each { |s| @stops_to_return << s if @stop_ids.include? s.stop_id.to_i }
    @stops_to_return

    #binding.pry

    # From old code
    render :partial => "stops", :locals => { :stops => @stops_to_return }
  end

  def get_times
    @selected_stop = params[:stop_id].to_i
    @stop_times_to_return = @@stop_times_soon.select { |st| st.stop_id == @selected_stop }
    #binding.pry
    render :partial => "stop_times", :locals => { :stop_times => @stop_times_to_return }
  end

end


