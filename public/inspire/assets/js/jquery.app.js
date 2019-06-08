+ function($, window) {}(jQuery, window),
function($, window) {
    var sideNav = {};
    sideNav.init = function() {
        $(".side-nav .side-nav-menu li a").on("click", function(e) { $(this).parent().hasClass("open") ? $(this).parent().children(".dropdown-menu").slideUp(200, function() { $(this).parent().removeClass("open") }) : ($(this).parent().parent().children("li.open").children(".dropdown-menu").slideUp(200), $(this).parent().parent().children("li.open").children("a").removeClass("open"), $(this).parent().parent().children("li.open").removeClass("open"), $(this).parent().children(".dropdown-menu").slideDown(200, function() { $(this).parent().addClass("open") })) }), $(".sidenav-fold-toggler").on("click", function(e) { $(".app").toggleClass("side-nav-folded"), e.preventDefault() }), $(".sidenav-expand-toggler").on("click", function(e) {
            if ($(".side-nav-backdrop").length) $(".side-nav-backdrop").remove();
            else { $(".app").append('<div class="side-nav-backdrop"></div>') }
            $(".app").toggleClass("side-nav-expand"), e.stopPropagation(), $(".side-nav-backdrop").on("click", function(e) { $(".app").removeClass("side-nav-expand"), $(this).remove() })
        })
    }, window.sideNav = sideNav
}(jQuery, window),
function($) { sideNav.init() }(jQuery), $(document).on("change", 'input[name="header-theme"]', function() {
    var context = $('input[name="header-theme"]:checked').val();
    $(".app").removeClass(function(index, className) { return (className.match(/(^|\s)header-\S+/g) || []).join(" ") }).addClass("header-" + context)
});