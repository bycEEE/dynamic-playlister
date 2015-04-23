$(function() {
   $("#search_term_or_url").autocomplete({
    minLength: 3,
    source: "/search_suggestions",
    // select: function (event, ui) {
    //   $('#search_term_or_url').val(ui.item.title);
    //   $('#song_uid').val(ui.item.id);
    //   return false;
    // }
      select: function(event, ui) {
      $('#search_term_or_url').val(ui.item.value);
    }
   });

  // $( "#add-song" ).on( "click", function(event) {
  //   event.preventDefault();
  //   // event.stopPropagation();
  //   var newSong = $( "#song_url" ).val();
  //   newSong = newSong.replace("https://youtu.be/", "");
  //   videoIDs.push(newSong);
  //   $(".request.rowBox").last().append("<div>New song added, refresh to view</div>") // append song here....... 
  //   // $.post("/playlists/1/songs", {"song" : {"url" : $("#song_url").val()}}, function(data) {
  //   //   // Implement Rails flash
  //   // })
  // });

  $( "#skip-song" ).on( "click", function(event) {
    event.preventDefault();
    event.stopPropagation();
    if (player.getPlayerState() == 0) {
      player.loadVideoById(videoIDs[currentVideoId]);
    }
    if (player.getPlayerState() == 1) {
      currentVideoId++;
      player.loadVideoById(videoIDs[currentVideoId]);
    }
  });

  $(".upvote").click(function(event) {
    var requestId = $(this).attr("id")
    requestId = requestId.replace("upvote-", "")
    $.post("/votes/upvote", {"request_id": requestId}, function(data) {  
      });
  });

  $(".downvote").click(function(event) {
    var requestId = $(this).attr("id")
    requestId = requestId.replace("downvote-", "")
    $.post("/votes/downvote", {"request_id": requestId}, function(data) {  
      });
  });

  $(".delete").click(function(event) {
    var requestId = $(this).attr("id")
    requestId = requestId.replace("delete-", "")
    $.post("/requests/destroy", {"request_id": requestId}, {_method:'delete'}, null, "script");
  });

  $(":submit").click(function(event) {
    if ($(this).attr('id') == "intelligent-add-song") {
      event.preventDefault();
      $.post(location.href + "/songs", $("form").serialize(), function(data) {
        videoIDs.push(data.uid)  
      })
      $(".request.rowBox").last().append("<div>New song added, refresh to view</div>") // append song here....... 
    } else if ($(this).attr('id') == "chat_send") {
      event.preventDefault();
      // $.post("/playlist//chat_messages", $("form").serialize(), function(data) { 
      $.post(location.href + "/chat_messages", $("form").serialize(), function(data) {  
      })
      $("#new_chat_message")[0].reset();
    }
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