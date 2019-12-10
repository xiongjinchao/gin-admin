{{ define "css" }}
    <!-- Gritter -->
    <link href="/public/plug-in/gritter/jquery.gritter.css" rel="stylesheet">
{{ end }}

{{ define "content"}}
    {{/*breadcrumbs*/}}

    {{/*content*/}}
    <div class="row  border-bottom white-bg dashboard-header">
        <div class="col-md-3">
            <h2>欢迎，Gin Blog管理员</h2>
            <small>系统信息</small>
            <ul class="list-group clear-list m-t">
                <li class="list-group-item fist-item">
                    <span class="float-right">
                        {{ .system.hostName }}
                    </span>
                    <span class="label label-success">1</span> 主机名称
                </li>
                <li class="list-group-item">
                    <span class="float-right">
                        {{ .system.type }}
                    </span>
                    <span class="label label-info">2</span> 主机类型
                </li>
                <li class="list-group-item">
                    <span class="float-right">
                        {{ .system.architecture }}
                    </span>
                    <span class="label label-primary">3</span> 主机架构
                </li>
                <li class="list-group-item">
                    <span class="float-right">
                        {{ .system.CPU }}
                    </span>
                    <span class="label label-default">4</span> CPU核心数
                </li>
                <li class="list-group-item">
                    <span class="float-right">
                        {{ .system.memorySys }} / {{ .system.memorySelf }}
                    </span>
                    <span class="label label-primary">5</span> 使用内存(M)
                </li>
            </ul>
        </div>
        <div class="col-md-6">
            <div class="flot-chart dashboard-chart">
                <div class="flot-chart-content" id="flot-dashboard-chart"></div>
            </div>
            <div class="row text-center">
                <div class="col">
                    <div class=" m-l-md">
                        <span class="h5 font-bold m-t block"><i class="fal fa-user text-warning" style="font-size:24px;"></i> 0</span>
                        <small class="text-muted m-b block">本月新增用户数量</small>
                    </div>
                </div>
                <div class="col">
                    <span class="h5 font-bold m-t block"><i class="fal fa-file-word text-info" style="font-size:24px;"></i> 0</span>
                    <small class="text-muted m-b block">本周新增文章数量</small>
                </div>
                <div class="col">
                    <span class="h5 font-bold m-t block"><i class="fal fa-books text-danger" style="font-size:24px;"></i> 0</span>
                    <small class="text-muted m-b block">累计书籍数量</small>
                </div>
                <div class="col">
                    <span class="h5 font-bold m-t block"><i class="fal fa-star text-warning" style="font-size:24px;"></i> 0</span>
                    <small class="text-muted m-b block">本月点赞数量</small>
                </div>
                <div class="col">
                    <span class="h5 font-bold m-t block"><i class="fal fa-comments text-success" style="font-size:24px;"></i> 0</span>
                    <small class="text-muted m-b block">本月评论数量</small>
                </div>
            </div>
        </div>
        <div class="col-md-3">
            <div class="statistic-box">
                <h4>
                    用户喜好
                </h4>
                <p>
                    统计用户点击次数
                </p>
                <div class="row text-center">
                    <div class="col-lg-6">
                        <canvas id="doughnutChart" width="140" height="140" style="margin: 10px auto 0"></canvas>
                        <h5>点击分析</h5>
                    </div>
                    <div class="col-lg-6">
                        <canvas id="doughnutChart2" width="140" height="140" style="margin: 10px auto 0"></canvas>
                        <h5>操作记录</h5>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <div class="wrapper wrapper-content">
        <div class="row">
            <div class="col-lg-12">
                <div class="row">
                    <div class="col-lg-4">
                        <div class="ibox ">
                            <div class="ibox-title">
                                <h5>New data for the report</h5> <span class="label label-primary">IN+</span>
                                <div class="ibox-tools">
                                    <a class="collapse-link" href="">
                                        <i class="fal fa-chevron-up"></i>
                                    </a>
                                    <a class="dropdown-toggle" data-toggle="dropdown" href="#">
                                        <i class="fal fa-wrench"></i>
                                    </a>
                                    <ul class="dropdown-menu dropdown-user">
                                        <li><a href="#" class="dropdown-item">Config option 1</a>
                                        </li>
                                        <li><a href="#" class="dropdown-item">Config option 2</a>
                                        </li>
                                    </ul>
                                    <a class="close-link" href="">
                                        <i class="fal fa-times"></i>
                                    </a>
                                </div>
                            </div>
                            <div class="ibox-content">
                                <div>
                                    <div class="float-right text-right">
                                        <span class="bar_dashboard">5,3,9,6,5,9,7,3,5,2,4,7,3,2,7,9,6,4,5,7,3,2,1,0,9,5,6,8,3,2,1</span>
                                        <br />
                                        <small class="font-bold">$ 20 054.43</small>
                                    </div>
                                    <h4>NYS report new data!
                                        <br />
                                        <small class="m-r"><a href="graph_flot.html"> Check the stock price! </a> </small>
                                    </h4>
                                </div>
                            </div>
                        </div>
                        <div class="ibox ">
                            <div class="ibox-title">
                                <h5>Read below comments</h5>
                                <div class="ibox-tools">
                                    <a class="collapse-link" href="">
                                        <i class="fal fa-chevron-up"></i>
                                    </a>
                                    <a class="dropdown-toggle" data-toggle="dropdown" href="#">
                                        <i class="fal fa-wrench"></i>
                                    </a>
                                    <ul class="dropdown-menu dropdown-user">
                                        <li><a href="#" class="dropdown-item">Config option 1</a>
                                        </li>
                                        <li><a href="#" class="dropdown-item">Config option 2</a>
                                        </li>
                                    </ul>
                                    <a class="close-link" href="">
                                        <i class="fal fa-times"></i>
                                    </a>
                                </div>
                            </div>
                            <div class="ibox-content no-padding">
                                <ul class="list-group">
                                    <li class="list-group-item">
                                        <p><a class="text-info" href="#">@Alan Marry</a> I belive that. Lorem Ipsum is simply dummy text of the printing and typesetting industry.</p>
                                        <small class="block text-muted"><i class="fal fa-cabinet-filing"></i> 1 minuts ago</small>
                                    </li>
                                    <li class="list-group-item">
                                        <p><a class="text-info" href="#">@Stock Man</a> Check this stock chart. This price is crazy! </p>
                                        <div class="text-center m">
                                            <span id="sparkline8"></span>
                                        </div>
                                        <small class="block text-muted"><i class="fal fa-cabinet-filing"></i> 2 hours ago</small>
                                    </li>
                                    <li class="list-group-item">
                                        <p><a class="text-info" href="#">@Kevin Smith</a> Lorem ipsum unknown printer took a galley </p>
                                        <small class="block text-muted"><i class="fal fa-cabinet-filing"></i> 2 minuts ago</small>
                                    </li>
                                    <li class="list-group-item ">
                                        <p><a class="text-info" href="#">@Jonathan Febrick</a> The standard chunk of Lorem Ipsum</p>
                                        <small class="block text-muted"><i class="fal fa-cabinet-filing"></i> 1 hour ago</small>
                                    </li>
                                    <li class="list-group-item">
                                        <p><a class="text-info" href="#">@Alan Marry</a> I belive that. Lorem Ipsum is simply dummy text of the printing and typesetting industry.</p>
                                        <small class="block text-muted"><i class="fal fa-cabinet-filing"></i> 1 minuts ago</small>
                                    </li>
                                    <li class="list-group-item">
                                        <p><a class="text-info" href="#">@Kevin Smith</a> Lorem ipsum unknown printer took a galley </p>
                                        <small class="block text-muted"><i class="fal fa-cabinet-filing"></i> 2 minuts ago</small>
                                    </li>
                                </ul>
                            </div>
                        </div>
                    </div>
                    <div class="col-lg-4">
                        <div class="ibox ">
                            <div class="ibox-title">
                                <h5>Your daily feed</h5>
                                <div class="ibox-tools">
                                    <span class="label label-warning-light float-right">10 Messages</span>
                                </div>
                            </div>
                            <div class="ibox-content">
                                <div>
                                    <div class="feed-activity-list">
                                        <div class="feed-element">
                                            <a class="float-left" href="profile.html">
                                                <img alt="image" class="rounded-circle" src="/public/plug-in/inspinia/img/profile.jpg">
                                            </a>
                                            <div class="media-body ">
                                                <small class="float-right">5m ago</small>
                                                <strong>Monica Smith</strong> posted a new blog. <br>
                                                <small class="text-muted">Today 5:60 pm - 12.06.2014</small>
                                            </div>
                                        </div>
                                        <div class="feed-element">
                                            <a class="float-left" href="profile.html">
                                                <img alt="image" class="rounded-circle" src="/public/plug-in/inspinia/img/a2.jpg">
                                            </a>
                                            <div class="media-body ">
                                                <small class="float-right">2h ago</small>
                                                <strong>Mark Johnson</strong> posted message on <strong>Monica Smith</strong> site. <br>
                                                <small class="text-muted">Today 2:10 pm - 12.06.2014</small>
                                            </div>
                                        </div>
                                        <div class="feed-element">
                                            <a class="float-left" href="profile.html">
                                                <img alt="image" class="rounded-circle" src="/public/plug-in/inspinia/img/a3.jpg">
                                            </a>
                                            <div class="media-body ">
                                                <small class="float-right">2h ago</small>
                                                <strong>Janet Rosowski</strong> add 1 photo on <strong>Monica Smith</strong>. <br>
                                                <small class="text-muted">2 days ago at 8:30am</small>
                                            </div>
                                        </div>
                                        <div class="feed-element">
                                            <a class="float-left" href="profile.html">
                                                <img alt="image" class="rounded-circle" src="/public/plug-in/inspinia/img/a4.jpg">
                                            </a>
                                            <div class="media-body ">
                                                <small class="float-right text-navy">5h ago</small>
                                                <strong>Chris Johnatan Overtunk</strong> started following <strong>Monica Smith</strong>. <br>
                                                <small class="text-muted">Yesterday 1:21 pm - 11.06.2014</small>
                                                <div class="actions">
                                                    <a href="" class="btn btn-xs btn-white"><i class="fal fa-thumbs-up"></i> Like </a>
                                                    <a href="" class="btn btn-xs btn-white"><i class="fal fa-heart"></i> Love</a>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="feed-element">
                                            <a class="float-left" href="profile.html">
                                                <img alt="image" class="rounded-circle" src="/public/plug-in/inspinia/img/a5.jpg">
                                            </a>
                                            <div class="media-body ">
                                                <small class="float-right">2h ago</small>
                                                <strong>Kim Smith</strong> posted message on <strong>Monica Smith</strong> site. <br>
                                                <small class="text-muted">Yesterday 5:20 pm - 12.06.2014</small>
                                                <div class="well">
                                                    Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s.
                                                    Over the years, sometimes by accident, sometimes on purpose (injected humour and the like).
                                                </div>
                                                <div class="float-right">
                                                    <a href="" class="btn btn-xs btn-white"><i class="fal fa-thumbs-up"></i> Like </a>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="feed-element">
                                            <a class="float-left" href="profile.html">
                                                <img alt="image" class="rounded-circle" src="/public/plug-in/inspinia/img/profile.jpg">
                                            </a>
                                            <div class="media-body ">
                                                <small class="float-right">23h ago</small>
                                                <strong>Monica Smith</strong> love <strong>Kim Smith</strong>. <br>
                                                <small class="text-muted">2 days ago at 2:30 am - 11.06.2014</small>
                                            </div>
                                        </div>
                                        <div class="feed-element">
                                            <a class="float-left" href="profile.html">
                                                <img alt="image" class="rounded-circle" src="/public/plug-in/inspinia/img/a7.jpg">
                                            </a>
                                            <div class="media-body ">
                                                <small class="float-right">46h ago</small>
                                                <strong>Mike Loreipsum</strong> started following <strong>Monica Smith</strong>. <br>
                                                <small class="text-muted">3 days ago at 7:58 pm - 10.06.2014</small>
                                            </div>
                                        </div>
                                    </div>
                                    <button class="btn btn-primary btn-block m-t"><i class="fal fa-arrow-down"></i> Show More</button>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="col-lg-4">
                        <div class="ibox ">
                            <div class="ibox-title">
                                <h5>Alpha project</h5>
                                <div class="ibox-tools">
                                    <a class="collapse-link" href="">
                                        <i class="fal fa-chevron-up"></i>
                                    </a>
                                    <a class="dropdown-toggle" data-toggle="dropdown" href="#">
                                        <i class="fal fa-wrench"></i>
                                    </a>
                                    <ul class="dropdown-menu dropdown-user">
                                        <li><a href="#" class="dropdown-item">Config option 1</a>
                                        </li>
                                        <li><a href="#" class="dropdown-item">Config option 2</a>
                                        </li>
                                    </ul>
                                    <a class="close-link" href="">
                                        <i class="fal fa-times"></i>
                                    </a>
                                </div>
                            </div>
                            <div class="ibox-content ibox-heading">
                                <h3>You have meeting today!</h3>
                                <small><i class="fal fa-map-marker"></i> Meeting is on 6:00am. Check your schedule to see detail.</small>
                            </div>
                            <div class="ibox-content inspinia-timeline">
                                <div class="timeline-item">
                                    <div class="row">
                                        <div class="col-4 date">
                                            <i class="fal fa-briefcase"></i>
                                            6:00 am
                                            <br />
                                            <small class="text-navy">2 hour ago</small>
                                        </div>
                                        <div class="col content no-top-border">
                                            <p class="m-b-xs"><strong>Meeting</strong></p>
                                            <p>Conference on the sales results for the previous year. Monica please examine sales trends in marketing and products. Below please find the current status of the
                                                sale.</p>
                                            <p><span data-diameter="40" class="updating-chart">5,3,9,6,5,9,7,3,5</span></p>
                                        </div>
                                    </div>
                                </div>
                                <div class="timeline-item">
                                    <div class="row">
                                        <div class="col-4 date">
                                            <i class="fal fa-file-word"></i>
                                            7:00 am
                                            <br />
                                            <small class="text-navy">3 hour ago</small>
                                        </div>
                                        <div class="col content">
                                            <p class="m-b-xs"><strong>Send documents to Mike</strong></p>
                                            <p>Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since.</p>
                                        </div>
                                    </div>
                                </div>
                                <div class="timeline-item">
                                    <div class="row">
                                        <div class="col-4 date">
                                            <i class="fal fa-coffee"></i>
                                            8:00 am
                                            <br />
                                        </div>
                                        <div class="col content">
                                            <p class="m-b-xs"><strong>Coffee Break</strong></p>
                                            <p>
                                                Go to shop and find some products.
                                                Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's.
                                            </p>
                                        </div>
                                    </div>
                                </div>
                                <div class="timeline-item">
                                    <div class="row">
                                        <div class="col-4 date">
                                            <i class="fal fa-phone"></i>
                                            11:00 am
                                            <br />
                                            <small class="text-navy">21 hour ago</small>
                                        </div>
                                        <div class="col content">
                                            <p class="m-b-xs"><strong>Phone with Jeronimo</strong></p>
                                            <p>
                                                Lorem Ipsum has been the industry's standard dummy text ever since.
                                            </p>
                                        </div>
                                    </div>
                                </div>
                                <div class="timeline-item">
                                    <div class="row">
                                        <div class="col-4 date">
                                            <i class="fal fa-user-md"></i>
                                            09:00 pm
                                            <br />
                                            <small>21 hour ago</small>
                                        </div>
                                        <div class="col content">
                                            <p class="m-b-xs"><strong>Go to the doctor dr Smith</strong></p>
                                            <p>
                                                Find some issue and go to doctor.
                                            </p>
                                        </div>
                                    </div>
                                </div>
                                <div class="timeline-item">
                                    <div class="row">
                                        <div class="col-4 date">
                                            <i class="fal fa-comments"></i>
                                            12:50 pm
                                            <br />
                                            <small class="text-navy">48 hour ago</small>
                                        </div>
                                        <div class="col content">
                                            <p class="m-b-xs"><strong>Chat with Monica and Sandra</strong></p>
                                            <p>
                                                Web sites still in their infancy. Various versions have evolved over the years, sometimes by accident, sometimes on purpose (injected humour and the like).
                                            </p>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>

{{ end }}

{{ define "js" }}
    <!-- Flot -->
    <script src="/public/plug-in/flot/jquery.flot.js"></script>
    <script src="/public/plug-in/flot/jquery.flot.tooltip.min.js"></script>
    <script src="/public/plug-in/flot/jquery.flot.spline.js"></script>
    <script src="/public/plug-in/flot/jquery.flot.resize.js"></script>
    <script src="/public/plug-in/flot/jquery.flot.pie.js"></script>

    <!-- Peity -->
    <script src="/public/js/jquery.peity.min.js"></script>
    <!-- <script src="/public/inspinia/js/demo/peity-demo.js"></script>-->

    <!-- GITTER -->
    <script src="/public/plug-in/gritter/jquery.gritter.min.js"></script>

    <!-- Sparkline -->
    <script src="/public/js/jquery.sparkline.min.js"></script>

    <!-- Sparkline demo data  -->
    <!-- <script src="/public/inspinia/js/demo/sparkline-demo.js"></script>  -->

    <!-- ChartJS-->
    <script src="/public/plug-in/chartjs/Chart.min.js"></script>

    <script>
        $(document).ready(function() {

            var data1 = [
                [0,4],[1,8],[2,5],[3,10],[4,4],[5,16],[6,5],[7,11],[8,6],[9,11],[10,30],[11,10],[12,13],[13,4],[14,3],[15,3],[16,6]
            ];
            var data2 = [
                [0,1],[1,8],[2,2],[3,0],[4,1],[5,3],[6,1],[7,5],[8,2],[9,3],[10,2],[11,1],[12,0],[13,2],[14,8],[15,0],[16,0]
            ];
            $("#flot-dashboard-chart").length && $.plot($("#flot-dashboard-chart"), [
                    data1, data2
                ],
                {
                    series: {
                        lines: {
                            show: false,
                            fill: true
                        },
                        splines: {
                            show: true,
                            tension: 0.4,
                            lineWidth: 1,
                            fill: 0.4
                        },
                        points: {
                            radius: 0,
                            show: true
                        },
                        shadowSize: 2
                    },
                    grid: {
                        hoverable: true,
                        clickable: true,
                        tickColor: "#d5d5d5",
                        borderWidth: 1,
                        color: '#d5d5d5'
                    },
                    colors: ["#1ab394", "#1C84C6"],
                    xaxis:{
                    },
                    yaxis: {
                        ticks: 4
                    },
                    tooltip: false
                }
            );

            var doughnutData = {
                labels: ["文章","书籍","其他" ],
                datasets: [{
                    data: [70,27,85],
                    backgroundColor: ["#23c6c8","#ed5565","#f8ac59"]
                }]
            } ;
            var doughnutOptions = {
                responsive: false,
                legend: {
                    display: false
                }
            };
            var ctx4 = document.getElementById("doughnutChart").getContext("2d");
            new Chart(ctx4, {type: 'doughnut', data: doughnutData, options:doughnutOptions});


            var doughnutData = {
                labels: ["有用","评论","收藏" ],
                datasets: [{
                    data: [300,50,100],
                    backgroundColor: ["#1c84c6","#23c6c8","#f8ac59"]
                }]
            } ;
            var doughnutOptions = {
                responsive: false,
                legend: {
                    display: false
                }
            };
            var ctx4 = document.getElementById("doughnutChart2").getContext("2d");
            new Chart(ctx4, {type: 'doughnut', data: doughnutData, options:doughnutOptions});

        });
    </script>
{{ end }}