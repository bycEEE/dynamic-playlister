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


  $( "#add-song" ).on( "click", function(event) {
    event.preventDefault();
    // event.stopPropagation();
    var newSong = $( "#song_url" ).val();
    newSong = newSong.replace("https://youtu.be/", "");
    videoIDs.push(newSong);
    // $.post("/playlists/1/songs", {"song" : {"url" : $("#song_url").val()}}, function(data) {
    //   // Implement Rails flash
    // })
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