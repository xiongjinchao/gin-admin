{{ define "css" }}
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
                    <i class="fa fa-gears"></i> 系统设置
                </li>
                <li class="breadcrumb-item active">
                    <strong><i class="fa fa-graduation-cap"></i> 管理员</strong>
                </li>
            </ol>
        </div>
        <div class="col-lg-2">

        </div>
    </div>

    {{/*content*/}}
    <div class="wrapper wrapper-content animated fadeInRight">
        <div class="row">
            <div class="col-lg-6">
                <p>
                    <a class="btn btn-outline btn-success" href="/admin/admin/edit/{{ .admin.ID }}"><i class="fa fa-edit"></i> 更新</a>
                    <a class="btn btn-outline btn-danger" href="/admin/admin/delete/{{ .admin.ID }}"><i class="fa fa-trash"></i> 删除</a>
                </p>
                <div class="ibox float-e-margins">
                    <div class="ibox-title">
                        <h5>{{ .title }}</h5>
                        <div class="ibox-tools">
                            <a class="collapse-link">
                                <i class="fa fa-chevron-up"></i>
                            </a>
                            <a class="dropdown-toggle" data-toggle="dropdown" href="#">
                                <i class="fa fa-wrench"></i>
                            </a>
                            <ul class="dropdown-menu dropdown-admin">
                                <li><a href="#">选项 1</a></li>
                                <li><a href="#">选项 2</a></li>
                            </ul>
                            <a class="close-link">
                                <i class="fa fa-times"></i>
                            </a>
                        </div>
                    </div>
                    <div class="ibox-content">
                        <table id="w0" class="table table-striped table-bordered detail-view" style="table-layout:fixed">
                            <tbody>
                                <tr>
                                    <th style="width:20%;">管理员编号</th>
                                    <td>{{ .admin.ID }}</td>
                                </tr>
                                <tr>
                                    <th>姓名</th>
                                    <td>{{ .admin.Name }}</td>
                                </tr>
                                <tr>
                                    <th>手机号</th>
                                    <td>{{ .admin.Mobile }}</td>
                                </tr>
                                <tr>
                                    <th>邮箱</th>
                                    <td>{{ .admin.Email }}</td>
                                </tr>
                                <tr>
                                    <th>密码</th>
                                    <td>{{ .admin.Password }}</td>
                                </tr>
                                <tr>
                                    <th>RememberToken</th>
                                    <td style="word-wrap:break-word;">{{ .admin.RememberToken }}</td>
                                </tr>
                                <tr>
                                    <th>创建时间</th>
                                    <td>{{ .admin.CreatedAt.Format "2006-01-02 15:04:05" }}</td>
                                </tr>
                                <tr>
                                    <th>更新时间</th>
                                    <td>{{ .admin.UpdatedAt.Format "2006-01-02 15:04:05" }}</td>
                                </tr>
                            </tbody>
                        </table>
                    </div>
                </div>
            </div>
        </div>
    </div>
{{ end }}

{{ define "js" }}
{{ end }}