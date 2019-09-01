{{ define "css" }}
    <style>
        #policy-table .label{padding:0 8px;}
    </style>
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
                    <strong><i class="fa fa-github-alt"></i> 角色权限</strong>
                </li>
            </ol>
        </div>
        <div class="col-lg-2">

        </div>
    </div>

    {{/*content*/}}
    <div class="wrapper wrapper-content animated fadeInRight">
        <div class="row">
            <div class="col-lg-12">
                <p>
                    <a class="btn btn-outline btn-success" href="/admin/policy/edit/{{ .role }}"><i class="fa fa-edit"></i> 更新</a>
                    <a class="btn btn-outline btn-danger" href="/admin/policy/delete/{{ .role }}"><i class="fa fa-trash"></i> 删除</a>
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
                        <table id="policy-table" class="table table-striped table-bordered detail-view" style="table-layout:fixed">
                            <tbody>
                                <tr>
                                    <th style="width:10%;">角色名称</th>
                                    <td><h4>{{ .role }}</h4></td>
                                </tr>
                                <tr>
                                    <th>拥有的角色</th>
                                    <td>
                                        <div class="row">
                                            {{ range .roles}}
                                                <div class="col-lg-3 py-1">
                                                    {{if or (Contains . ":sys:") (Contains . ":ctr:")}}
                                                        <span class="label label-danger">S</span>
                                                    {{ else }}
                                                        <span class="label label-success">C</span>
                                                    {{ end }}
                                                    <span class="label label-primary">R</span>
                                                    {{ . }}
                                                </div>
                                            {{ end }}
                                        </div>
                                    </td>
                                </tr>
                                <tr>
                                    <th>拥有的权限</th>
                                    <td>
                                        <div class="row">
                                            {{ range .permissions}}
                                                <div class="col-lg-3 py-1"><span class="label label-warning">P</span> {{ . }}</div>
                                            {{ end }}
                                        </div>
                                    </td>
                                </tr>
                                <tr>
                                    <th>所有权限</th>
                                    <td>
                                        <div class="row">
                                            {{ range .policy}}
                                                <div class="col-lg-3 py-1"><span class="label label-warning">P</span> {{ . }}</div>
                                            {{ end }}
                                        </div>
                                    </td>
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