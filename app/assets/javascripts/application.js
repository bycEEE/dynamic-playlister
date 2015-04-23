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

  // add chat message
  var faye = new Faye.Client('http://localhost:9292/faye');
  var idRegex = /http:\/\/localhost:3000\/playlists\/(\d+)/;
  var match = idRegex.exec(location.href);
    faye.subscribe("/chat_messages/" + match[1], function(data) {
    // $("#message_box").append("<li>" + data.content + "</li>")
    // debugger
    $("#message-table").append("<tr class=\"current_user_comment\"><td>" 
                                  + data.user + ": " + data.content + 
                              "</td></tr>");
        // eval(data)
    });

  // add songs
  faye.subscribe("/playlists/" + match[1] + "/add", function(data) {
    $(".request.rowBox").last().append("<div class=\"voting\" id=\"voting-" + data.request_id + "\">" 
                                  + "<h6>" + data.vote_count + "</h6>"
                                  + "<a class=\"upvote\" id=\"upvote-" + data.request_id + "\"> upvote </a>"
                                  + "<a class=\"downvote\" id=\"downvote-" + data.request_id + "\">downvote</a>"
                                  + "<a class=\"delete\" id = \"delete-" + data.request_id + "\">delete</a>"
                                  + "<a href=\"/songs/" + data.song_id + "\">" + data.name + "</a>"
                              + "</div>");
    // <%= div_for request, class: "rowBox" do %>
    //     <div class="voting" id="voting-<%= request.id%>">
    //       <h6 id="vote-count-<%= request.id%>"><%= request.vote_count %></h6>
    //       <% if !@playlist.locked %>
    //         <a class="upvote" id="upvote-<%= request.id%>"> upvote </a>
    //         <a class="downvote" id="downvote-<%= request.id%>">downvote</a>
    //         <a class="delete" id = "delete-<%=  request.id %>">delete</a>  
    //       <% end %>
    //     </div>
    //     <%= link_to "#{request.song.name}", request.song %>
    //   <% end %>
  });

  // change votes
  faye.subscribe("/playlists/" + match[1] +"/votes", function(data) {
    $("#vote-count-"+data.request_id).text(data.votes); 
    
  });

  // delete song
  faye.subscribe("/playlists/" + match[1] +"/delete", function(data) {
    $('#request_'+ data.request_id).remove();
    var songToDelete = videoIDs.indexOf(data.request_song_uid);
    videoIDs.splice(songToDelete, 1);
  });
});