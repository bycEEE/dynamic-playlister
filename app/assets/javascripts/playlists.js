$(function() {
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
    if (player.getPlayerState() == 0) {
      player.loadVideoById(videoIDs[currentVideoId]);
    }
    if (player.getPlayerState() == 1) {
      currentVideoId++;
      player.loadVideoById(videoIDs[currentVideoId]);
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
      debugger
      $.post(location.href + "/songs", $("#add-song-form").serialize(), function(data) {
        videoIDs.push(data.uid);  
      });
      $(".request.rowBox").last().append("<div>New song added, refresh to view</div>") // append song here....... 
  });

  $("#chat_send").click(function(event) {
      event.preventDefault();
      debugger
      // $.post("/playlist//chat_messages", $("form").serialize(), function(data) { 
      $.post(location.href + "/chat_messages", $("#chat-message-form").serialize(), function(data) {  
      });
      $("#new_chat_message")[0].reset();
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