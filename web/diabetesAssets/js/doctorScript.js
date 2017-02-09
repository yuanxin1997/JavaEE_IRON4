/// <reference path="angular.min.js" />

var app = angular.module('doctorApp', ["nvd3","ui.router","toastr","ngAnimate","ngDialog","angularMoment"])
    .run(function($rootScope) {
        $rootScope.doctorUser = '';
        $rootScope.projectId = "" ;
        $rootScope.name = "";
        $rootScope.memoConnectionCount = 0;
        $rootScope.diabeteLogConnectionCount = 0;
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
        $urlRouterProvider.otherwise("/home");
        $urlMatcherFactoryProvider.caseInsensitive(true);
        $stateProvider
            .state("docHome", {
                url: "/home",
                templateUrl: "diabetesAssets/Templates/docHome.jsp",
                controller: "docHomeController",
                controllerAs: "docHomeCtrl"

            })
            .state("docNav", {
                url: "/project",
                templateUrl: "diabetesAssets/Templates/docNav.jsp",
                controller: "docNavController",
                controllerAs: "scheduleEditCtrl",
                abstract: true
            })
            .state("docNav.scheduleEdit", {
                url: "/scheduleEdit/:id",
                templateUrl: "diabetesAssets/Templates/scheduleEdit.jsp",
                controller: "scheduleEditController",
                controllerAs: "scheduleEditCtrl"

            })
            .state("docNav.memoSchedule", {
                url : "/memoSchedule/:id",
                templateUrl: "diabetesAssets/Templates/memoSchedule.jsp",
                controller: "memoScheduleController",
                controllerAs: "memoScheduleCtrl"
            })
            .state("docNav.statistic", {
                url : "/statistic/:id",
                templateUrl: "diabetesAssets/Templates/statistic.jsp",
                controller: "statisticController",
                controllerAs: "statisticCtrl"
            })
    })
    .controller('myDoctorController', function($rootScope, $scope, $http, $log, currentDateService, toastr, $state, $stateParams, moment, ngDialog, $timeout) {

            var conn ;

            conn = new WebSocket("ws://" + window.location.host +"/project/" + $rootScope.doctorUser);
            conn.onopen = function () {
                console.log("connection opened");
            };

            conn.onmessage = function (e) {
                var wsProject = JSON.parse(e.data);
                angular.forEach($scope.projects, function(value, key){
                        if(wsProject.projectId==value.projectId ) {
                            $rootScope.$apply(function() {
                                $scope.projects[key].level = wsProject.level;
                                if(wsProject.level =='high' || wsProject.level =='low'){
                                    toastr.warning('Patient ID: '+ wsProject.projectId + ' recorded abnormal blood glucose level');
                                }
                            });
                        }
                });

                console.log("messaging");
            };

            conn.onclose = function () {
                console.log("connection closed");
            };

            conn.onerror = function (error) {
                console.log('Error ' + error);
            };

        var conn3 ;

        conn3 = new WebSocket("ws://" + window.location.host +"/newMemo/" + $rootScope.doctorUser);
        conn3.onopen = function () {
            console.log("connection opened");
        };

        conn3.onmessage = function (e) {
            var wsProject = JSON.parse(e.data);
            angular.forEach($scope.projects, function(value, key){
                if(wsProject.projectId==value.projectId ) {
                    $rootScope.$apply(function() {
                        $scope.projects[key].newMemo = wsProject.newMemo;
                        if(wsProject.newMemo !== 0){
                            toastr.info('New memo from Patient ID: '+ wsProject.projectId);
                        }
                    });
                }
            });

            console.log("messaging");
        };

        conn3.onclose = function () {
            console.log("connection closed");
        };

        conn3.onerror = function (error) {
            console.log('Error ' + error);
        };

            $http({
                method : 'GET',
                url: '/diabetes/project/' + $rootScope.doctorUser})
                .then(function(response) {
                    $scope.projects = response.data;
                    $log.info(response);
                }, function (reason) {
                    $scope.error = reason.data;
                    $log.info(reason);
                });


        $http({
            method : 'GET',
            url: '/diabetes/patient'})
            .then(function(response) {
                $scope.patients = response.data;
                $log.info(response);
            }, function (reason) {
                $scope.error = reason.data;
                $log.info(reason);
            });

        $http({
            method : 'GET',
            url: '/diabetes/project'})
            .then(function(response) {
                $scope.allProjects = response.data;
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

            $http({
                method : 'GET',
                url: '/diabetes/doctor/'+ $rootScope.doctorUser})
                .then(function(response) {
                    $scope.doctorDetails = response.data;
                    $rootScope.name = (response.data.lastName + " " +response.data.firstName);
                    $log.info(response);
                }, function (reason) {
                    $scope.error = reason.data;
                    $log.info(reason);
                });


        $scope.checkState = function(){
            if($state.current.name == "docHome"){
                return "true";
            }
            else if($state.current.name== "docNav")
                return "false";
        };


        $scope.getBackgroundColour = function(level) {
            if(level == "low"){
                return "panel panel-primary";
            }else if(level == "normal"){
                return "panel panel-green";
            }else if(level == "borderline"){
                return "panel panel-yellow";
            }else if(level == "high"){
                return "panel panel-red";
            }

        };



        $scope.openCreateProject = function () {
            $scope.cp = {};

            $scope.cp.patientId = '';
            $scope.$watch('cp.patientId', function(v){
                $scope.cp.projectId = v;
            });

            var valid = true;
            $scope.checkInput = function(){
                if(!$scope.cp.patientId){
                    valid = false;
                    toastr.error('Please fill in all the fields');
                }else{
                    var duplicateProject = false;
                    var patientExists = false;
                    var monitorByOther = false;
                    angular.forEach($scope.projects, function(value, key){
                        if(!duplicateProject)
                        {
                            if($scope.cp.projectId==value.projectId ) {
                                duplicateProject=true;
                            }
                            else{
                                duplicateProject=false;
                            }
                        }
                    });
                    angular.forEach($scope.patients, function(value, key){
                        if(!patientExists)
                        {
                            if($scope.cp.projectId==value.patientId ) {
                                patientExists=true;
                            }
                            else {
                                patientExists=false;
                            }
                        }
                    });
                    angular.forEach($scope.allProjects, function(value, key){
                        if(!monitorByOther)
                        {
                            if($scope.cp.projectId==value.projectId ) {
                                if($rootScope.doctorUser!==value.doctorId){
                                    monitorByOther=true;
                                }else {
                                    monitorByOther=false;
                                }
                            }
                        }
                    });

                    if(duplicateProject){
                        valid = false;
                        toastr.error("Project already exists");
                    }else if(!patientExists){
                        valid = false;
                        toastr.error("Patient does not exists");
                    } else if(monitorByOther){
                        valid = false;
                        toastr.error("Patient is under another doctor's monitoring");
                    } else{
                        valid = true;
                    }
                }

                return valid;
            };
            ngDialog.openConfirm({
                template: 'projectTemplate',
                className: 'ngdialog-theme-default',
                scope: $scope,
                width: 400,
                showClose: false,
                closeByEscape: false,
                closeByNavigation: false,
                closeByDocument: false

            }).then(function (value) {
                $scope.cp.createdOn = currentDateService.getCurrentDate();
                $scope.cp.doctorId = $rootScope.doctorUser;
                $http({
                    url: '/diabetes/project/createProject',
                    method: 'post',
                    data: $scope.cp
                }).then(function (response) {
                    $scope.projects.push(response.data);
                    $log.info(response)
                    toastr.success('Project created');
                }, function (reason) {
                    $scope.error = reason.data;
                    $log.info(reason);
                    toastr.error('Error');
                });
                console.log('Modal promise resolved. Value: ', value);
            }, function (reason) {
                console.log('Modal promise rejected. Reason: ', reason);
            });

        };

        $scope.openProfile = function () {
            $scope.docDetailsCopy = {};

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
                angular.copy($scope.doctorDetails, $scope.docDetailsCopy);
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
    .controller("docHomeController", function ($rootScope) {
        var vm = this;

    })
    .controller("docNavController", function ($scope) {
        var vm = this;
    })
    .controller("scheduleEditController", function ($scope,$stateParams,$rootScope,ngDialog,$http,$log,toastr) {
        var vm = this;
        $rootScope.projectNameId = $stateParams.id;

        // Delete Modal
        vm.clickToOpen = function (id,index,day) {
            ngDialog.openConfirm({
                template: 'eventDeleteConfirmTemplate',
                className: 'ngdialog-theme-default',
                controller: 'scheduleEditController',
                controllerAs: 'scheduleEditCtrl',
                width: 400,
                showClose: false,
                closeByEscape: false,
                closeByNavigation: false,
                closeByDocument: false

            }).then(function (value) {
                $http({
                    url:'/diabetes/schedule/'+ id,
                    method: 'delete'
                }).then(function (response) {
                    $log.info(response);
                    switch (day) {
                        case 'Monday':
                            vm.mondays.splice(vm.mondays.indexOf(index), 1);
                            break;
                        case 'Tuesday':
                            vm.tuesdays.splice(vm.tuesdays.indexOf(index), 1);
                            break;
                        case 'Wednesday':
                            vm.wednesdays.splice(vm.wednesdays.indexOf(index), 1);
                            break;
                        case 'Thursday':
                            vm.thursdays.splice(vm.thursdays.indexOf(index), 1);
                            break;
                        case 'Friday':
                            vm.fridays.splice(vm.fridays.indexOf(index), 1);
                            break;
                        case 'Saturday':
                            vm.saturdays.splice(vm.saturdays.indexOf(index), 1);
                            break;
                        case 'Sunday':
                            vm.sundays.splice(vm.sundays.indexOf(index), 1);
                            break;
                        default:

                    }
                    setTimeout(function(){
                        toastr.success('Event removed');
                    }, 500);

                }, function(reason) {
                    vm.error = reason.data;
                    $log.info(reason);
                    toastr.error('Error');
                });
                console.log('Modal promise resolved. Value: ', value);
            }, function (reason) {
                console.log('Modal promise rejected. Reason: ', reason);
            });

        };


        // initialize for create
        vm.duration = 'Duration';

        vm.event = {};
        vm.event.tag = 'Category';
        vm.event.startTime = 'Start Time';
        vm.event.content = '';

        vm.selectedDay = '';

        // Create Modal
        vm.clickToOpen2 = function (day) {
            selectedDay=day;
            //alert(selectedDay);
            var dialog = ngDialog.open({
                template: 'eventCreateTemplate',
                className: 'ngdialog-theme-default',
                controller: 'scheduleEditController',
                controllerAs: 'scheduleEditCtrl',
                scope: $scope,
                width: 400,
                showClose: false,
                closeByEscape: false,
                closeByNavigation: false,
                closeByDocument: false

            });

            dialog.closePromise.then(function (response) {
                console.log(response);
                if(response.value == undefined){
                    console.log("response is undefined");
                }else{
                    switch (response.value.data.day) {
                        case 'Monday':
                            vm.mondays.push(response.value.data);
                            break;
                        case 'Tuesday':
                            vm.tuesdays.push(response.value.data);
                            break;
                        case 'Wednesday':
                            vm.wednesdays.push(response.value.data);
                            break;
                        case 'Thursday':
                            vm.thursdays.push(response.value.data);
                            break;
                        case 'Friday':
                            vm.fridays.push(response.value.data);
                            break;
                        case 'Saturday':
                            vm.saturdays.push(response.value.data);
                            break;
                        case 'Sunday':
                            vm.sundays.push(response.value.data);
                            break;
                        default:
                    }
                    console.log('ngDialog closed.' +  ' response is : ' + JSON.stringify(response.value.data) +  ' day is : '+ JSON.stringify(response.value.data.day));
                }

            });

        };
        vm.convertToEndTime = function(end){

            // alert(end.toString().length);
            var converted = end.toString() + ':00';
            // alert(converted);

            return converted;
        };
        vm.checkOccupied = function(start, end, day) {

            var withinRange = false;
            switch (day) {
                case 'Monday':
                    angular.forEach(vm.mondays, function (value, key) {
                        if (!withinRange) {
                            var dbStart = parseInt((value.startTime).substr(0, 2));
                            var dbEnd = parseInt((value.endTime).substr(0, 2));

                            if ( (start > dbStart && start < dbEnd)|| (end > dbStart && end < dbEnd) || (start == dbStart && end == dbEnd) || (start < dbStart && end > dbEnd) || (start < dbStart && end == dbEnd)|| (start == dbStart && end > dbEnd) ){
                                // alert("start " + start + " end " + end +" dbstart" + dbStart + " dbend " + dbEnd);
                                withinRange = true;
                            }
                            else {
                                withinRange = false;
                            }
                        }
                    });
                    break;
                case 'Tuesday':
                    angular.forEach(vm.tuesdays, function (value, key) {
                        if (!withinRange) {
                            var dbStart = parseInt((value.startTime).substr(0, 2));
                            var dbEnd = parseInt((value.endTime).substr(0, 2));

                            if ( (start > dbStart && start < dbEnd)|| (end > dbStart && end < dbEnd) || (start == dbStart && end == dbEnd) || (start < dbStart && end > dbEnd) || (start < dbStart && end == dbEnd)|| (start == dbStart && end > dbEnd) ){
                                // alert("start " + start + " end " + end +" dbstart" + dbStart + " dbend " + dbEnd);
                                withinRange = true;
                            }
                            else {
                                withinRange = false;
                            }
                        }
                    });
                    break;
                case 'Wednesday':
                    angular.forEach(vm.wednesdays, function (value, key) {
                        if (!withinRange) {
                            var dbStart = parseInt((value.startTime).substr(0, 2));
                            var dbEnd = parseInt((value.endTime).substr(0, 2));

                            if ( (start > dbStart && start < dbEnd)|| (end > dbStart && end < dbEnd) || (start == dbStart && end == dbEnd) || (start < dbStart && end > dbEnd) || (start < dbStart && end == dbEnd)|| (start == dbStart && end > dbEnd) ){
                                // alert("start " + start + " end " + end +" dbstart" + dbStart + " dbend " + dbEnd);
                                withinRange = true;
                            }
                            else {
                                withinRange = false;
                            }
                        }
                    });
                    break;
                case 'Thursday':
                    angular.forEach(vm.thursdays, function (value, key) {
                        if (!withinRange) {
                            var dbStart = parseInt((value.startTime).substr(0, 2));
                            var dbEnd = parseInt((value.endTime).substr(0, 2));

                            if ( (start > dbStart && start < dbEnd)|| (end > dbStart && end < dbEnd) || (start == dbStart && end == dbEnd) || (start < dbStart && end > dbEnd) || (start < dbStart && end == dbEnd)|| (start == dbStart && end > dbEnd) ){
                                // alert("start " + start + " end " + end +" dbstart" + dbStart + " dbend " + dbEnd);
                                withinRange = true;
                            }
                            else {
                                withinRange = false;
                            }
                        }
                    });
                    break;
                case 'Friday':
                    angular.forEach(vm.fridays, function (value, key) {
                        if (!withinRange) {
                            var dbStart = parseInt((value.startTime).substr(0, 2));
                            var dbEnd = parseInt((value.endTime).substr(0, 2));

                            if ( (start > dbStart && start < dbEnd)|| (end > dbStart && end < dbEnd) || (start == dbStart && end == dbEnd) || (start < dbStart && end > dbEnd) || (start < dbStart && end == dbEnd)|| (start == dbStart && end > dbEnd) ){
                                // alert("start " + start + " end " + end +" dbstart" + dbStart + " dbend " + dbEnd);
                                withinRange = true;
                            }
                            else {
                                withinRange = false;
                            }
                        }
                    });
                    break;
                case 'Saturday':
                    angular.forEach(vm.saturdays, function (value, key) {
                        if (!withinRange) {
                            var dbStart = parseInt((value.startTime).substr(0, 2));
                            var dbEnd = parseInt((value.endTime).substr(0, 2));

                            if ( (start > dbStart && start < dbEnd)|| (end > dbStart && end < dbEnd) || (start == dbStart && end == dbEnd) || (start < dbStart && end > dbEnd) || (start < dbStart && end == dbEnd)|| (start == dbStart && end > dbEnd) ){
                                // alert("start " + start + " end " + end +" dbstart" + dbStart + " dbend " + dbEnd);
                                withinRange = true;
                            }
                            else {
                                withinRange = false;
                            }
                        }
                    });
                    break;
                case 'Sunday':
                    angular.forEach(vm.sundays, function (value, key) {
                        if (!withinRange) {
                            var dbStart = parseInt((value.startTime).substr(0, 2));
                            var dbEnd = parseInt((value.endTime).substr(0, 2));

                            if ( (start > dbStart && start < dbEnd)|| (end > dbStart && end < dbEnd) || (start == dbStart && end == dbEnd) || (start < dbStart && end > dbEnd) || (start < dbStart && end == dbEnd)|| (start == dbStart && end > dbEnd) ){
                                // alert("start " + start + " end " + end +" dbstart" + dbStart + " dbend " + dbEnd);
                                withinRange = true;
                            }
                            else {
                                withinRange = false;
                            }
                        }
                    });
                    break;
                default:

            }

            return withinRange;
        };
        var validInput = true;
        vm.checkInput = function(category,startTime,duration,description){
            var start = startTime.substring(0, 2);
            var end = parseInt(start)  + parseInt(duration.substring(0, 1));


            if(category=='Category'|| startTime=='Start Time' || duration=='Duration' || !description){  // check for Empty Value
                //alert('Please fill in all the fields'+ duration+startTime+category+' '+ start +' ' +end.toString() + ' ' + description + 'day is ' + selectedDay);
                toastr.error('Please fill in all the fields');
                validInput = false;
            }else if(end > 22){   // exceed time slot
                toastr.error('Exceeds schedule (max)time ');
                validInput = false;
            } else{

                if(vm.checkOccupied(start, end, selectedDay)){   // match available time slot
                    // alert('Time slot has been occupied'+ duration+startTime+category+' '+ start +' ' +end);
                    toastr.error('Time slot has been occupied');
                    validInput = false;
                }else{
                    validInput = true;

                    vm.event.projectId = $stateParams.id;
                    vm.event.day = selectedDay;
                    // tag exists
                    // startTime exists
                    vm.event.endTime = vm.convertToEndTime(end);
                    // content exists
                    // alert(JSON.stringify(vm.event));

                    $http({
                        url:'/diabetes/schedule/addEvent',
                        method: 'post',
                        data: vm.event
                    }).then(function (response) {
                        $log.info(response)
                        toastr.success("New event added");
                        $scope.closeThisDialog(response);

                    }, function(reason) {
                        vm.error = reason.data;
                        $log.info(reason);
                        toastr.error('Error');
                    });

                    }
                return validInput;
            }

        };



        // Update Modal

        vm.clickToOpen3 = function (id,index,day,startTime,endTime,tag,content) {
            $scope.temp ={};
            $scope.temp.tempStartTime = startTime;
            $scope.temp.tempEndTime = endTime;
            $scope.temp.tempTag = tag;
            $scope.temp.tempContent = content;
            var validInput2 = true;
            $scope.checkInput = function(description){
                if(!description){  // check for Empty Value
                    toastr.error('Please fill in all the fields');
                    validInput2 = false;
                }else
                    validInput2 = true;

                return validInput2;
            };
            ngDialog.openConfirm({
                template: 'eventEditTemplate',
                className: 'ngdialog-theme-default',
                controller: 'scheduleEditController',
                controllerAs: 'scheduleEditCtrl',
                scope: $scope,
                width: 400,
                showClose: false,
                closeByEscape: false,
                closeByNavigation: false,
                closeByDocument: false

            }).then(function (tempValue) {
                vm.editEvent = {};
                vm.editEvent.id = id;
                vm.editEvent.day = day;
                vm.editEvent.tag = tempValue.tempTag;
                vm.editEvent.projectId = $stateParams.id;
                vm.editEvent.startTime = startTime;
                vm.editEvent.endTime = endTime;
                vm.editEvent.content = tempValue.tempContent;
                vm.editEvent.deleteStatus = 'no';
                // alert(JSON.stringify(vm.editEvent));
                $http({
                    url:'/diabetes/schedule/updateEvent',
                    method: 'put',
                    data: vm.editEvent
                }).then(function (response) {
                    switch (day) {
                        case 'Monday':
                            vm.mondays.splice(vm.mondays.indexOf(index), 1);
                            setTimeout(function(){
                                vm.mondays.push(response.data);
                                toastr.success('Event Updated');
                            }, 600);
                            break;
                        case 'Tuesday':
                            vm.tuesdays.splice(vm.mondays.indexOf(index), 1);
                            setTimeout(function(){
                                vm.tuesdays.push(response.data);
                                toastr.success('Event Updated');
                            }, 600);
                            break;
                        case 'Wednesday':
                            vm.wednesdays.splice(vm.mondays.indexOf(index), 1);
                            setTimeout(function(){
                                vm.wednesdays.push(response.data);
                                toastr.success('Event Updated');
                            }, 600);
                            break;
                        case 'Thursday':
                            vm.thursdays.splice(vm.mondays.indexOf(index), 1);
                            setTimeout(function(){
                                vm.thursdays.push(response.data);
                                toastr.success('Event Updated');
                            }, 600);
                            break;
                        case 'Friday':
                            vm.fridays.splice(vm.mondays.indexOf(index), 1);
                            setTimeout(function(){
                                vm.fridays.push(response.data);
                                toastr.success('Event Updated');
                            }, 600);
                            break;
                        case 'Saturday':
                            vm.saturdays.splice(vm.mondays.indexOf(index), 1);
                            setTimeout(function(){
                                vm.saturdays.push(response.data);
                                toastr.success('Event Updated');
                            }, 600);
                            break;
                        case 'Sunday':
                            vm.sundays.splice(vm.mondays.indexOf(index), 1);
                            setTimeout(function(){
                                vm.sundays.push(response.data);
                                toastr.success('Event Updated');
                            }, 600);
                            break;
                        default:

                    }

                    $log.info(response);

                }, function(reason) {
                    vm.error = reason.data;
                    $log.info(reason);
                    toastr.error('Error');
                });
                console.log('Modal promise resolved. Value: ', tag);
            }, function (reason) {
                console.log('Modal promise rejected. Reason: ', reason);
            });

        };

        var week = ["Monday", "Tuesday", "Wednesday","Thursday", "Friday", "Saturday", "Sunday"];
        $http({
            url:'/diabetes/schedule/'+ $stateParams.id + '/' +  week[0],
            method: 'get'
        }) .then(function(response) {
            vm.mondays = response.data;
            $log.info(response);
        }, function (reason) {
            vm.error = reason.data;
            $log.info(reason);
        });
        $http({
            url:'/diabetes/schedule/'+ $stateParams.id + '/' +  week[1],
            method: 'get'
        }) .then(function(response) {
            vm.tuesdays = response.data;
            $log.info(response);
        }, function (reason) {
            vm.error = reason.data;
            $log.info(reason);
        });
        $http({
            url:'/diabetes/schedule/'+ $stateParams.id + '/' +  week[2],
            method: 'get'
        }) .then(function(response) {
            vm.wednesdays = response.data;
            $log.info(response);
        }, function (reason) {
            vm.error = reason.data;
            $log.info(reason);
        });
        $http({
            url:'/diabetes/schedule/'+ $stateParams.id + '/' +  week[3],
            method: 'get'
        }) .then(function(response) {
            vm.thursdays = response.data;
            $log.info(response);
        }, function (reason) {
            vm.error = reason.data;
            $log.info(reason);
        });
        $http({
            url:'/diabetes/schedule/'+ $stateParams.id + '/' +  week[4],
            method: 'get'
        }) .then(function(response) {
            vm.fridays = response.data;
            $log.info(response);
        }, function (reason) {
            vm.error = reason.data;
            $log.info(reason);
        });
        $http({
            url:'/diabetes/schedule/'+ $stateParams.id + '/' +  week[5],
            method: 'get'
        }) .then(function(response) {
            vm.saturdays = response.data;
            $log.info(response);
        }, function (reason) {
            vm.error = reason.data;
            $log.info(reason);
        });
        $http({
            url:'/diabetes/schedule/'+ $stateParams.id + '/' +  week[6],
            method: 'get'
        }) .then(function(response) {
            vm.sundays = response.data;
            $log.info(response);
        }, function (reason) {
            vm.error = reason.data;
            $log.info(reason);
        });

    })
    .controller("memoScheduleController", function ($scope,$stateParams,$rootScope,ngDialog,$http,$log,toastr) {
        var vm = this;
        $rootScope.projectNameId = $stateParams.id;
        var conn ;
            if($rootScope.memoConnectionCount < 1){
                ++$rootScope.memoConnectionCount;
            conn = new WebSocket("ws://" + window.location.host +"/memo/" + $rootScope.doctorUser);
            conn.onopen = function () {
                console.log("connection opened");
            };

            conn.onmessage = function (e) {
                var memo = JSON.parse(e.data);
                if(memo.projectId==$stateParams.id){
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

        vm.um= {};
        vm.um.projectId = $stateParams.id;

        var conn3 ;
        if($rootScope.projectConnectionCount2 < 1){
            ++$rootScope.projectConnectionCount2;
            conn3 = new WebSocket("ws://" + window.location.host +"/newMemo/" + ("doctor" + $rootScope.doctorUser));
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
                conn3.send(JSON.stringify(vm.um));
                $rootScope.projectConnectionCount2=0;
                conn3.close();
            });

        }

        vm.memo = {};
        vm.event = {};
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
                vm.memo.identity = 'doctor';
                vm.memo.projectId = $stateParams.id;
                vm.memo.content = value;

                conn.send(JSON.stringify(vm.memo));
                toastr.success('New memo added');
                // $http({
                //     url:'/diabetes/memo/writeMemo',
                //     method: 'post',
                //     data: vm.memo
                // }).then(function (response) {
                //     vm.memos.push(response.data);
                //     $log.info(response);
                //     toastr.success('New memo added');
                //
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
            url: '/diabetes/memo/'+ $stateParams.id ,
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
            url:'/diabetes/schedule/'+ $stateParams.id + '/' +  week[0],
            method: 'get'
        }) .then(function(response) {
            vm.mondays = response.data;
            $log.info(response);
        }, function (reason) {
            vm.error = reason.data;
            $log.info(reason);
        });
        $http({
            url:'/diabetes/schedule/'+ $stateParams.id + '/' +  week[1],
            method: 'get'
        }) .then(function(response) {
            vm.tuesdays = response.data;
            $log.info(response);
        }, function (reason) {
            vm.error = reason.data;
            $log.info(reason);
        });
        $http({
            url:'/diabetes/schedule/'+ $stateParams.id + '/' +  week[2],
            method: 'get'
        }) .then(function(response) {
            vm.wednesdays = response.data;
            $log.info(response);
        }, function (reason) {
            vm.error = reason.data;
            $log.info(reason);
        });
        $http({
            url:'/diabetes/schedule/'+ $stateParams.id + '/' +  week[3],
            method: 'get'
        }) .then(function(response) {
            vm.thursdays = response.data;
            $log.info(response);
        }, function (reason) {
            vm.error = reason.data;
            $log.info(reason);
        });
        $http({
            url:'/diabetes/schedule/'+ $stateParams.id + '/' +  week[4],
            method: 'get'
        }) .then(function(response) {
            vm.fridays = response.data;
            $log.info(response);
        }, function (reason) {
            vm.error = reason.data;
            $log.info(reason);
        });
        $http({
            url:'/diabetes/schedule/'+ $stateParams.id + '/' +  week[5],
            method: 'get'
        }) .then(function(response) {
            vm.saturdays = response.data;
            $log.info(response);
        }, function (reason) {
            vm.error = reason.data;
            $log.info(reason);
        });
        $http({
            url:'/diabetes/schedule/'+ $stateParams.id + '/' +  week[6],
            method: 'get'
        }) .then(function(response) {
            vm.sundays = response.data;
            $log.info(response);
        }, function (reason) {
            vm.error = reason.data;
            $log.info(reason);
        });


    })
    .controller("statisticController", function ($stateParams, $scope, $http, $log, $rootScope, currentDateService, yesterdayDateService) {
        var vm = this;
        vm.dayOption = '';
        $rootScope.projectNameId = $stateParams.id;

        var date =[];
        var time1 =[];
        var count1 = 0 ;
        var logDetails1;
        var conn ;
        if($rootScope.diabeteLogConnectionCount < 1){
            ++$rootScope.diabeteLogConnectionCount;
            conn = new WebSocket("ws://" + window.location.host +"/diabeteLog/" + $rootScope.doctorUser);
            conn.onopen = function () {
                console.log("connection opened");
            };

            conn.onmessage = function (e) {
                logDetails1 = JSON.parse(e.data);
                if(logDetails1.projectId==$stateParams.id){
                    $rootScope.$apply(function() {

                        vm.data1[0].values.push({
                            x: count1++,
                            y: logDetails1.glucoseLevel
                        });
                        time1.push(logDetails1.notes+ ', '+logDetails1.trackTime);

                        var todayValue = false;
                        for (i = 0; i < date.length; i++) {
                           if(date[i]==logDetails1.trackDate){
                               todayValue=true;
                           }else{
                               todayValue=false;
                           }
                        }
                        if(!todayValue){
                            date.push(logDetails1.trackDate);
                        }

                        date=[];
                        vm.data3 = getData3();
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
                $rootScope.diabeteLogConnectionCount=0;
                conn.close();
            });
        }

        ////////////////////////////////////////////////////////// Today Start .////////////////////////////////////////////

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
                    axisLabel: 'Time ( 12-hour clock)',
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
                text: 'Today ',
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

        vm.data1 = [{ values: [], key: 'Glucose level',color: '#ff7f0e' }];

            var error1;
            $http({
                url:'/diabetes/diabetelog/'+ $stateParams.id + '/' +  currentDateService.getCurrentDate(),
                method: 'get'
            }).then(function (response) {
                logDetails1 = response.data;
                $log.info(response);
                angular.forEach(logDetails1, function(log) {
                    vm.data1[0].values.push({
                        x: count1++,
                        y: log.glucoseLevel
                    });
                    time1.push(log.notes+ ', '+log.trackTime);
                });
            }, function(reason) {
                error1 = reason.data;
                $log.info(reason);
            });

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
                    axisLabel: 'Time ( 12-hour clock)',
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

        vm.data2 = getData2();

        function getData2() {
            var data = [];
            var count = 0 ;
            var logDetails2;
            var error2;
            $http({
                url:'/diabetes/diabetelog/'+ $stateParams.id + '/' +  yesterdayDateService.getYesterdayDate(),
                method: 'get'
            }).then(function (response) {
                logDetails2 = response.data;
                $log.info(response);
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

        vm.selectedDate ='';
        vm.changeValue =function () {
            vm.selectedDate =$('#date').val();
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
                url:'/diabetes/diabetelog/'+ $stateParams.id + '/' + day,
                method: 'get'
            }).then(function (response) {
                logDetailsN = response.data;
                $log.info(response);
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
                    axisLabel: 'Date (yyyy-mm-dd)',
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
                url: '/diabetes/diabetelog/averageGlucose/'+ $stateParams.id ,
                method: 'get'
            }).then(function (response) {
                logDetails3 = response.data;
                $log.info(response);
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


