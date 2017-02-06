
<script type="text/ng-template" id="memoDialogTemplate">
    <form id="memoForm">
        <div class="dialogContent">
            <label for="comment">Write your memo: </label>
            <textarea class="form-control" rows="5" id="comment" ng-model="memoScheduleCtrl.memo.content" required></textarea>
        </div>
        <div class="ngdialog-buttons">
            <button type="button" class="ngdialog-button ngdialog-button-primary" ng-click="confirm(memoScheduleCtrl.memo.content)">Done</button>
            <button type="button" class="ngdialog-button ngdialog-button-secondary" ng-click="closeThisDialog()">Cancel</button>
        </div>
    </form>
</script>
<style> .ng-cloak { display: none !important; } </style>
<div class="container-fluid">
    <div class="row">
        <div class="col-lg-3 col-md-12" id="memoContainer">

            <div class="memoDiv animated fadeInDown">
                <a href="" class="aClick" ng-click="memoScheduleCtrl.clickToOpen()" ><i class="fa fa-pencil-square-o memoPencil"><cite>&nbsp;write</cite></i></a>
            </div>
            <div class="allMemoContainer" ng-repeat="memo in memoScheduleCtrl.memos | orderBy:'':true">
                <div class="quote-container animated rollIn">
                    <i class="pin"></i>
                    <div ng-class="memoScheduleCtrl.getMemoColour(memo.identity)">
                        {{ memo.content }}
                        <cite class="author rollIn">-{{ memo.authorName }}</cite>
                        <cite class="dateTime"><span am-time-ago="memo.memoDateTime"></span>...</cite>
                    </div>
                </div>
            </div>

        </div>
        <div class="col-lg-9 col-md-12">
            <div class="cd-schedule ng-cloak">
                <div class="timeline">
                    <ul>
                        <li><span>08:00</span></li>
                        <!--<li><span>10:30</span></li>-->
                        <li><span>09:00</span></li>
                        <li><span>10:00</span></li>
                        <!--<li><span>11:30</span></li>-->
                        <li><span>11:00</span></li>
                        <li><span>12:00</span></li>
                        <!--<li><span>12:30</span></li>-->
                        <li><span>13:00</span></li>
                        <li><span>14:00</span></li>
                        <!--<li><span>13:30</span></li>-->
                        <li><span>15:00</span></li>
                        <li><span>16:00</span></li>
                        <!--<li><span>14:30</span></li>-->
                        <li><span>17:00</span></li>
                        <li><span>18:00</span></li>
                        <!--<li><span>15:30</span></li>-->
                        <li><span>19:00</span></li>
                        <li><span>20:00</span></li>
                        <!--<li><span>16:30</span></li>-->
                        <li><span>21:00</span></li>
                        <li><span>22:00</span></li>
                        <!--<li><span>17:30</span></li>-->

                    </ul>
                </div> <!-- .timeline -->

                <div class="events">
                    <ul>
                        <li class="events-group">
                            <div class="top-info"><span>Monday</span></div>

                            <ul>
                                    <li data-ng-repeat="monday in memoScheduleCtrl.mondays" class="single-event animated rollIn" data-tag={{monday.tag}} data-start={{monday.startTime}} data-end={{monday.endTime}}  data-content={{monday.content}}>
                                        <a href="#0">
                                        </a>
                                    </li>
                            </ul>
                        </li>

                        <li class="events-group">
                            <div class="top-info"><span>Tuesday</span></div>

                            <ul>
                                    <li data-ng-repeat="tuesday in memoScheduleCtrl.tuesdays" class="single-event animated rollIn" data-tag={{tuesday.tag}} data-start={{tuesday.startTime}} data-end={{tuesday.endTime}}  data-content={{tuesday.content}}>
                                        <a href="#0">
                                        </a>
                                    </li>
                            </ul>
                        </li>

                        <li class="events-group">
                            <div class="top-info"><span>Wednesday</span></div>

                            <ul>
                                    <li data-ng-repeat="wednesday in memoScheduleCtrl.wednesdays" class="single-event animated rollIn" data-tag={{wednesday.tag}} data-start={{wednesday.startTime}} data-end={{wednesday.endTime}}  data-content={{wednesday.content}}>
                                        <a href="#0">
                                        </a>
                                    </li>
                            </ul>
                        </li>

                        <li class="events-group">
                            <div class="top-info"><span>Thursday</span></div>

                            <ul>
                                    <li data-ng-repeat="thursday in memoScheduleCtrl.thursdays" class="single-event animated rollIn" data-tag={{thursday.tag}} data-start={{thursday.startTime}} data-end={{thursday.endTime}}  data-content={{thursday.content}}>
                                        <a href="#0">
                                        </a>
                                    </li>
                            </ul>
                        </li>

                        <li class="events-group">
                            <div class="top-info"><span>Friday</span></div>

                            <ul>
                                    <li data-ng-repeat="friday in memoScheduleCtrl.fridays" class="single-event animated rollIn" data-tag={{friday.tag}} data-start={{friday.startTime}} data-end={{friday.endTime}}  data-content={{friday.content}}>
                                        <a href="#0">
                                        </a>
                                    </li>
                            </ul>
                        </li>

                        <li class="events-group">
                            <div class="top-info"><span>Saturday</span></div>

                            <ul>
                                    <li data-ng-repeat="saturday in memoScheduleCtrl.saturdays" class="single-event animated rollIn" data-tag={{saturday.tag}} data-start={{saturday.startTime}} data-end={{saturday.endTime}}  data-content={{saturday.content}}>
                                        <a href="#0">
                                        </a>
                                    </li>
                            </ul>
                        </li>

                        <li class="events-group">
                            <div class="top-info"><span>Sunday</span></div>

                            <ul>
                                    <li data-ng-repeat="sunday in memoScheduleCtrl.sundays" class="single-event animated rollIn" data-tag={{sunday.tag}} data-start={{sunday.startTime}} data-end={{sunday.endTime}}  data-content={{sunday.content}}>
                                        <a href="#0">
                                        </a>
                                    </li>
                            </ul>
                        </li>
                    </ul>
                </div>

                <div class="event-modal">
                    <header class="header">
                        <div class="content">
                            <span class="event-date"></span>
                            <h3 class="event-name"></h3>
                        </div>

                        <div class="header-bg"></div>
                    </header>

                    <div class="body">
                        <div class="event-info"></div>
                        <div class="body-bg"></div>
                    </div>

                    <a href="#0" class="close">Close</a>
                </div>

                <div class="cover-layer"></div>
            </div> <!-- .cd-schedule -->

        </div>
    </div>
</div>
<script src="diabetesAssets/js/main.js"></script>
