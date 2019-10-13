{{ define "css" }}
    <link href="/public/plug-in/dataTables/css/datatables.min.css" rel="stylesheet">
{{ end }}

{{ define "content" }}
    {{/*breadcrumbs*/}}
    <div class="row wrapper border-bottom white-bg page-heading">
        <div class="col-lg-10">
            <h2>{{ .title}}</h2>
            <ol class="breadcrumb">
                <li class="breadcrumb-item">
                    <a href="/admin/dashboard"><i class="fal fa-desktop"></i> 系统面板</a>
                </li>
                <li class="breadcrumb-item">
                    <i class="fal fa-cogs"></i> 系统设置
                </li>
                <li class="breadcrumb-item active">
                    <strong><i class="fal fa-user"></i> {{ .title}}</strong>
                </li>
            </ol>
        </div>
        <div class="col-lg-2">

        </div>
    </div>

    {{/*content*/}}
    <div class="wrapper wrapper-content animated fadeInRight">
        <p><a class="btn btn-primary" href="user/create"> <i class="fal fa-plus-circle"></i> 创建用户</a></p>
        <div class="row">
            <div class="col-lg-12">
                <div class="ibox float-e-margins">
                    <div class="ibox-title">
                        <h5>{{ .title}}</h5>
                        <div class="ibox-tools">
                            <a class="collapse-link">
                                <i class="fal fa-chevron-up"></i>
                            </a>
                            <a class="dropdown-toggle" data-toggle="dropdown" href="#">
                                <i class="fal fa-wrench"></i>
                            </a>
                            <ul class="dropdown-menu dropdown-user">
                                <li><a href="#">选项 1</a></li>
                                <li><a href="#">选项 2</a></li>
                            </ul>
                            <a class="close-link">
                                <i class="fal fa-times"></i>
                            </a>
                        </div>
                    </div>
                    <div class="ibox-content">

                        <div class="table-responsive">
                            <table class="table table-striped table-bordered table-hover dataTables">
                                <thead>
                                    <tr>
                                        <th>ID</th>
                                        <th>姓名</th>
                                        <th>邮箱</th>
                                        <th>手机号码</th>
                                        <th>创建时间</th>
                                        <th>更新时间</th>
                                        <th>操作</th>
                                    </tr>
                                </thead>
                                <tfoot>
                                    <tr>
                                        <th>ID</th>
                                        <th>姓名</th>
                                        <th>邮箱</th>
                                        <th>手机号码</th>
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
{{ end }}

{{ define "js" }}
    <!-- Custom and plugin javascript -->

    <script type="text/javascript" src="/public/plug-in/dataTables/js/pdfmake.min.js"></script>
    <script type="text/javascript" src="/public/plug-in/dataTables/js/vfs_fonts.js"></script>
    <script type="text/javascript" src="/public/plug-in/dataTables/js/datatables.min.js"></script>

    <script>
        $(document).ready(function() {
            $('.dataTables').DataTable({
                order: [[ 0, "desc" ]],
                autoWidth: false,
                language:{
                    url: '/public/plug-in/dataTables/Zh_cn.json',
                },
                pageLength: 25,
                responsive: true,
                processing: true,
                serverSide: true,
                ajax: {
                    url: "/admin/user/data",
                    type: "GET"
                },
                columns: [
                    { "data": "base.id" },
                    { "data": "name" },
                    { "data": "email" },
                    { "data": "mobile" },
                    { "data": "created_at", "render":
                        function(data, type, row, meta){
                            return moment(row.base.created_at).format("YYYY-MM-DD HH:mm:ss");
                        }
                    },
                    { "data": "updated_at", "render":
                        function(data, type, row, meta){
                            return moment(row.base.updated_at).format("YYYY-MM-DD HH:mm:ss");
                        }
                    },
                    { "data": null, "render":
                        function(data, type, row, meta){
                            return '<a href="/admin/user/show/'+row.base.id+'" class="btn btn-xs btn-outline btn-primary"><i class="fal fa-eye"></i> 查看</a> ' +
                                '<a href="/admin/user/edit/'+row.base.id+'" class="btn btn-xs btn-outline btn-success"><i class="fal fa-edit"></i> 编辑</a> ' +
                                '<a href="/admin/user/delete/'+row.base.id+'" class="btn btn-xs btn-outline btn-danger"><i class="fal fa-trash-alt"></i> 删除</a>';
                        }
                    }
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