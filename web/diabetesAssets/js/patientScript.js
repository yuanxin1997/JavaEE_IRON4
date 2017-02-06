/// <reference path="angular.min.js" />

 var app = angular.module('patientApp', ['nvd3',"ui.router","toastr","ngAnimate","ngDialog","angularMoment"])
     .run(function($rootScope) {
         $rootScope.patientUser = '';
         $rootScope.name = "";
         $rootScope.memoConnectionCount = 0;
         $rootScope.diabeteLogConnectionCount = 0;
         $rootScope.projectConnectionCount = 0;
         $rootScope.projectConnectionCount2 = 0;
     })
     .directive("mySrc", function() {
         return {
             link: function(scope, element, attrs) {
                 var img, loadImage;
                 img = null;

                 loadImage = function() {

                     element[0].src = "diabetesAssets/img/avatar_2x.png";

                     img = new Image();
                     img.src = attrs.mySrc;

                     img.onload = function() {
                         element[0].src = attrs.mySrc;
                     };
                 };

                 scope.$watch((function() {
                     return attrs.mySrc;
                 }), function(newVal, oldVal) {
                     if (oldVal !== newVal) {
                         loadImage();
                     }
                 });
             }
         };
     })
     .config(function ($stateProvider, $urlMatcherFactoryProvider, $urlRouterProvider) {
         $urlRouterProvider.otherwise("/dailyTrack")
         $urlMatcherFactoryProvider.caseInsensitive(true);
         $stateProvider
             .state("dailyTrack", {
                 url: "/dailyTrack",
                 templateUrl: "diabetesAssets/Templates/dailyTrack.jsp",
                 controller: "dailyTrackController",
                 controllerAs: "dailyTrackCtrl"

             })
             .state("memoSchedule", {
                 url : "/memoSchedule",
                 templateUrl: "diabetesAssets/Templates/memoSchedule.jsp",
                 controller: "memoScheduleController",
                 controllerAs: "memoScheduleCtrl"
             })
             .state("statistic", {
                 url : "/statistic",
                 templateUrl: "diabetesAssets/Templates/statistic.jsp",
                 controller: "statisticController",
                 controllerAs: "statisticCtrl"
             })
     })
     .controller('myPatientController', function($scope, $http, $log, $rootScope, $timeout, ngDialog) {

         $http({
             method : 'GET',
             url: '/diabetes/patient/'+ $rootScope.patientUser})
             .then(function(response) {
                 $scope.patientDetails = response.data;
                 $rootScope.name = (response.data.lastName + " " +response.data.firstName);
                 $log.info(response);
             }, function (reason) {
                 $scope.error = reason.data;
                 $log.info(reason);
             });
         $http({
             method : 'GET',
             url: '/diabetes/diabetelog/averageGlucose/'+ $rootScope.patientUser})
             .then(function(response) {
                 $scope.avgGlucose = response.data;
                 $log.info(response);
             }, function (reason) {
                 $scope.error = reason.data;
                 $log.info(reason);
             });
         $scope.arrayBufferToBase64 = function( buffer ) {
             var binary = '';
             var bytes = new Uint8Array( buffer );
             var len = bytes.byteLength;
             for (var i = 0; i < len; i++) {
                 binary += String.fromCharCode( bytes[ i ] );
             }
             return window.btoa( binary );
         };

         $scope.openProfile = function () {
             $scope.patientDetailsCopy = {};

             $scope.arrayBufferToBase64Modal = function( buffer ) {
                 var binary = '';
                 var bytes = new Uint8Array( buffer );
                 var len = bytes.byteLength;
                 for (var i = 0; i < len; i++) {
                     binary += String.fromCharCode( bytes[ i ] );
                 }
                 return window.btoa( binary );
             };

             $timeout(function() {
                 angular.copy($scope.patientDetails, $scope.patientDetailsCopy);
             }, 50);

             ngDialog.open({
                 template: 'profileTemplate',
                 className: 'ngdialog-theme-default',
                 scope: $scope,
                 width: 560,
                 showClose: false,
                 closeByEscape: false,
                 closeByNavigation: false,
                 closeByDocument: false

             })
         };



     })
     .controller("dailyTrackController", function ($http,$scope,$log,currentDateService,toastr,$rootScope,$timeout) {
         var vm = this;

         var conn ;
         if($rootScope.diabeteLogConnectionCount < 1){
             ++$rootScope.diabeteLogConnectionCount;
             conn = new WebSocket("ws://" + window.location.host +"/diabeteLog/" + $rootScope.patientUser);
             conn.onopen = function () {
                 console.log("connection opened");
             };

             conn.onmessage = function (e) {
                 $rootScope.$apply(function() {
                     vm.logDetails.push(JSON.parse(e.data));
                 });
                 console.log("messaging");
             };

             conn.onclose = function () {
                 console.log("connection closed");
             };

             conn.onerror = function (error) {
                 console.log('Error ' + error);
             };

             $scope.$on('$stateChangeStart', function (event, next) {
                 $rootScope.diabeteLogConnectionCount=0;
                 conn.close();
             });
         }


         var conn2 ;
         if($rootScope.projectConnectionCount < 1){
             ++$rootScope.projectConnectionCount;
             conn2 = new WebSocket("ws://" + window.location.host +"/project/" + $rootScope.patientUser);
             conn2.onopen = function () {
                 console.log("connection opened");
             };

             conn2.onmessage = function (e) {
                 console.log("messaging");
             };

             conn2.onclose = function () {
                 console.log("connection closed");
             };

             conn2.onerror = function (error) {
                 console.log('Error ' + error);
             };

             $scope.$on('$stateChangeStart', function (event, next) {
                 $rootScope.projectConnectionCount=0;
                 conn2.close();
             });
         }


             $http({
                 url:'/diabetes/diabetelog/'+ $rootScope.patientUser + '/' + currentDateService.getCurrentDate(),
                 method: 'get'
             }).then(function (response) {
                 vm.logDetails = response.data;
                 var da = logDetails.length.toString();
                 vm.check = da;
                 $log.info(response)
             }, function(reason) {
                 vm.error = reason.data;
                 $log.info(reason);
             });


         vm.switchHelper = function(value) {
             if (value !== 0)
                 return 1;
             if (value == 0)
                 return 0;
         };


         vm.tv = {};

         vm.tv.trackTime = '';
         vm.tv.glucoseLevel = '';
         vm.tv.notes = '';

         vm.up= {};



         vm.addTrackingValue = function() {
             vm.tv.trackTime = $('#alarm').val();

             if(!vm.tv.notes || !vm.tv.trackTime || !vm.tv.glucoseLevel){  // check for Empty Value

                 toastr.error('Please fill in all the fields');
                 validInput = false;
             }else {   // exceed time slot
                 var beforePreviousTrackingTime = false;
                 angular.forEach(vm.logDetails, function(value, key){
                     var now = new Date();
                     var currentTT = (now.getMonth()+1) + "/" + now.getDate() + "/" + now.getFullYear() + " " + vm.tv.trackTime;
                     var previousTT = (now.getMonth()+1) + "/" + now.getDate() + "/" + now.getFullYear() + " " + value.trackTime;
                     var cValue = new Date(currentTT);
                     var pValue = new Date(previousTT);

                     if(!beforePreviousTrackingTime)
                     {
                         if(pValue >= cValue) {
                             beforePreviousTrackingTime=true;
                         }
                         else{
                             beforePreviousTrackingTime=false;
                         }
                     }
                 });

                 if(beforePreviousTrackingTime){
                     toastr.error('Time selected is before or equals to previous Track Time');
                 }else{
                     vm.tv.trackDate = currentDateService.getCurrentDate();
                     vm.tv.projectId = $rootScope.patientUser;


                     conn.send(JSON.stringify(vm.tv));
                     toastr.success('Value added');
                     // $http({
                     //     url:'/diabetes/diabetelog/addValue',
                     //     method: 'post',
                     //     data: vm.tv
                     // }).then(function (response) {
                     //     vm.logDetails.push(response.data);
                     //     $log.info(response)
                     //     toastr.success('Value added');
                     //
                     // }, function(reason) {
                     //     vm.error = reason.data;
                     //     $log.info(reason);
                     //     toastr.error('Error');
                     // });

                     if( vm.tv.glucoseLevel > 180 ){
                         vm.up.level = "high";
                     }else if( vm.tv.glucoseLevel > 115 && vm.tv.glucoseLevel <= 180 ){
                         vm.up.level = "borderline";
                     }
                     else if(vm.tv.glucoseLevel >= 50 && vm.tv.glucoseLevel <= 115 ){
                         vm.up.level = "normal";
                     }
                     else if(vm.tv.glucoseLevel < 50 ){
                         vm.up.level = "low";
                     }
                     vm.up.projectId = $rootScope.patientUser;

                     conn2.send(JSON.stringify(vm.up));
                     // $http({
                     //     url: '/diabetes/project/updateLevel',
                     //     method: 'post',
                     //     data: vm.up
                     // }).then(function (response) {
                     //     $log.info(response)
                     // }, function (reason) {
                     //     $scope.error = reason.data;
                     //     $log.info(reason);
                     // });

                     $("#my-form")[0].reset();
                 }
             }





         };


     })
     .controller("memoScheduleController", function ($scope,$rootScope,ngDialog,$http,$log,toastr) {
         var vm = this;
         var conn ;
         if($rootScope.memoConnectionCount < 1){
             ++$rootScope.memoConnectionCount;
             conn = new WebSocket("ws://" + window.location.host +"/memo/" + $rootScope.patientUser);
             conn.onopen = function () {
                 console.log("connection opened");
             };

             conn.onmessage = function (e) {
                 var memo = JSON.parse(e.data);
                 if(memo.projectId==$rootScope.patientUser){
                     $rootScope.$apply(function() {
                         vm.memos.push(memo);
                     });
                     console.log("messaging");
                 }

             };

             conn.onclose = function () {
                 console.log("connection closed");
             };

             conn.onerror = function (error) {
                 console.log('Error ' + error);
             };

             $scope.$on('$stateChangeStart', function (event, next) {
                 $rootScope.memoConnectionCount=0;
                 conn.close();
             });
         }

         var conn3 ;
         if($rootScope.projectConnectionCount2 < 1){
             ++$rootScope.projectConnectionCount2;
             conn3 = new WebSocket("ws://" + window.location.host +"/newMemo/" + ("patient" + $rootScope.patientUser));
             conn3.onopen = function () {
                 console.log("connection opened");
             };

             conn3.onmessage = function (e) {
                 console.log("messaging");
             };

             conn3.onclose = function () {
                 console.log("connection closed");
             };

             conn3.onerror = function (error) {
                 console.log('Error ' + error);
             };

             $scope.$on('$stateChangeStart', function (event, next) {
                 $rootScope.projectConnectionCount2=0;
                 conn3.close();
             });
         }

         vm.memo = {};
         vm.um= {};
         vm.clickToOpen = function () {

             ngDialog.openConfirm({
                 template: 'memoDialogTemplate',
                 className: 'ngdialog-theme-default',
                 controller: 'memoScheduleController',
                 controllerAs: 'memoScheduleCtrl',
                 width: 600,
                 showClose: false,
                 closeByEscape: false,
                 closeByNavigation: false,
                 closeByDocument: false

             }).then(function (value) {

                 vm.memo.memoDateTime = moment();
                 vm.memo.authorName = $rootScope.name;
                 vm.memo.identity = 'patient';
                 vm.memo.projectId = $rootScope.patientUser;
                 vm.memo.content = value;

                 vm.um.projectId = $rootScope.patientUser;
                 conn.send(JSON.stringify(vm.memo));
                 conn3.send(JSON.stringify(vm.um));
                 toastr.success('New memo added');
                 // $http({
                 //     url:'/diabetes/memo/writeMemo',
                 //     method: 'post',
                 //     data: vm.memo
                 // }).then(function (response) {
                 //     vm.memos.push(response.data);
                 //     $log.info(response)
                 //     toastr.success('New memo added');
                 //
                 // }, function(reason) {
                 //     vm.error = reason.data;
                 //     $log.info(reason);
                 //     toastr.error('Error');
                 // });

                 console.log('Modal promise resolved. Value: ', value);
             }, function (reason) {
                 console.log('Modal promise rejected. Reason: ', reason);
             });

         };

         $http({
             url: '/diabetes/memo/'+ $rootScope.patientUser ,
             method: 'get'
         }).then(function (response) {
             vm.memos = response.data;
             $log.info(response)
         }, function(reason) {
             vm.error = reason.data;
             $log.info(reason);
         });



         vm.getMemoColour = function(identity) {
             if(identity == "doctor"){
                 return "note doctorColor";
             }else if(identity == "patient"){
                 return "note patientColor";
             }
         };

         var week = ["Monday", "Tuesday", "Wednesday","Thursday", "Friday", "Saturday", "Sunday"];
         $http({
             url:'/diabetes/schedule/'+ $rootScope.patientUser + '/' +  week[0],
             method: 'get'
         }) .then(function(response) {
             vm.mondays = response.data;
             $log.info(response);
         }, function (reason) {
             vm.error = reason.data;
             $log.info(reason);
         });
         $http({
             url:'/diabetes/schedule/'+ $rootScope.patientUser + '/' +  week[1],
             method: 'get'
         }) .then(function(response) {
             vm.tuesdays = response.data;
             $log.info(response);
         }, function (reason) {
             vm.error = reason.data;
             $log.info(reason);
         });
         $http({
             url:'/diabetes/schedule/'+ $rootScope.patientUser + '/' +  week[2],
             method: 'get'
         }) .then(function(response) {
             vm.wednesdays = response.data;
             $log.info(response);
         }, function (reason) {
             vm.error = reason.data;
             $log.info(reason);
         });
         $http({
             url:'/diabetes/schedule/'+ $rootScope.patientUser + '/' +  week[3],
             method: 'get'
         }) .then(function(response) {
             vm.thursdays = response.data;
             $log.info(response);
         }, function (reason) {
             vm.error = reason.data;
             $log.info(reason);
         });
         $http({
             url:'/diabetes/schedule/'+ $rootScope.patientUser + '/' +  week[4],
             method: 'get'
         }) .then(function(response) {
             vm.fridays = response.data;
             $log.info(response);
         }, function (reason) {
             vm.error = reason.data;
             $log.info(reason);
         });
         $http({
             url:'/diabetes/schedule/'+ $rootScope.patientUser + '/' +  week[5],
             method: 'get'
         }) .then(function(response) {
             vm.saturdays = response.data;
             $log.info(response);
         }, function (reason) {
             vm.error = reason.data;
             $log.info(reason);
         });
         $http({
             url:'/diabetes/schedule/'+ $rootScope.patientUser + '/' +  week[6],
             method: 'get'
         }) .then(function(response) {
             vm.sundays = response.data;
             $log.info(response);
         }, function (reason) {
             vm.error = reason.data;
             $log.info(reason);
         });

     })
     .controller("statisticController", function ($scope, $http, $log, $rootScope, currentDateService, yesterdayDateService) {
         var vm = this;
         vm.dayOption = '';



         ////////////////////////////////////////////////////////// Today Start .////////////////////////////////////////////
         var time1 =[];
         vm.options1 = {
             chart: {
                 type: 'lineChart',
                 height: 450,
                 margin : {
                     top: 20,
                     right: 160,
                     bottom: 140,
                     left: 190
                 },
                 x: function(d){ return d.x; },
                 y: function(d){ return d.y; },
                 useInteractiveGuideline: true,
                 dispatch: {
                     stateChange: function(e){ console.log("stateChange"); },
                     changeState: function(e){ console.log("changeState"); },
                     tooltipShow: function(e){ console.log("tooltipShow"); },
                     tooltipHide: function(e){ console.log("tooltipHide"); }
                 },
                 xAxis: {
                     axisLabel: 'Event (Notes, 12-hour clock)',
                     tickFormat: function(d){
                         return time1[d];
                     }
                 },
                 yAxis: {
                     axisLabel: 'Blood Glucose (mg/dL)',
                     tickFormat: function(d){
                         return (d);
                     },
                     axisLabelDistance: -10
                 },
                 //forceY: [50],
                yDomain: [50,380],
                // yRange: [350,20],

                 callback: function(chart){
                     console.log("!!! lineChart callback !!!");
                 }
             },
             title: {
                 enable: true,
                 text: 'Blood Glucose Level'
             },
             subtitle: {
                 enable: true,
                 text: 'Today',
                 css: {
                     'text-align': 'center',
                     'margin': '10px 13px 0px 7px'
                 }
             },
             // caption: {
             //     enable: true,
             //     html: '<b>Figure 1.</b> Lorem ipsum dolor sit amet, at eam blandit sadipscing, <span style="text-decoration: underline;">vim adhuc sanctus disputando ex</span>, cu usu affert alienum urbanitas. <i>Cum in purto erat, mea ne nominavi persecuti reformidans.</i> Docendi blandit abhorreant ea has, minim tantas alterum pro eu. <span style="color: darkred;">Exerci graeci ad vix, elit tacimates ea duo</span>. Id mel eruditi fuisset. Stet vidit patrioque in pro, eum ex veri verterem abhorreant, id unum oportere intellegam nec<sup>[1, <a href="https://github.com/krispo/angular-nvd3" target="_blank">2</a>, 3]</sup>.',
             //     css: {
             //         'text-align': 'justify',
             //         'margin': '10px 13px 0px 7px'
             //     }
             // }
         };

         vm.data1 = getData1();

         function getData1() {
             var data = [];
             var count = 0 ;
             var logDetails1;
             var error1;
             $http({
                 url:'/diabetes/diabetelog/'+ $rootScope.patientUser + '/' +  currentDateService.getCurrentDate(),
                 method: 'get'
             }).then(function (response) {
                 logDetails1 = response.data;
                 $log.info(response);
                 angular.forEach(logDetails1, function(log) {
                     data.push({
                         x: count++,
                         y: log.glucoseLevel
                     });
                     time1.push(log.notes+ ', '+log.trackTime);
                 });
             }, function(reason) {
                 error1 = reason.data;
                 $log.info(reason);
             });
             //Line chart data should be sent as an array of series objects.
             return [
                 {
                     values: data,      //values - represents the array of {x,y} data points
                     key: 'Glucose level', //key  - the name of the series.
                     color: '#ff7f0e'  //color - optional: choose your own line color.
                 },
             ];
         };

         ////////////////////////////////////////////////////////// Today End .////////////////////////////////////////////
         //////////////////////////////////////////////// Yesterday Start.///////////////////////////////////////////////
         var time2 =[];
         vm.options2 = {
             chart: {
                 type: 'lineChart',
                 height: 450,
                 margin : {
                     top: 20,
                     right: 160,
                     bottom: 140,
                     left: 190
                 },
                 x: function(d){ return d.x; },
                 y: function(d){ return d.y; },
                 useInteractiveGuideline: true,
                 dispatch: {
                     stateChange: function(e){ console.log("stateChange"); },
                     changeState: function(e){ console.log("changeState"); },
                     tooltipShow: function(e){ console.log("tooltipShow"); },
                     tooltipHide: function(e){ console.log("tooltipHide"); }
                 },
                 xAxis: {
                     axisLabel: 'Event (Notes, 12-hour clock)',
                     tickFormat: function(d){
                         return time2[d];
                     }
                 },
                 yAxis: {
                     axisLabel: 'Blood Glucose (mg/dL)',
                     tickFormat: function(d){
                         return (d);
                     },
                     axisLabelDistance: -10
                 },
                 //forceY: [50],
                 yDomain: [50,380],
                 // yRange: [350,20],

                 callback: function(chart){
                     console.log("!!! lineChart callback !!!");
                 }
             },
             title: {
                 enable: true,
                 text: 'Blood Glucose Level'
             },
             subtitle: {
                 enable: true,
                 text: 'Yesterday',
                 css: {
                     'text-align': 'center',
                     'margin': '10px 13px 0px 7px'
                 }
             },
             // caption: {
             //     enable: true,
             //     html: '<b>Figure 1.</b> Lorem ipsum dolor sit amet, at eam blandit sadipscing, <span style="text-decoration: underline;">vim adhuc sanctus disputando ex</span>, cu usu affert alienum urbanitas. <i>Cum in purto erat, mea ne nominavi persecuti reformidans.</i> Docendi blandit abhorreant ea has, minim tantas alterum pro eu. <span style="color: darkred;">Exerci graeci ad vix, elit tacimates ea duo</span>. Id mel eruditi fuisset. Stet vidit patrioque in pro, eum ex veri verterem abhorreant, id unum oportere intellegam nec<sup>[1, <a href="https://github.com/krispo/angular-nvd3" target="_blank">2</a>, 3]</sup>.',
             //     css: {
             //         'text-align': 'justify',
             //         'margin': '10px 13px 0px 7px'
             //     }
             // }
         };

         vm.data2 = getData2(yesterdayDateService.getYesterdayDate());

         function getData2(day) {
             var data = [];
             var count = 0 ;
             var logDetails2;
             var error2;
             $http({
                 url:'/diabetes/diabetelog/'+ $rootScope.patientUser + '/' + day,
                 method: 'get'
             }).then(function (response) {
                 logDetails2 = response.data;
                 $log.info(response)
                 angular.forEach(logDetails2, function(log) {
                     data.push({
                         x: count++,
                         y: log.glucoseLevel
                     });
                     time2.push(log.notes+ ', '+log.trackTime);
                 });
             }, function(reason) {
                 error2 = reason.data;
                 $log.info(reason);
             });
             //Line chart data should be sent as an array of series objects.
             return [
                 {
                     values: data,      //values - represents the array of {x,y} data points
                     key: 'Glucose level', //key  - the name of the series.
                     color: '#ff7f0e'  //color - optional: choose your own line color.
                 },
             ];
         };
         //////////////////////////////////////////////// Yesterday End.///////////////////////////////////////////////

         //////////////////////////////////////////////// More Start.//////////////////////////////////////////////////
        vm.selectedDate = '';
        vm.changeValue = function() {
            vm.selectedDate= $('#date').val();
            vm.dataN = getDataN(vm.selectedDate);
         };
         var timeN =[];
         vm.optionsN = {
             chart: {
                 type: 'lineChart',
                 height: 450,
                 margin : {
                     top: 20,
                     right: 160,
                     bottom: 140,
                     left: 190
                 },
                 x: function(d){ return d.x; },
                 y: function(d){ return d.y; },
                 useInteractiveGuideline: true,
                 dispatch: {
                     stateChange: function(e){ console.log("stateChange"); },
                     changeState: function(e){ console.log("changeState"); },
                     tooltipShow: function(e){ console.log("tooltipShow"); },
                     tooltipHide: function(e){ console.log("tooltipHide"); }
                 },
                 xAxis: {
                     axisLabel: 'Event (Notes, 12-hour clock)',
                     tickFormat: function(d){
                         return timeN[d];
                     }
                 },
                 yAxis: {
                     axisLabel: 'Blood Glucose (mg/dL)',
                     tickFormat: function(d){
                         return (d);
                     },
                     axisLabelDistance: -10
                 },
                 //forceY: [50],
                 yDomain: [50,380],
                 // yRange: [350,20],

                 callback: function(chart){
                     console.log("!!! lineChart callback !!!");
                 }
             },
             title: {
                 enable: true,
                 text: 'Blood Glucose Level'
             },
             subtitle: {
                 enable: true,
                 text: "(search)",
                 css: {
                     'text-align': 'center',
                     'margin': '10px 13px 0px 7px'
                 }
             },
             // caption: {
             //     enable: true,
             //     html: '<b>Figure 1.</b> Lorem ipsum dolor sit amet, at eam blandit sadipscing, <span style="text-decoration: underline;">vim adhuc sanctus disputando ex</span>, cu usu affert alienum urbanitas. <i>Cum in purto erat, mea ne nominavi persecuti reformidans.</i> Docendi blandit abhorreant ea has, minim tantas alterum pro eu. <span style="color: darkred;">Exerci graeci ad vix, elit tacimates ea duo</span>. Id mel eruditi fuisset. Stet vidit patrioque in pro, eum ex veri verterem abhorreant, id unum oportere intellegam nec<sup>[1, <a href="https://github.com/krispo/angular-nvd3" target="_blank">2</a>, 3]</sup>.',
             //     css: {
             //         'text-align': 'justify',
             //         'margin': '10px 13px 0px 7px'
             //     }
             // }
         };
         vm.dataN = getDataN();
         function getDataN(day) {
             var data = [];
             var count = 0 ;
             var logDetailsN;
             var errorN;
             $http({
                 url:'/diabetes/diabetelog/'+ $rootScope.patientUser + '/' + day,
                 method: 'get'
             }).then(function (response) {
                 logDetailsN = response.data;
                 $log.info(response)
                 angular.forEach(logDetailsN, function(log) {
                     data.push({
                         x: count++,
                         y: log.glucoseLevel
                     });
                     timeN.push(log.notes+ ', '+log.trackTime);
                 });
             }, function(reason) {
                 errorN = reason.data;
                 $log.info(reason);
             });
             //Line chart data should be sent as an array of series objects.
             return [
                 {
                     values: data,      //values - represents the array of {x,y} data points
                     key: 'Glucose level', //key  - the name of the series.
                     color: '#ff7f0e'  //color - optional: choose your own line color.
                 },
             ];
         };
         //////////////////////////////////////////////////// More End.////////////////////////////////////////////////////

         /////////////////////////////////////////////////// Bar Chart Start. /////////////////////////////////////////////
         var date =[];

         vm.options3 = {
             chart: {
                 type: 'historicalBarChart',
                 height: 550,
                 margin : {
                     top: 20,
                     right: 160,
                     bottom: 140,
                     left: 190
                 },
                 x: function(d){return d.x;},
                 y: function(d){return d.y;},
                 showValues: true,
                 valueFormat: function(d){
                     return (d);
                 },
                 duration: 100,
                 xAxis: {
                     axisLabel:'Date (yyyy-mm-dd)',
                     tickFormat: function(d) {
                         return date[d];
                     },
                     rotateLabels: 30,
                     showMaxMin: false
                 },
                 yAxis: {
                     axisLabel: 'Average Glucose Level (mg/dL)',
                     axisLabelDistance: -10,
                     tickFormat: function(d){
                         return (d);
                     }
                 },
                 padData: true,
                 showLegend: true,
                 //forceY: [50],
                 yDomain: [50,380],
                 //yRange: [350,20],
                 tooltip: {
                     keyFormatter: function(d) {
                         return date[d];
                     }
                 },
                 zoom: {
                     enabled: true,
                     scaleExtent: [1, 10],
                     useFixedDomain: false,
                     useNiceScale: false,
                     horizontalOff: false,
                     verticalOff: true,
                     unzoomEventType: 'dblclick.zoom'
                 }
             },title: {
                 enable: true,
                 text: 'Blood Glucose Level(Average)',
             },
             subtitle: {
                 enable: true,
                 text: 'Each day',
                 css: {
                     'text-align': 'center',
                     'margin': '10px 13px 0px 7px'
                 }
             }
         };

         vm.data3 = getData3();

         function getData3() {
             var data = [];
             var count = 0 ;
             var logDetails3;
             var error3;
             $http({
                 url: '/diabetes/diabetelog/averageGlucose/'+ $rootScope.patientUser ,
                 method: 'get'
             }).then(function (response) {
                 logDetails3 = response.data;
                 $log.info(response)
                 angular.forEach(logDetails3, function(log) {
                     data.push({
                         x: count++,
                         y: log.glucoseLevel
                     });
                     date.push(log.trackDate);
                 });
             }, function(reason) {
                 error3 = reason.data;
                 $log.info(reason);
             });
             //Line chart data should be sent as an array of series objects.
             return [
                 {
                     key: 'Avg glucose level', //key  - the name of the series.
                     bar: true,  //color - optional: choose your own line color.
                     values: data,      //values - represents the array of {x,y} data points
                 },
             ];
         };


     });


