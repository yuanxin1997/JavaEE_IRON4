<style>
    .selectorGap {
        margin-bottom:11px;
    }
</style>
<script type="text/ng-template" id="eventDeleteConfirmTemplate">
    <div class="ngdialog-message">
        <h3>Delete Event</h3>
        <p>Are you sure you want to delete ?</p>
    </div>
    <div class="ngdialog-buttons">
        <button type="button" class="ngdialog-button ngdialog-button-primary" ng-click="confirm()">Yes</button>
        <button type="button" class="ngdialog-button ngdialog-button-secondary" ng-click="closeThisDialog()">No</button>
    </div>
</script>
<script type="text/ng-template" id="eventCreateTemplate">
    <div class="ngdialog-message">
        <div>
            <div>
                <div>
                    <h2 class="text-center text-info">New Event</h2></div>
                <div>
                    <form id="createEventForm">
                        <div class="form-group">
                            <select class="form-control selectorGap" ng-model="scheduleEditCtrl.event.tag">
                                <optgroup label="Category">
                                    <option value="Category" selected hidden>Category</option>
                                    <option value="Diet">Diet</option>
                                    <option value="Medication">Medication</option>
                                    <option value="Exercise">Exercise</option>
                                    <option value="Diagnosis">Diagnosis</option>
                                </optgroup>
                            </select>
                            <select class="form-control selectorGap" ng-model="scheduleEditCtrl.event.startTime">
                                <optgroup label="Start Time">
                                    <option value="Start Time" selected hidden>Start Time</option>
                                    <option value="08:00">08:00</option>
                                    <option value="09:00">09:00</option>
                                    <option value="10:00">10:00</option>
                                    <option value="11:00">11:00</option>
                                    <option value="12:00">12:00</option>
                                    <option value="13:00">13:00</option>
                                    <option value="14:00">14:00</option>
                                    <option value="15:00">15:00</option>
                                    <option value="16:00">16:00</option>
                                    <option value="17:00">17:00</option>
                                    <option value="18:00">18:00</option>
                                    <option value="19:00">19:00</option>
                                    <option value="20:00">20:00</option>
                                </optgroup>
                            </select>
                            <select class="form-control selectorGap" ng-model="scheduleEditCtrl.duration">
                                <optgroup label="Duration">
                                    <option value="Duration" selected hidden>Duration</option>
                                    <option value="2 hours">2 hours</option>
                                    <option value="3 hours">3 hours</option>
                                    <option value="4 hours">4 hours</option>
                                </optgroup>
                            </select>
                        </div>
                        <div class="form-group has-feedback">
                            <textarea rows="8" ng-model="scheduleEditCtrl.event.content" placeholder="Description..." class="form-control"></textarea><i class="form-control-feedback fa fa-pencil" aria-hidden="true"></i></div>
                    </form>
                </div>
                <div class="clearfix"></div>
            </div>
        </div>
    </div>
    <div class="ngdialog-buttons">
        <button type="button" class="ngdialog-button ngdialog-button-primary" ng-click="scheduleEditCtrl.checkInput(scheduleEditCtrl.event.tag, scheduleEditCtrl.event.startTime, scheduleEditCtrl.duration, scheduleEditCtrl.event.content)">Create</button>
        <button type="button" class="ngdialog-button ngdialog-button-secondary" ng-click="closeThisDialog()">Cancel</button>
    </div>
</script>
<script type="text/ng-template" id="eventEditTemplate">
    <div class="ngdialog-message">
        <div>
            <div>
                <div>
                    <h2 class="text-center text-info">Time : {{temp.tempStartTime}} - {{temp.tempEndTime}}</h2></div>
                <div>
                    <form id="editEventForm">
                        <form id="my-form">
                            <div class="form-group">
                                <select class="form-control selectorGap" ng-model="temp.tempTag">
                                    <optgroup label="Category">
                                        <option value="Category" selected hidden>Category</option>
                                        <option value="Diet">Diet</option>
                                        <option value="Medication">Medication</option>
                                        <option value="Exercise">Exercise</option>
                                        <option value="Tests and diagnosis">Tests and diagnosis</option>
                                    </optgroup>
                                </select>
                            </div>
                            <div class="form-group has-feedback">
                                <textarea rows="6" name="messages" ng-model="temp.tempContent" required placeholder="Description..." class="form-control"></textarea><i class="form-control-feedback fa fa-pencil" aria-hidden="true"></i></div>
                        </form>
                    </form>
                </div>
                <div class="clearfix"></div>
            </div>
        </div>
    </div>
    <div class="ngdialog-buttons">
        <button type="button" class="ngdialog-button ngdialog-button-primary" ng-click="checkInput(temp.tempContent) && confirm(temp)">Save</button>
        <button type="button" class="ngdialog-button ngdialog-button-secondary" ng-click="closeThisDialog()">Cancel</button>
    </div>
</script>
<div class="container-fluid">
    <div class="card">
        <div class="container" id="info-container">
            <div class="row">
                <div class="col-md-11">
                    <div class="panel-group" role="tablist" aria-multiselectable="true" id="accordion-1">
                        <div class="table-responsive animated bounceInLeft">
                            <div role="tab">
                                <h1><a role="button" class="noDecoration" data-toggle="collapse"
                                       data-parent="#accordion-1" aria-expanded="true" href="#accordion-1 .item-1"><b
                                        class="dec-con col-leftmargin">Monday</b>
                                    <i class="pull-left glyphicon glyphicon-plus icon-color"></i></a></h1>
                            </div>
                            <div class="collapse item-1" role="tabpanel">
                                <table class="highlight table">
                                    <thead>
                                    <tr>
                                        <th>
                                            <span class="pull-left">Time</span>
                                            <span class="tag-xx-space">Category</span>
                                        </th>
                                    </tr>
                                    </thead>
                                    <tbody>
                                    <tr data-ng-repeat="monday in scheduleEditCtrl.mondays | orderBy:'startTime'">
                                        <td>
                                            <span class="pull-left">{{monday.startTime}} - {{monday.endTime}}</span>
                                            <span class="tag-space">{{monday.tag}}</span>
                                            <span class="pull-right hid-style">
                           <a href="" ng-click="scheduleEditCtrl.clickToOpen3(monday.id,monday,monday.day,monday.startTime,monday.endTime,monday.tag,monday.content)"><i class="fa fa-pencil"></i></a>
                           <a href="" ng-click="scheduleEditCtrl.clickToOpen(monday.id,monday,monday.day)"><i class="fa fa-trash"></i></a>
                        </span>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>
                                            <a href="" class="aClick" ng-click="scheduleEditCtrl.clickToOpen2('Monday')">
                                                <span class="pull-right add-f-size">New Event</span>
                                                <span><i class="pull-right fa fa-pencil-square-o"></i></span>
                                            </a>
                                        </td>
                                    </tr>
                                    </tbody>
                                </table>
                            </div>
                        </div>

                        <div class="table-responsive animated bounceInLeft">
                            <div role="tab">
                                <h1><a role="button" class="noDecoration" data-toggle="collapse"
                                       data-parent="#accordion-1" aria-expanded="true" href="#accordion-1 .item-2"><b
                                        class="dec-con col-leftmargin">Tuesday</b>
                                    <i class="pull-left glyphicon glyphicon-plus icon-color"></i></a></h1>
                            </div>
                            <div class="collapse item-2" role="tabpanel">
                                <table class="highlight table">
                                    <thead>
                                    <tr>
                                        <th>
                                            <span class="pull-left">Time</span>
                                            <span class="tag-xx-space">Category</span>
                                        </th>
                                    </tr>
                                    </thead>
                                    <tbody>
                                    <tr data-ng-repeat="tuesday in scheduleEditCtrl.tuesdays | orderBy:'startTime'">
                                        <td>
                                            <span class="pull-left">{{tuesday.startTime}} - {{tuesday.endTime}}</span>
                                            <span class="tag-space">{{tuesday.tag}}</span>
                                            <span class="pull-right hid-style">
                           <a href="" ng-click="scheduleEditCtrl.clickToOpen3(tuesday.id,tuesday,tuesday.day,tuesday.startTime,tuesday.endTime,tuesday.tag,tuesday.content)"><i class="fa fa-pencil"></i></a>
                           <a href="" ng-click="scheduleEditCtrl.clickToOpen(tuesday.id,tuesday,tuesday.day)"><i class="fa fa-trash"></i></a>
                        </span>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>
                                            <a href="" class="aClick" ng-click="scheduleEditCtrl.clickToOpen2('Tuesday')">
                                                <span class="pull-right add-f-size">New Event</span>
                                                <span><i class="pull-right fa fa-pencil-square-o"></i></span>
                                            </a>
                                        </td>
                                    </tr>
                                    </tbody>
                                </table>
                            </div>
                        </div>

                        <div class="table-responsive animated bounceInLeft">
                            <div role="tab">
                                <h1><a role="button" class="noDecoration" data-toggle="collapse"
                                       data-parent="#accordion-1" aria-expanded="true" href="#accordion-1 .item-3"><b
                                        class="dec-con col-leftmargin">Wednesday</b>
                                    <i class="pull-left glyphicon glyphicon-plus icon-color"></i></a></h1>
                            </div>
                            <div class="collapse item-3" role="tabpanel">
                                <table class="highlight table">
                                    <thead>
                                    <tr>
                                        <th>
                                            <span class="pull-left">Time</span>
                                            <span class="tag-xx-space">Category</span>
                                        </th>
                                    </tr>
                                    </thead>
                                    <tbody>
                                    <tr data-ng-repeat="wednesday in scheduleEditCtrl.wednesdays | orderBy:'startTime'">
                                        <td>
                                            <span class="pull-left">{{wednesday.startTime}} - {{wednesday.endTime}}</span>
                                            <span class="tag-space">{{wednesday.tag}}</span>
                                            <span class="pull-right hid-style">
                           <a href="" ng-click="scheduleEditCtrl.clickToOpen3(wednesday.id,wednesday,wednesday.day,wednesday.startTime,wednesday.endTime,wednesday.tag,wednesday.content)"><i class="fa fa-pencil"></i></a>
                           <a href="" ng-click="scheduleEditCtrl.clickToOpen(wednesday.id,wednesday,wednesday.day)"><i class="fa fa-trash"></i></a>
                        </span>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>
                                            <a href="" class="aClick" ng-click="scheduleEditCtrl.clickToOpen2('Wednesday')">
                                                <span class="pull-right add-f-size">New Event</span>
                                                <span><i class="pull-right fa fa-pencil-square-o"></i></span>
                                            </a>
                                        </td>
                                    </tr>
                                    </tbody>
                                </table>
                            </div>
                        </div>

                        <div class="table-responsive animated bounceInLeft">
                            <div role="tab">
                                <h1><a role="button" class="noDecoration" data-toggle="collapse"
                                       data-parent="#accordion-1" aria-expanded="true" href="#accordion-1 .item-4"><b
                                        class="dec-con col-leftmargin">Thursday</b>
                                    <i class="pull-left glyphicon glyphicon-plus icon-color"></i></a></h1>
                            </div>
                            <div class="collapse item-4" role="tabpanel">
                                <table class="highlight table">
                                    <thead>
                                    <tr>
                                        <th>
                                            <span class="pull-left">Time</span>
                                            <span class="tag-xx-space">Category</span>
                                        </th>
                                    </tr>
                                    </thead>
                                    <tbody>
                                    <tr data-ng-repeat="thursday in scheduleEditCtrl.thursdays | orderBy:'startTime'">
                                        <td>
                                            <span class="pull-left">{{thursday.startTime}} - {{thursday.endTime}}</span>
                                            <span class="tag-space">{{thursday.tag}}</span>
                                            <span class="pull-right hid-style">
                           <a href="" ng-click="scheduleEditCtrl.clickToOpen3(thursday.id,thursday,thursday.day,thursday.startTime,thursday.endTime,thursday.tag,thursday.content)"><i class="fa fa-pencil"></i></a>
                           <a href="" ng-click="scheduleEditCtrl.clickToOpen(thursday.id,thursday,thursday.day)"><i class="fa fa-trash"></i></a>
                        </span>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>
                                            <a href="" class="aClick" ng-click="scheduleEditCtrl.clickToOpen2('Thursday')">
                                                <span class="pull-right add-f-size">New Event</span>
                                                <span><i class="pull-right fa fa-pencil-square-o"></i></span>
                                            </a>
                                        </td>
                                    </tr>
                                    </tbody>
                                </table>
                            </div>
                        </div>

                        <div class="table-responsive animated bounceInLeft">
                            <div role="tab">
                                <h1><a role="button" class="noDecoration" data-toggle="collapse"
                                       data-parent="#accordion-1" aria-expanded="true" href="#accordion-1 .item-5"><b
                                        class="dec-con col-leftmargin">Friday</b>
                                    <i class="pull-left glyphicon glyphicon-plus icon-color"></i></a></h1>
                            </div>
                            <div class="collapse item-5" role="tabpanel">
                                <table class="highlight table">
                                    <thead>
                                    <tr>
                                        <th>
                                            <span class="pull-left">Time</span>
                                            <span class="tag-xx-space">Category</span>
                                        </th>
                                    </tr>
                                    </thead>
                                    <tbody>
                                    <tr data-ng-repeat="friday in scheduleEditCtrl.fridays | orderBy:'startTime'">
                                        <td>
                                            <span class="pull-left">{{friday.startTime}} - {{friday.endTime}}</span>
                                            <span class="tag-space">{{friday.tag}}</span>
                                            <span class="pull-right hid-style">
                           <a href="" ng-click="scheduleEditCtrl.clickToOpen3(friday.id,friday,friday.day,friday.startTime,friday.endTime,friday.tag,friday.content)"><i class="fa fa-pencil"></i></a>
                           <a href="" ng-click="scheduleEditCtrl.clickToOpen(friday.id,friday,friday.day)"><i class="fa fa-trash"></i></a>
                        </span>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>
                                            <a href="" class="aClick" ng-click="scheduleEditCtrl.clickToOpen2('Friday')">
                                                <span class="pull-right add-f-size">New Event</span>
                                                <span><i class="pull-right fa fa-pencil-square-o"></i></span>
                                            </a>
                                        </td>
                                    </tr>
                                    </tbody>
                                </table>
                            </div>
                        </div>

                        <div class="table-responsive animated bounceInLeft">
                            <div role="tab">
                                <h1><a role="button" class="noDecoration" data-toggle="collapse"
                                       data-parent="#accordion-1" aria-expanded="true" href="#accordion-1 .item-6"><b
                                        class="dec-con col-leftmargin">Saturday</b>
                                    <i class="pull-left glyphicon glyphicon-plus icon-color"></i></a></h1>
                            </div>
                            <div class="collapse item-6" role="tabpanel">
                                <table class="highlight table">
                                    <thead>
                                    <tr>
                                        <th>
                                            <span class="pull-left">Time</span>
                                            <span class="tag-xx-space">Category</span>
                                        </th>
                                    </tr>
                                    </thead>
                                    <tbody>
                                    <tr data-ng-repeat="saturday in scheduleEditCtrl.saturdays | orderBy:'startTime'">
                                        <td>
                                            <span class="pull-left">{{saturday.startTime}} - {{saturday.endTime}}</span>
                                            <span class="tag-space">{{saturday.tag}}</span>
                                            <span class="pull-right hid-style">
                           <a href="" ng-click="scheduleEditCtrl.clickToOpen3(saturday.id,saturday,saturday.day,saturday.startTime,saturday.endTime,saturday.tag,saturday.content)"><i class="fa fa-pencil"></i></a>
                           <a href="" ng-click="scheduleEditCtrl.clickToOpen(saturday.id,saturday,saturday.day)"><i class="fa fa-trash"></i></a>
                        </span>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>
                                            <a href="" class="aClick" ng-click="scheduleEditCtrl.clickToOpen2('Saturday')">
                                                <span class="pull-right add-f-size">New Event</span>
                                                <span><i class="pull-right fa fa-pencil-square-o"></i></span>
                                            </a>
                                        </td>
                                    </tr>
                                    </tbody>
                                </table>
                            </div>
                        </div>

                        <div class="table-responsive animated bounceInLeft">
                            <div role="tab">
                                <h1><a role="button" class="noDecoration" data-toggle="collapse"
                                       data-parent="#accordion-1" aria-expanded="true" href="#accordion-1 .item-7"><b
                                        class="dec-con col-leftmargin">Sunday</b>
                                    <i class="pull-left glyphicon glyphicon-plus icon-color"></i></a></h1>
                            </div>
                            <div class="collapse item-7" role="tabpanel">
                                <table class="highlight table">
                                    <thead>
                                    <tr>
                                        <th>
                                            <span class="pull-left">Time</span>
                                            <span class="tag-xx-space">Category</span>
                                        </th>
                                    </tr>
                                    </thead>
                                    <tbody>
                                    <tr data-ng-repeat="sunday in scheduleEditCtrl.sundays | orderBy:'startTime'">
                                        <td>
                                            <span class="pull-left">{{sunday.startTime}} - {{sunday.endTime}}</span>
                                            <span class="tag-space">{{sunday.tag}}</span>
                                            <span class="pull-right hid-style">
                           <a href="" ng-click="scheduleEditCtrl.clickToOpen3(sunday.id,sunday,sunday.day,sunday.startTime,sunday.endTime,sunday.tag,sunday.content)"><i class="fa fa-pencil"></i></a>
                           <a href="" ng-click="scheduleEditCtrl.clickToOpen(sunday.id,sunday,sunday.day)"><i class="fa fa-trash"></i></a>
                        </span>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>
                                            <a href="" class="aClick" ng-click="scheduleEditCtrl.clickToOpen2('Sunday')">
                                                <span class="pull-right add-f-size">New Event</span>
                                                <span><i class="pull-right fa fa-pencil-square-o"></i></span>
                                            </a>
                                        </td>
                                    </tr>
                                    </tbody>
                                </table>
                            </div>
                        </div>


                    </div>
                </div>
                <div class="clearfix"></div>
            </div>
        </div>
    </div>
</div>
<script src="diabetesAssets/js/editSchedule.js"></script>