$(function() {
  var idRegex = /http:\/\/localhost:3000\/playlists\/(\d+)/;
  var match = idRegex.exec(location.href);
  songsArray = [];

  $("#search_term_or_url").autocomplete({
    minLength: 3,
    source: "/search_suggestions",
    select: function(event, ui) {
    $('#search_term_or_url').val(ui.item.value);
    }
  });

  $( "#skip-song" ).on( "click", function(event) {
    event.preventDefault();
    event.stopPropagation();
    if (player.getPlayerState() == 0) { // ended
      $('#songs-list').find("#" + whatIsPlaying).parent().closest('div').fadeTo(500,0.2);
      songsPlayed.push(whatIsPlaying);
      player.loadVideoById(videoIDs[currentVideoIndex]);
    }
    if (player.getPlayerState() == 1) { // playing
      $('#songs-list').find("#" + whatIsPlaying).parent().closest('div').fadeTo(500,0.2);
      songsPlayed.push(whatIsPlaying);
      currentVideoIndex++;
      player.loadVideoById(videoIDs[currentVideoIndex]);
    }
    if (player.getPlayerState() == 2) { // paused
      $('#songs-list').find("#" + videoIDs[currentVideoIndex]).parent().closest('div').fadeTo(500,0.2);
      songsPlayed.push(whatIsPlaying);
      currentVideoIndex++;
      player.loadVideoById(videoIDs[currentVideoIndex]);
    }
  });

  $(".upvote").click(function(event) {
    var requestId = $(this).attr("id");
    requestId = requestId.replace("upvote-", "");
    $.post("/votes/upvote", {"request_id": requestId}, function(data) {  
      });
  });

  $(".downvote").click(function(event) {
    var requestId = $(this).attr("id");
    requestId = requestId.replace("downvote-", "");
    $.post("/votes/downvote", {"request_id": requestId}, function(data) {  
      });
  });

  $(".delete").click(function(event) {
    var requestId = $(this).attr("id");
    requestId = requestId.replace("delete-", "");
    $.post("/requests/destroy", {"request_id": requestId}, {_method:'delete'}, null, "script");
  });

  $("#intelligent-add-song").click(function(event) {
      event.preventDefault();
      $.post(location.href + "/songs", $("#add-song-form").serialize(), function(data) {
      });
  });

  $("#chat_send").click(function(event) {
      event.preventDefault();
      // $.post("/playlist//chat_messages", $("form").serialize(), function(data) { 
      $.post(location.href + "/chat_messages", $("#chat-message-form").serialize(), function(data) {  
      });
      $("#chat_message_content").val("");
  });

  // need to make now playing div that is not sortable
  // logic relies on songs-list song-uid to exist. cannot delete elements
  $("#songs-list").sortable({
      // items: 'div:not(:first)',
      connectWith: ".connectedSortable",
      stop: function(event, ui) {
        videoIDs.length = 0;
        songsArray.length = 0;
        // $("#songs-list").find("#" + player.getVideoData()['video_id']).prepend("<p>PLAYLIST IS HERE</p>")
        $("#songs-list").find(".song-uid").each(function(){ 
          videoIDs.push(this.id);
          var songsHash = {};
          songsHash["uid"] = this.id;
          songsHash["id"] = this.parentElement.id.split("_")[1];
          songsHash["url_id"] = $(this).attr("href").split("/")[2];
          songsHash["title"] = this.text;
          songsHash["votes"] = $("#vote-count-" + songsHash["id"]).text();
          if(this.parentElement.style.cssText.match(/^opacity/)) {
            songsHash["played"] = 1;
          } else {
            songsHash["played"] = 0;
          }
          songsArray.push(songsHash);
        });
        videoIDs = $(videoIDs).not(songsPlayed).get();
        currentVideoIndex = videoIDs.indexOf(whatIsPlaying);
        $.post("/requests/arrange", {"video_ids": videoIDs, "playlist_id": match[1], "songs_array": songsArray }, function(data) {  
        });
      }
  });

  $(".song-uid").click(function(event) {
    event.preventDefault();
    player.loadVideoById(videoIDs[$.inArray(this.id, videoIDs)]);
    currentVideoIndex = $.inArray(this.id, videoIDs)
  });

});

// to write own autocomplete
// event listener on that input
// type = keydown or keyup
// send a get request to youtube api
// when that get request returns, function (data) {
//   $("some element").append("<div> jsondata </div>")

// }
// ul -> li

// add event listener the ul
// $("ul").click(function() {
//   add the clicked element into the input box, set the data id of that element to be the videoid
//   run whatever 
// })