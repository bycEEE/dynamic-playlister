$(function() {
  // add chat message
  var faye = new Faye.Client('http://localhost:9292/faye');
  var idRegex = /http:\/\/localhost:3000\/playlists\/(\d+)/;
  var match = idRegex.exec(location.href);
    faye.subscribe("/chat_messages/" + match[1], function(data) {
    $("#message-table").append("<tr class=\"current_user_comment\"><td>" 
                                  + data.user + ": " + data.content + 
                              "</td></tr>");
    });


  // add songs
  faye.subscribe("/playlists/" + match[1] + "/add", function(data) {
    videoIDs.push(data.uid);
   var string    = "<div class=\"request row ui-sortable-handle\" id=\"request_" + data.request_id + "\">"
                      + "<div class=\"col-md-1 col-xs-1 voting\" id=\"voting-" + data.request_id + "\">"
                      + "<a class=\"upvote\" id=\"upvote-" + data.request_id + "\">"
                      + "<span class=\"glyphicon glyphicon-chevron-up\"></span>"
                      + "</a>"
                      + "<h6 id=\"vote-count-" + data.request_id + "\">" + data.vote_count + "</h6>"
                      + "<a class=\"downvote\" id=\"downvote-" + data.request_id + "\">"
                      + "<span class=\"glyphicon glyphicon-chevron-down\"></span>"
                      + "</a>"
                      + "</div>"

                      + "<div class=\"col-md-2 col-xs-3 song-thumbnail\">"
                      + "<img height=\"60\" width=\"80\" class=\"youtube_thumbnail\" src=\"https://img.youtube.com/vi/" + data.uid + "/default.jpg\" alt=\"Default\" />"
                      + "</div>"

                      + "<div class=\"col-md-8 col-xs-14 song-info\">"
                      + "<p>"
                      + "<a id="+ data.uid +" class=\"song-uid\" href=\"/songs/" + data.song_id + "\">"+data.name+"</a><br>"
                      + "Requested by: "+data.request_by+""
                      + "</p>"
                      + "</div>"

                       if(current_user_is_host == true) {
                        string += "<a class=\"delete\" id=\"delete-" + data.request_id + "\">"
                        + "<span class=\"glyphicon glyphicon-remove\"></span>"
                        + "</a>"
                      };
                      string += "</div>";

    $("#songs-list").append(string);
    songActions();
  });

  // change votes
  faye.subscribe("/playlists/" + match[1] +"/votes", function(data) {
    $("#vote-count-"+data.request_id).text(data.votes); 
    
  });

  // delete song
  faye.subscribe("/playlists/" + match[1] +"/delete", function(data) {
    $('#request_'+ data.request_id).fadeOut(500, function() { $(this).remove(); });
    var songToDelete = videoIDs.indexOf(data.request_song_uid);
    videoIDs.splice(songToDelete, 1);
  });

  // reorder songs
  faye.subscribe("/playlists/" + match[1] +"/arrange", function(data) {
    videoIDs = data.video_ids;
    var string = "";
    $.each(data.songs_array, function(index, hash) {
      if(hash.played == 1) {
        // string += "<div class=\"request row ui-sortable-handle\" id=\"request_" + hash.id + "\" style=\"opacity: 0.2;\">"
        //                             + "<div class=\"voting\" id=\"voting-" + hash.id + "\">" 
        //                             + "<h6 id=\"vote-count-" + hash.id + "\">" + hash.votes + "</h6>"
        //                             + "<a class=\"upvote\" id=\"upvote-" + hash.id + "\"> upvote </a>"
        //                             + "<a class=\"downvote\" id=\"downvote-" + hash.id + "\">downvote</a>"

        //                             if(current_user_is_host == true) {
        //                               string += "<a class=\"delete\" id = \"delete-" + hash.id + "\"> delete</a>"
        //                             };

        //                             string += "</div>"
        //                             + "<a id="+hash.uid+" class=\"song-uid\" href=\"/songs/" + hash.url_id + "\">" + hash.title + "</a>"
        //                             + "</div>";

       string += "<div class=\"request row ui-sortable-handle\" id=\"request_" + hash.id + "\" style=\"opacity: 0.2;\">"
                    + "<div class=\"col-md-1 col-xs-1 voting\" id=\"voting-" + hash.id + "\">"
                    + "<a class=\"upvote\" id=\"upvote-" + hash.id + "\">"
                    + "<span class=\"glyphicon glyphicon-chevron-up\"></span>"
                    + "</a>"
                    + "<h6 id=\"vote-count-" + hash.id + "\">" + hash.votes + "</h6>"
                    + "<a class=\"downvote\" id=\"downvote-" + hash.id + "\">"
                    + "<span class=\"glyphicon glyphicon-chevron-down\"></span>"
                    + "</a>"
                    + "</div>"

                    + "<div class=\"col-md-2 col-xs-3 song-thumbnail\">"
                    + "<img height=\"60\" width=\"80\" class=\"youtube_thumbnail\" src=\"https://img.youtube.com/vi/" + hash.uid + "/default.jpg\" alt=\"Default\" />"
                    + "</div>"

                    + "<div class=\"col-md-8 col-xs-14 song-info\">"
                    + "<p>"
                    + "<a id="+ hash.url_id +" class=\"song-uid\" href=\"/songs/" + hash.url_id + "\">"+hash.title+"</a><br>"
                    + "Requested by: "+hash.request_by+""
                    + "</p>"
                    + "</div>"

                    if(current_user_is_host == true) {
                      string += "<a class=\"delete\" id=\"delete-" + hash.id + "\">"
                      + "<span class=\"glyphicon glyphicon-remove\"></span>"
                      + "</a>"
                    };
                    string += "</div>";

      } else {
       string += "<div class=\"request row ui-sortable-handle\" id=\"request_" + hash.id + "\">"
                    + "<div class=\"col-md-1 col-xs-1 voting\" id=\"voting-" + hash.id + "\">"
                    + "<a class=\"upvote\" id=\"upvote-" + hash.id + "\">"
                    + "<span class=\"glyphicon glyphicon-chevron-up\"></span>"
                    + "</a>"
                    + "<h6 id=\"vote-count-" + hash.id + "\">" + hash.votes + "</h6>"
                    + "<a class=\"downvote\" id=\"downvote-" + hash.id + "\">"
                    + "<span class=\"glyphicon glyphicon-chevron-down\"></span>"
                    + "</a>"
                    + "</div>"

                    + "<div class=\"col-md-2 col-xs-3 song-thumbnail\">"
                    + "<img height=\"60\" width=\"80\" class=\"youtube_thumbnail\" src=\"https://img.youtube.com/vi/" + hash.uid + "/default.jpg\" alt=\"Default\" />"
                    + "</div>"

                    + "<div class=\"col-md-8 col-xs-14 song-info\">"
                    + "<p>"
                    + "<a id="+ hash.uid +" class=\"song-uid\" href=\"/songs/" + hash.url_id + "\">"+hash.title+"</a><br>"
                    + "Requested by: "+hash.request_by+""
                    + "</p>"
                    + "</div>"

                    if(current_user_is_host == true) {
                      string += "<a class=\"delete\" id=\"delete-" + hash.id + "\">"
                      + "<span class=\"glyphicon glyphicon-remove\"></span>"
                      + "</a>"
                    };
                    string += "</div>";
                  };
    });
    $("#songs-list").html(string);
    songActions();
    videoIDs = data.video_ids;
    currentVideoIndex = data.current_video_index;
  });
});