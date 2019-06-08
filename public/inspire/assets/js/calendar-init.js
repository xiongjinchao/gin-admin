! function($) {
    "use strict";
    var CalendarPage = function() {};
    CalendarPage.prototype.init = function() {
        if ($.isFunction($.fn.fullCalendar)) {
            $('#external-events .fc-event').each(function() {
                var eventObject = { title: $.trim($(this).text()) };
                $(this).data('eventObject', eventObject);
                $(this).draggable({ zIndex: 999, revert: true, revertDuration: 0 });
            });
            var date = new Date();
            var d = date.getDate();
            var m = date.getMonth();
            var y = date.getFullYear();
            $('#calendar').fullCalendar({
                header: { left: 'prev,next today', center: 'title', right: 'month,basicWeek,basicDay' },
                editable: true,
                eventLimit: true,
                droppable: true,
                drop: function(date, allDay) {
                    var originalEventObject = $(this).data('eventObject');
                    var copiedEventObject = $.extend({}, originalEventObject);
                    copiedEventObject.start = date;
                    copiedEventObject.allDay = allDay;
                    $('#calendar').fullCalendar('renderEvent', copiedEventObject, true);
                    if ($('#drop-remove').is(':checked')) { $(this).remove(); }
                },
                events: [{ title: 'All Day Event', start: new Date(y, m, 1) }, { title: 'Long Event', start: new Date(y, m, d - 5), end: new Date(y, m, d - 2) }, { id: 999, title: 'Repeating Event', start: new Date(y, m, d - 3, 16, 0), allDay: false }, { id: 999, title: 'Repeating Event', start: new Date(y, m, d + 4, 16, 0), allDay: false }, { title: 'Meeting', start: new Date(y, m, d, 10, 30), allDay: false }, { title: 'Lunch', start: new Date(y, m, d, 12, 0), end: new Date(y, m, d, 14, 0), allDay: false }, { title: 'Birthday Party', start: new Date(y, m, d + 1, 19, 0), end: new Date(y, m, d + 1, 22, 30), allDay: false }, { title: 'Click for Google', start: new Date(y, m, 28), end: new Date(y, m, 29), url: 'http://google.com/' }]
            });
            $("#add_event_form").on('submit', function(ev) {
                ev.preventDefault();
                var $event = $(this).find('.new-event-form'),
                    event_name = $event.val();
                if (event_name.length >= 3) {
                    var newid = "new" + "" + Math.random().toString(36).substring(7);
                    $("#external-events").append('<div id="' + newid + '" class="fc-event">' + event_name + '</div>');
                    var eventObject = { title: $.trim($("#" + newid).text()) };
                    $("#" + newid).data('eventObject', eventObject);
                    $("#" + newid).draggable({ revert: true, revertDuration: 0, zIndex: 999 });
                    $event.val('').focus();
                } else { $event.focus(); }
            });
        } else { alert("Calendar plugin is not installed"); }
    }, $.CalendarPage = new CalendarPage, $.CalendarPage.Constructor = CalendarPage
}(window.jQuery),
function($) {
    "use strict";
    $.CalendarPage.init()
}(window.jQuery);