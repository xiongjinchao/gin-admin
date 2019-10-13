{{ define "css" }}
    <link href="/public/plug-in/awesome-bootstrap-checkbox/awesome-bootstrap-checkbox.css" rel="stylesheet">
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
                    <i class="fal fa-cubes"></i> 其他
                </li>
                <li class="breadcrumb-item active">
                    <strong><i class="fal fa-list-ul"></i> 链接分类</strong>
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
                        <form id="friend-link-category-form" role="form" action="/admin/friend-link-category/update/{{ .friendLinkCategory.ID }}" method="post">
                            <div class="form-group">
                                <label class="font-bold">名称</label>
                                <div class="input-group">
                                    <span class="input-group-addon">
                                        <i class="fal fa-heading"></i>
                                    </span>
                                    <input type="text" name="name" placeholder="请输入分类名称" class="form-control" value="{{ .friendLinkCategory.Name }}">
                                </div>
                            </div>

                            <div class="form-group">
                                <label class="font-bold">所属分类</label>
                                <div class="input-group">
                                    <span class="input-group-addon">
                                        <i class="fal fa-list-ul"></i>
                                    </span>
                                    <select class="form-control" name="parent">
                                        <option value="0">设为主分类</option>
                                        {{$parent := .friendLinkCategory.Parent}}
                                        {{range .friendLinkCategories}}
                                            <option value="{{.ID}}" {{if eq .ID $parent}}selected{{end}}>{{.Space}}{{.Name}}</option>
                                        {{end}}
                                    </select>
                                </div>
                            </div>

                            <div class="form-group">
                                <label class="font-bold">概要</label>
                                <div class="input-group">
                                    <span class="input-group-addon" style="padding-top:28px;">
                                        <i class="fal fa-text-width"></i>
                                    </span>
                                    <textarea name="summary" rows="3" class="form-control">{{ .friendLinkCategory.Summary }}</textarea>
                                </div>
                            </div>

                            <div class="form-group">
                                <label class="font-bold">审核</label>
                                <div class="radio radio-primary">
                                    <input type="radio" name="audit" id="audit1" value="1" {{if eq .friendLinkCategory.Audit 1}}checked{{end}}>
                                    <label for="audit1">
                                        已审核
                                    </label>
                                </div>
                                <div class="radio radio-primary">
                                    <input type="radio" name="audit" id="audit2" value="0" {{if eq .friendLinkCategory.Audit 0}}checked{{end}}>
                                    <label for="audit2">
                                        未审核
                                    </label>
                                </div>
                            </div>

                            <div class="form-group">
                                <label class="font-bold">排序</label>
                                <div class="input-group">
                                    <span class="input-group-addon">
                                        <i class="fal fa-sort-amount-down"></i>
                                    </span>
                                    <input type="text" name="sort" placeholder="" class="form-control" value="{{ .friendLinkCategory.Sort }}">
                                </div>
                            </div>

                            <div>
                                <button class="btn btn-sm btn-primary" type="submit"> <i class="fal fa-paper-plane"></i> 保存</button>
                            </div>
                        </form>
                    </div>
                </div>
            </div>
        </div>
    </div>
{{ end }}

{{ define "js" }}
    <script src="/public/plug-in/validate/jquery.validate.min.js"></script>
    <script src="/public/plug-in/validate/localization/messages_zh.js"></script>
    <script type="text/javascript">
        $().ready(function() {
            $("#friend-link-category-form").validate({
                rules: {
                    name: "required",
                    parent: "required",
                    sort:{
                        digits:true
                    }
                },
                messages: {
                    name: "请输入分类名称",
                    parent:"请选择所属分类",
                    sort: {
                        digits: "排序值无效",
                    }
                }
            })
        });
    </script>
{{ end }}