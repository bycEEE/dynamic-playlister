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
    videoIDs.push(data.uid);
    $("#songs-list").last().append("<div class=\"request rowBox ui-sortable-handle\" id=\"request_" + data.request_id + "\">"
                                  + "<div class=\"voting\" id=\"voting-" + data.request_id + "\">" 
                                  + "<h6 id=\"vote-count-" + data.request_id + "\">" + data.vote_count + "</h6>"
                                  + "<a class=\"upvote\" id=\"upvote-" + data.request_id + "\"> upvote </a>"
                                  + "<a class=\"downvote\" id=\"downvote-" + data.request_id + "\">downvote</a>"
                                  + "<a class=\"delete\" id = \"delete-" + data.request_id + "\">delete</a>"
                                  + "</div>"
                                  + "<a id="+data.uid+" class=\"song-uid\" href=\"/songs/" + data.song_id + "\">" + data.name + "</a>"
                                  + "<div>"
                                  );
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

  // reorder songs
  faye.subscribe("/playlists/" + match[1] +"/arrange", function(data) {
    videoIDs = data.video_ids;
    // $("#songs-list").html("");
    var string = "";
    // songsArray.forEach(function(hash) {
    //   string += "<div class=\"request rowBox\" id=\"request" + hash.id">"
    //                 +  "<div class=\"voting\" id=\"voting-" + hash.id">"
    //                 +   "<h6 id=\"vote-count-" + hash.id">1</h6>"
    //                 +   "<a class=\"upvote\" id=\"upvote-" + hash.id">upvote</a>"
    //                 +       "<a class=\"downvote\" id=\"downvote-" + hash.id">downvote</a>"
    //                 +       "<a class=\"delete\" id=\"delete-" + hash.id">delete</a>"
    //                 +    "</div>"
    //                 +    "<a id="+hash.uid+" class=\"song-uid\" href=\"/songs/" + hash.url_id">hash.title</a>"
    //                 +   "</div>";
    // });
    $.each(data.songs_array, function(index, hash) {
      if(hash.played == 1) {
        string += "<div class=\"request rowBox ui-sortable-handle\" id=\"request_" + hash.id + "\" style=\"opacity: 0.2;\">"
                                    + "<div class=\"voting\" id=\"voting-" + hash.id + "\">" 
                                    + "<h6 id=\"vote-count-" + hash.id + "\">" + hash.votes + "</h6>"
                                    + "<a class=\"upvote\" id=\"upvote-" + hash.id + "\"> upvote </a>"
                                    + "<a class=\"downvote\" id=\"downvote-" + hash.id + "\">downvote</a>"
                                    + "<a class=\"delete\" id = \"delete-" + hash.id + "\">delete</a>" // Fix delete being available for non-hosts
                                    + "</div>"
                                    + "<a id="+hash.uid+" class=\"song-uid\" href=\"/songs/" + hash.url_id + "\">" + hash.title + "</a>"
                                    + "</div>";
      } else {
        string += "<div class=\"request rowBox ui-sortable-handle\" id=\"request_" + hash.id + "\">"
                            + "<div class=\"voting\" id=\"voting-" + hash.id + "\">" 
                            + "<h6 id=\"vote-count-" + hash.id + "\">" + hash.votes + "</h6>"
                            + "<a class=\"upvote\" id=\"upvote-" + hash.id + "\"> upvote </a>"
                            + "<a class=\"downvote\" id=\"downvote-" + hash.id + "\">downvote</a>"
                            + "<a class=\"delete\" id = \"delete-" + hash.id + "\"> delete</a>" // Fix delete being available for non-hosts
                            + "</div>"
                            + "<a id="+hash.uid+" class=\"song-uid\" href=\"/songs/" + hash.url_id + "\">" + hash.title + "</a>"
                            + "</div>";
      };
    });
    $("#songs-list").html(string);
  });
});