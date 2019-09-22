{{ define "css" }}
    <link href="/public/inspinia/css/plugins/awesome-bootstrap-checkbox/awesome-bootstrap-checkbox.css" rel="stylesheet">
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
                        <form id="menu-form" role="form" action="/admin/menu/update/{{ .menu.ID }}" method="post">
                            <div class="form-group">
                                <label class="font-bold">名称</label>
                                <div class="input-group">
                                    <span class="input-group-addon">
                                        <i class="fa fa-user-o"></i>
                                    </span>
                                    <input type="text" name="name" placeholder="请输入菜单名称" class="form-control" value="{{ .menu.Name }}">
                                </div>
                            </div>

                            <div class="form-group">
                                <label class="font-bold">标签</label>
                                <div class="input-group">
                                    <span class="input-group-addon">
                                        <i class="fa fa-tag"></i>
                                    </span>
                                    <input type="text" name="tag" placeholder="请输入标签" class="form-control" value="{{ .menu.Tag }}">
                                </div>
                            </div>


                            <div class="form-group">
                                <label class="font-bold">所属菜单</label>
                                <div class="input-group">
                                    <span class="input-group-addon">
                                        <i class="fa fa-th-list"></i>
                                    </span>
                                    <select class="form-control" name="parent">
                                        <option value="0">设为主菜单</option>
                                        {{$parent := .menu.Parent}}
                                        {{range .menus}}
                                            <option value="{{.ID}}" {{if eq .ID $parent}}selected{{end}}>{{.Space}}{{.Name}}</option>
                                        {{end}}
                                    </select>
                                </div>
                            </div>

                            <div class="form-group">
                                <label class="font-bold">审核</label>
                                <div class="radio radio-primary">
                                    <input type="radio" name="audit" id="audit1" value="1" {{if eq .menu.Audit 1}}checked{{end}}>
                                    <label for="audit1">
                                        已审核
                                    </label>
                                </div>
                                <div class="radio radio-primary">
                                    <input type="radio" name="audit" id="audit2" value="0" {{if eq .menu.Audit 0}}checked{{end}}>
                                    <label for="audit2">
                                        未审核
                                    </label>
                                </div>
                            </div>

                            <div class="form-group">
                                <label class="font-bold">排序</label>
                                <div class="input-group">
                                    <span class="input-group-addon">
                                        <i class="fa fa-sort-amount-desc"></i>
                                    </span>
                                    <input type="text" name="sort" placeholder="" class="form-control" value="{{ .menu.Sort }}">
                                </div>
                            </div>

                            <div class="form-group">
                                <label class="font-bold">SEO Title</label>
                                <div class="input-group">
                                    <span class="input-group-addon">
                                        <i class="fa fa-header"></i>
                                    </span>
                                    <input type="text" name="seo_title" placeholder="" class="form-control" value="{{ .menu.SeoTitle }}">
                                </div>
                            </div>

                            <div class="form-group">
                                <label class="font-bold">SEO Description</label>
                                <div class="input-group">
                                    <span class="input-group-addon">
                                        <i class="fa fa-globe"></i>
                                    </span>
                                    <input type="text" name="seo_description" placeholder="" class="form-control" value="{{ .menu.SeoDescription }}">
                                </div>
                            </div>

                            <div class="form-group">
                                <label class="font-bold">SEO Keyword</label>
                                <div class="input-group">
                                    <span class="input-group-addon">
                                        <i class="fa fa-key"></i>
                                    </span>
                                    <input type="text" name="seo_keyword" placeholder="" class="form-control" value="{{ .menu.SeoKeyword }}">
                                </div>
                            </div>

                            <div>
                                <button class="btn btn-sm btn-primary" type="submit"> <i class="fa fa-paper-plane"></i> 保存</button>
                            </div>
                        </form>
                    </div>
                </div>
            </div>
        </div>
    </div>
{{ end }}

{{ define "js" }}
    <script src="/public/inspinia/js/plugins/validate/jquery.validate.min.js"></script>
    <script src="/public/inspinia/js/plugins/validate/localization/messages_zh.js"></script>
    <script type="text/javascript">
        $().ready(function() {
            $("#menu-form").validate({
                rules: {
                    name: "required",
                    parent: "required",
                    sort:{
                        digits:true
                    }
                },
                messages: {
                    name: "请输入菜单名称",
                    parent:"请选择所属菜单",
                    sort: {
                        digits: "排序值无效",
                    }
                }
            })
        });
    </script>
{{ end }}