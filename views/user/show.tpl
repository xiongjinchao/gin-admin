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
                    <strong><i class="fa fa-user-o"></i> 用户管理</strong>
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
                    <a class="btn btn-outline btn-success" href="/admin/user/edit/{{ .user.ID }}"><i class="fa fa-edit"></i> 更新</a>
                    <a class="btn btn-outline btn-danger" href="/admin/user/delete/{{ .user.ID }}"><i class="fa fa-trash"></i> 删除</a>
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
                        <table id="w0" class="table table-striped table-bordered detail-view" style="table-layout:fixed">
                            <tbody>
                                <tr>
                                    <th style="width:20%;">用户编号</th>
                                    <td>{{ .user.ID }}</td>
                                </tr>
                                <tr>
                                    <th>姓名</th>
                                    <td>{{ .user.Name }}</td>
                                </tr>
                                <tr>
                                    <th>手机号</th>
                                    <td>{{ .user.Mobile }}</td>
                                </tr>
                                <tr>
                                    <th>邮箱</th>
                                    <td>{{ .user.Email }}</td>
                                </tr>
                                <tr>
                                    <th>密码</th>
                                    <td>{{ .user.Password }}</td>
                                </tr>
                                <tr>
                                    <th>AccessToken</th>
                                    <td style="word-wrap:break-word;">{{ .user.AccessToken }}</td>
                                </tr>
                                <tr>
                                    <th>ResetKey</th>
                                    <td>{{ .user.ResetKey }}</td>
                                </tr>
                                <tr>
                                    <th>创建时间</th>
                                    <td>{{ .user.CreatedAt.Format "2006-01-02 15:04:05" }}</td>
                                </tr>
                                <tr>
                                    <th>更新时间</th>
                                    <td>{{ .user.UpdatedAt.Format "2006-01-02 15:04:05" }}</td>
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