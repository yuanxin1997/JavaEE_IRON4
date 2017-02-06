/**
 * Created by User on 1/29/2017.
 */
window.onload = function() {

alert('cuck');

    // Normalize the various vendor prefixed versions of getUserMedia.
    navigator.getUserMedia = (navigator.getUserMedia ||
    navigator.webkitGetUserMedia ||
    navigator.mozGetUserMedia ||
    navigator.msGetUserMedia);


//     // Get audio/video stream
//     navigator.getUserMedia({audio: true, video: true}, function(stream)
//     {
//
//
//         // Set your video displays
//         //id to your videocam
//         $("#camera-stream").prop('src', URL.createObjectURL(stream));
//
//         window.localStream = stream;
//
//
// //                step2();
//         //in case of error
//     }, function(err){ console.log('The following error occurred when trying to use getUserMedia: ' + err); });

    if (navigator.getUserMedia) {alert('cuck111');
        // Request the camera.
        navigator.getUserMedia(
            // Constraints
            {
                video: true
            },

            // Success Callback
            function(localMediaStream) {
                // Get a reference to the video element on the page.
                var vid = document.getElementById('camera-stream');
                alert('cuck123');
                // Create an object URL for the video stream and use this
                // to set the video source.
                vid.src = window.URL.createObjectURL(localMediaStream)
            },

            // Error Callback
            function(err) {alert('cuck321');
                // Log the error to the console.
                console.log('The following error occurred when trying to use getUserMedia: ' + err);
            }
        );

    } else {
        alert('Sorry, your browser does not support getUserMedia');
    }


}