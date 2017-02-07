/**
 * Created by PawandeepSingh on 23/1/17.
 */



//when phone is ready,can start calls
myPhone.ready(function ()
{
    //phone number can be string also
    //when startCall button is clicked
    // $('#startCall').click(function ()
    // {
    //     var confirmCall = confirm("Ready to begin Call to patient ?");
    //     if(confirmCall == true)
    //     {
    //         dialnumber();
    //     }
    //     else // show alert
    //         alert('Call patient lah');
    //
    // });

})

var CallSession;
var Message = null;

var consultationNotes;//REPORT TO SEND

//When call comes in or is being connected
myPhone.receive(function(session)
{

    CallSession = session;

    //to display patient's live video
    session.connected(function (session)
    {
        if(Message == 'end')
        {
            session.hangup();
        }else if(Message == 'start call' || Message == null )
        {


            $('#doctorReport').keyup(function (event)//SEND CHARACTER BY CHARACTER
            {
                consultationNotes = $(this).val()
                myPhone.send({notes: consultationNotes});
            })

            //display patient video
            var remotevideo = document.getElementById('remote');
            var sessionvid = session.video; //get remote video
            remotevideo.src = sessionvid.src;


            //gagaga
            console.log('Display remote video');
            console.log('please work')

            $('#myModal').modal('hide');
        }



    });
    //when session or call ended
    session.ended(function () {
        //action when call end
    })

});

//receive message
myPhone.message(function (session,message)
{


    Message = message.text;
    console.log(session.number + " " + message.text);
})

//when page is loaded
$(document).ready(function ()
{
    //to check connectivity of network
    myPhone.connect(function ()
    {
        console.log('Network is live.');
    })


    $('#endCall').click(function ()
    {
        var endCall = confirm("Are sure you want to end call ? ");
        if(endCall == true)
        {

                CallSession.hangup() // is to end the call
            stopDuration();
            // $('#modal1').modal({backdrop: 'static', keyboard: false})


            //alert('oh yah');
        }

    })
})





