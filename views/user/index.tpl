{{ define "css" }}
    <link href="/public/inspinia/css/plugins/dataTables/datatables.min.css" rel="stylesheet">
{{ end }}
{{ define "content" }}
    {{/*breadcrumbs*/}}
    <div class="row wrapper border-bottom white-bg page-heading">
        <div class="col-lg-10">
            <h2>用户管理</h2>
            <ol class="breadcrumb">
                <li class="breadcrumb-item">
                    <a href="/admin/dashboard"><i class="fa fa-desktop"></i> 系统面板</a>
                </li>
                <li class="breadcrumb-item active">
                    <strong><i class="fa fa-user-o"></i> 用户管理</strong>
                </li>
            </ol>
        </div>
        <div class="col-lg-2">

        </div>
    </div>

    {{/*content*/}}
    <div class="wrapper wrapper-content animated fadeInRight" style="min-height:810px;">
        <p><a class="btn btn-primary" href="#"> <i class="fa fa-plus-circle"></i> 创建用户</a></p>
        <div class="row">
            <div class="col-lg-12">
                <div class="ibox float-e-margins">
                    <div class="ibox-title">
                        <h5>用户管理</h5>
                        <div class="ibox-tools">
                            <a class="collapse-link">
                                <i class="fa fa-chevron-up"></i>
                            </a>
                            <a class="dropdown-toggle" data-toggle="dropdown" href="#">
                                <i class="fa fa-wrench"></i>
                            </a>
                            <ul class="dropdown-menu dropdown-user">
                                <li><a href="#">Config option 1</a>
                                </li>
                                <li><a href="#">Config option 2</a>
                                </li>
                            </ul>
                            <a class="close-link">
                                <i class="fa fa-times"></i>
                            </a>
                        </div>
                    </div>
                    <div class="ibox-content">

                        <div class="table-responsive">
                            <table class="table table-striped table-bordered table-hover dataTables-example">
                                <thead>
                                    <tr>
                                        <th>用户编号</th>
                                        <th>姓名</th>
                                        <th>邮箱</th>
                                        <th>手机号码</th>
                                        <th>创建时间</th>
                                        <th>更新时间</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    {{ range $u := .user }}
                                        <tr class="gradeX">
                                            <td>{{ $u.Id}}</td>
                                            <td>{{ $u.Name}}</td>
                                            <td>{{ $u.Email}}</td>
                                            <td>{{ $u.Mobile}}</td>
                                            <td class="center">{{ $u.CreatedAt.Format "2006-01-02 15:04:05" }}</td>
                                            <td class="center">{{ $u.UpdatedAt.Format "2006-01-02 15:04:05" }}</td>
                                        </tr>
                                    {{ end }}
                                </tbody>
                                <tfoot>
                                    <tr>
                                        <th>用户编号</th>
                                        <th>姓名</th>
                                        <th>邮箱</th>
                                        <th>手机号码</th>
                                        <th>创建时间</th>
                                        <th>更新时间</th>
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

    <script src="/public/inspinia/js/plugins/dataTables/datatables.min.js"></script>
    <script src="/public/inspinia/js/plugins/dataTables/dataTables.bootstrap4.min.js"></script>

    <script>
        $(document).ready(function() {
            $('.dataTables-example').DataTable({
                pageLength: 25,
                responsive: true,
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