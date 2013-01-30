class ApplicationController < ActionController::Base
  protect_from_forgery

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
    @stop_times = StopTime.all.select { |st| @trip_ids.include? st.trip_id }
    @stop_ids = Array.new
    @stop_times.each { |st| @stop_ids << st.stop_id unless @stop_ids.include? st.stop_id }
    @stops_to_return = []
    Stop.all.each { |s| @stops_to_return << s if @stop_ids.include? s.stop_id.to_i }
    @stops_to_return

    #render json: @stops_to_return

    # From old code
    render :partial => "stops", :locals => { :stops => @stops_to_return }
  end

end
