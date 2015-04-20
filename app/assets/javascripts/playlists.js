$( document ).ready(function() {
  console.log("playlist.js loaded");
  $( "#add-song" ).on( "click", function(event) {
    event.preventDefault();
    // event.stopPropagation();
    var newSong = $( "#song_url" ).val();
    newSong = newSong.replace("https://youtu.be/", "");
    videoIDs.push(newSong);
    $.post("/playlists/1/songs", {"song" : {"url" : $("#song_url").val()}}, function(data) {
      // Implement Rails flash
    })
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