// $(function() {

//   var player, currentVideoIndex = 0;
//   var whatIsPlaying = 0;
//   var songsPlayed = [];

//   function onYouTubeIframeAPIReady() {
//       player = new YT.Player('player', {
//           height: '600',
//           width: '100%',
//           events: {
//               'onReady': onPlayerReady,
//               'onStateChange': onPlayerStateChange
//           }
//       });
//   }

//   function onPlayerReady(event) {
//       event.target.loadVideoById(videoIDs[currentVideoIndex]);
//   }

//   function onPlayerStateChange(event) {
//       if (event.data == YT.PlayerState.ENDED) {
//         $('#songs-list').find("#" + videoIDs[currentVideoIndex]).parent().closest('div').fadeTo(500,0.2);
//         currentVideoIndex++;
//         videoIDs.push(songsPlayed);
//           if (currentVideoIndex < videoIDs.length) {
//              player.loadVideoById(videoIDs[currentVideoIndex]);
//           }
//       }
//       if (event.data == YT.PlayerState.PLAYING) {
//         whatIsPlaying = player.getVideoData()['video_id']
//         document.getElementById('currently_playing').innerHTML = 'Currently playing: ' + player.getVideoData().title;
//       }
//   }
  
// });
