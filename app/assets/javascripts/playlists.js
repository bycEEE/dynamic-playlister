$( document ).ready(function() {
  console.log("playlist.js loaded");
  $( "#add-song" ).on( "click", function(event) {
    event.preventDefault();
    event.stopPropagation();
    var newSong = $( "#song_url" ).val();
    newSong = newSong.replace("https://youtu.be/", "");
    videoIDs.push(newSong);
  });
});