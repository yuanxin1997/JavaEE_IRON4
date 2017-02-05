/// <reference path="patientScript.js" />
app.factory('currentDateService', function() {
    return {
        getCurrentDate: function(){
            var date = new Date();
            date = date.getFullYear() + '-' + ('0' + (date.getMonth() + 1)).slice(-2) + '-' + ('0' + date.getDate()).slice(-2);;
            return date;
        }
    };
})
.factory('yesterdayDateService', function() {
    return {
        getYesterdayDate: function(){
            var date = new Date();
            date.setDate(date.getDate() - 1);
            date = date.getFullYear() + '-' + ('0' + (date.getMonth() + 1)).slice(-2) + '-' + ('0' + date.getDate()).slice(-2);;
            return date;
        }
    };
});