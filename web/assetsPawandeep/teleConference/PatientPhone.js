/**
 * Created by PawandeepSingh on 6/2/17.
 */

phone.receive(function(session)
{
    console.log('received')
    //alert('recieved here');
    AlertConference();

    // when call ended
    session.ended(function(session){

        // alert('Bye');
    });

});
