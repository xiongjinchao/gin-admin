(function($) {
    "use strict";
    $(window).on('load', function() {
        $('#preloader').fadeOut();
        $('[data-toggle="tooltip"]').tooltip()
        $('[data-toggle="popover"]').popover()
    });
}(jQuery));