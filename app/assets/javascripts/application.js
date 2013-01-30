// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or vendor/assets/javascripts of plugins, if any, can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// the compiled file.
//
// WARNING: THE FIRST BLANK LINE MARKS THE END OF WHAT'S TO BE PROCESSED, ANY BLANK LINE SHOULD
// GO AFTER THE REQUIRES BELOW.
//
//= require jquery
//= require jquery_ujs
//= require_tree .


jQuery(function($)
{
  $("#widget_route").change(function()
    {
        var route = $('select#widget_route :selected').val();
        console.log(route);
        if(route == "") {
          $("#widget_stop select").empty()
        }
        else {
          jQuery.get(
            '/get_stops/' + route,
            function(data){ 
              $("#stops").html(data); 
              $("#widget_stop").change(function()
              {
                  var stop = $('select#widget_stop :selected').val();
                  console.log(stop);
                  if(stops == "") {
                    $("#bus_times").empty()
                  }
                  else {
                    jQuery.get(
                      '/get_times/' + stop,
                      function(data){ 
                        $("#bus_times").html(data);
                        console.log("Data: " + data);
                      },
                      "html"
                    );
                    console.log("times placed?");
                  }
                return false;
              }
              );
            },
            "html"
          );
        }
      return false;
    }
  );
})









$.fn.subSelectWithAjax = function() {
  var that = this;
  this.change(function() {
    $.post(that.attr('rel'), {id: that.val()}, null, "script");
  });
}

