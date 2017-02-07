/**
 * Created by PawandeepSingh on 28/1/17.
 */

var now = moment(new Date()); //current date time
var currTime = now.format('hh:mm:ss a DD-MM-YYYY');

// keeps calling this function
function clock()//to display date and time
{
    now = moment(new Date()); //current date time
    currTime = now.format('hh:mm:ss a DD-MM-YYYY');

    $('#displaytime').text(currTime);

    // console.log(currTime);
    //setTimeout(clock,1000);
}




$(document).ready(function ()
{


//set interval for clock to run every second
    setInterval(function () {
        clock();
    },1000);


})




