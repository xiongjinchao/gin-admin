! function($) {
    "use strict";
    var Dashboard = function() {};
    Dashboard.prototype.createBarChart = function(element, data, xkey, ykeys, labels, lineColors) { Morris.Bar({ element: element, data: data, xkey: xkey, ykeys: ykeys, labels: labels, gridLineColor: '#eee', barSizeRatio: 0.4, resize: true, hideHover: 'auto', barColors: lineColors }); }, Dashboard.prototype.createDonutChart = function(element, data, colors) { Morris.Donut({ element: element, data: data, resize: true, colors: colors, }); }, Dashboard.prototype.init = function() {
        var $barData = [{ y: '2018', a: 50, b: 70, c: 65 }, { y: '2019', a: 45, b: 85, c: 90 }, { y: '2020', a: 100, b: 60, c: 54 }, { y: '2021', a: 85, b: 75, c: 55 }, { y: '2022', a: 90, b: 80, c: 70 }, { y: '2023', a: 70, b: 90, c: 60 }];
        this.createBarChart('morris-bar-example', $barData, 'y', ['a', 'b', 'c'], ['Return', 'Revenue', 'Cost'], ['#e22a6f', '#24d5d8', '#ab8ce4']);
        var $donutData = [{ label: "Marketplace", value: 55 }, { label: "On-site", value: 30 }, { label: "Others", value: 15 }, ];
        this.createDonutChart('morris-donut-example', $donutData, ['#e22a6f', "#24d5d8", '#ab8ce4']);
    }, $.Dashboard = new Dashboard, $.Dashboard.Constructor = Dashboard
}(window.jQuery),
function($) {
    "use strict";
    $.Dashboard.init();
}(window.jQuery);