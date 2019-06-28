{{ define "css" }}
    <link href="/public/inspinia/css/plugins/dataTables/datatables.min.css" rel="stylesheet">
{{ end }}

{{ define "content" }}
    {{/*breadcrumbs*/}}
    <div class="row wrapper border-bottom white-bg page-heading">
        <div class="col-lg-10">
            <h2>{{ .title}}</h2>
            <ol class="breadcrumb">
                <li class="breadcrumb-item">
                    <a href="/admin/dashboard"><i class="fa fa-desktop"></i> 系统面板</a>
                </li>
                <li class="breadcrumb-item">
                    <i class="fa fa-th-large"></i> 内容管理
                </li>
                <li class="breadcrumb-item active">
                    <strong><i class="fa fa-file-text-o"></i> {{ .title}}</strong>
                </li>
            </ol>
        </div>
        <div class="col-lg-2">

        </div>
    </div>

    {{/*content*/}}
    <div class="wrapper wrapper-content animated fadeInRight">
        <p><a class="btn btn-primary" href="article/create"> <i class="fa fa-plus-circle"></i> 创建文章</a></p>
        <div class="row">
            <div class="col-lg-12">
                <div class="ibox float-e-margins">
                    <div class="ibox-title">
                        <h5>{{ .title}}</h5>
                        <div class="ibox-tools">
                            <a class="collapse-link">
                                <i class="fa fa-chevron-up"></i>
                            </a>
                            <a class="dropdown-toggle" data-toggle="dropdown" href="#">
                                <i class="fa fa-wrench"></i>
                            </a>
                            <ul class="dropdown-menu dropdown-user">
                                <li><a href="#">选项 1</a></li>
                                <li><a href="#">选项 2</a></li>
                            </ul>
                            <a class="close-link">
                                <i class="fa fa-times"></i>
                            </a>
                        </div>
                    </div>
                    <div class="ibox-content">

                        <div class="table-responsive">
                            <table class="table table-striped table-bordered table-hover dataTables">
                                <thead>
                                <tr>
                                    <th>编号</th>
                                    <th>标题</th>
                                    <th>分类</th>
                                    <th>用户</th>
                                    <th>创建时间</th>
                                    <th>更新时间</th>
                                    <th>操作</th>
                                </tr>
                                </thead>
                                <tfoot>
                                <tr>
                                    <th>编号</th>
                                    <th>标题</th>
                                    <th>分类</th>
                                    <th>用户</th>
                                    <th>创建时间</th>
                                    <th>更新时间</th>
                                    <th>操作</th>
                                </tr>
                                </tfoot>
                            </table>
                        </div>

                    </div>
                </div>
            </div>
        </div>
    </div>
{{end}}

{{ define "js" }}
    <!-- Custom and plugin javascript -->

    <script src="/public/inspinia/js/plugins/dataTables/datatables.min.js"></script>
    <script src="/public/inspinia/js/plugins/dataTables/dataTables.bootstrap4.min.js"></script>

    <script>
        $(document).ready(function() {
            $('.dataTables').DataTable({
                language:{
                    url: '/public/inspinia/js/plugins/dataTables/Zh_cn.json',
                },
                pageLength: 25,
                responsive: true,
                processing: true,
                serverSide: true,
                ajax: {
                    url: "/admin/article-data",
                    type: "GET"
                },
                columns: [
                    { "data": "ID" },
                    { "data": "title" },
                    { "data": "category_id" },
                    { "data": "user_id" },
                    { "data": "CreatedAt" },
                    { "data": "UpdatedAt" },
                    { "data": "操作" }
                ],
                dom: '<"html5buttons"B>lTfgitp',
                buttons: [
                    { extend: 'copy' },
                    { extend: 'csv' },
                    { extend: 'excel', title: 'ExampleFile' },
                    { extend: 'pdf', title: 'ExampleFile' },

                    {
                        extend: 'print',
                        customize: function(win) {
                            $(win.document.body).addClass('white-bg');
                            $(win.document.body).css('font-size', '10px');

                            $(win.document.body).find('table')
                                .addClass('compact')
                                .css('font-size', 'inherit');
                        }
                    }
                ]

            });

        });

    </script>
{{ end }}