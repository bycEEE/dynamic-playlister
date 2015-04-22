// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or any plugin's vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/sstephenson/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery-ui
//= require jquery_ujs
//= require bootstrap
//= require_tree ../../../vendor/assets/javascripts/.
//= require playlists
//= require_tree .

$(function() {
  // debugger
  var faye = new Faye.Client('http://localhost:9292/faye');
  var idRegex = /http:\/\/localhost:3000\/playlists\/(\d+)/
  var match = idRegex.exec(location.href)
  faye.subscribe("/chat_messages/" + match[1], function(data) {
  // $("#message_box").append("<li>" + data.content + "</li>")
  // debugger
  $("#message_box").append("<tr class=\"current_user_comment\"><td>" 
                                                  + data.user + ": " + data.content + 
                                                "</td></tr>")
  // eval(data)
  });
});