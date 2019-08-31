{{ define "css" }}
    <link href="/public/inspinia/css/plugins/dataTables/datatables.min.css" rel="stylesheet">
    <style>
        .dataTables .label{padding:0 8px;}
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
                    <strong><i class="fa fa-user-o"></i> {{ .title}}</strong>
                </li>
            </ol>
        </div>
        <div class="col-lg-2">

        </div>
    </div>

    {{/*content*/}}
    <div class="wrapper wrapper-content animated fadeInRight">
        <p><a class="btn btn-primary" href="policy/create"> <i class="fa fa-plus-circle"></i> 创建角色</a></p>
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
                            <ul class="dropdown-menu dropdown-role">
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
                                        <th style="text-align:center;width:50px;"># </th>
                                        <th>角色</th>
                                        <th>拥有的 <span class="label label-primary">R</span> 角色 <span class="label label-warning">P</span> 权限</th>
                                        <th>操作</th>
                                    </tr>
                                </thead>
                                <tbody>
                                {{ range $i, $v := .roles }}
                                    <tr>
                                        <td style="text-align:center">{{ Add $i 1 }}</td>
                                        <td style="width:12%"><h4>{{ $v }}</h4></td>
                                        <td style="width:72%">
                                            <div class="row">
                                                {{ range $k,$p := $.permissions }}
                                                    {{ if eq $k $v}}
                                                        {{ range $p.roles}}
                                                            <div class="col-lg-4 py-1"><span class="label label-primary">R</span> {{ . }}</div>
                                                        {{ end }}
                                                    {{ end}}
                                                {{ end }}
                                            </div>
                                            <div class="row">
                                                {{ range $k,$p := $.permissions }}
                                                    {{ if eq $k $v}}
                                                        {{ range $p.permissions}}
                                                            <div class="col-lg-4 pt-1 py-1"><span class="label label-warning">P</span> {{ . }}</div>
                                                        {{ end }}
                                                    {{ end}}
                                                {{ end }}
                                            </div>
                                        </td>
                                        <td>
                                            <a href="/admin/policy/show/{{$v}}" class="btn btn-xs btn-outline btn-primary {{if or (Contains $v ":sys:") (Contains $v ":ctr:")}} disabled {{end}}"><i class="fa fa-eye"></i> 查看</a>
                                            <a href="/admin/policy/edit/{{$v}}" class="btn btn-xs btn-outline btn-success {{if or (Contains $v ":sys:") (Contains $v ":ctr:")}} disabled {{end}}"><i class="fa fa-edit"></i> 编辑</a>
                                            <a href="/admin/policy/delete/{{$v}}" class="btn btn-xs btn-outline btn-danger {{if or (Contains $v ":sys:") (Contains $v ":ctr:")}} disabled {{end}}"><i class="fa fa-trash"></i> 删除</a>
                                        </td>
                                    </tr>
                                {{ end }}
                                </tbody>
                            </table>
                        </div>

                    </div>
                </div>
            </div>
        </div>
    </div>
{{ end }}

{{ define "js" }}

{{ end }}