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
                    <i class="fa fa-th-large"></i> 基础数据
                </li>
                <li class="breadcrumb-item active">
                    <strong><i class="fa fa-th-list"></i> 菜单管理</strong>
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
                    <a class="btn btn-outline btn-success" href="/admin/menu/edit/{{ .menu.ID }}"><i class="fa fa-edit"></i> 更新</a>
                    <a class="btn btn-outline btn-danger" href="/admin/menu/delete/{{ .menu.ID }}"><i class="fa fa-trash"></i> 删除</a>
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
                        <table id="w0" class="table table-striped table-bordered detail-view">
                            <tbody>
                                <tr>
                                    <th>菜单管理编号</th><td>{{ .menu.ID }}</td>
                                </tr>
                                <tr>
                                    <th>名称</th><td>{{ .menu.Name }}</td>
                                </tr>
                                <tr>
                                    <th>标签</th><td>{{ .menu.Tag }}</td>
                                </tr>
                                <tr>
                                    <th>所属菜单</th><td>{{ .menu.Parent }}</td>
                                </tr>
                                <tr>
                                    <th>概要</th><td>{{ .menu.Summary }}</td>
                                </tr>
                                <tr>
                                    <th>级别</th><td>{{ .menu.Level }}</td>
                                </tr>
                                <tr>
                                    <th>审核</th><td>{{ .menu.Audit }}</td>
                                </tr>
                                <tr>
                                    <th>排序</th><td>{{ .menu.Sort }}</td>
                                </tr>
                                <tr>
                                    <th>关键字</th><td>{{ .menu.Keyword }}</td>
                                </tr>
                                <tr>
                                    <th>创建时间</th><td>{{ .menu.CreatedAt.Format "2006-01-02 15:04:05" }}</td>
                                </tr>
                                <tr>
                                    <th>更新时间</th><td>{{ .menu.UpdatedAt.Format "2006-01-02 15:04:05" }}</td>
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