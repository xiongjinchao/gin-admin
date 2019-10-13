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
                    <i class="fal fa-th-large"></i> 基础数据
                </li>
                <li class="breadcrumb-item active">
                    <strong><i class="fal fa-list-ul"></i> 文章分类</strong>
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
                        <form id="article-category-form" role="form" action="/admin/article-category" method="post">
                            <div class="form-group">
                                <label class="font-bold">名称</label>
                                <div class="input-group">
                                    <span class="input-group-addon">
                                        <i class="fal fa-user"></i>
                                    </span>
                                    <input type="text" name="name" placeholder="请输入分类名称" class="form-control" value="{{ .flash.old.name }}">
                                </div>
                            </div>

                            <div class="form-group">
                                <label class="font-bold">标签</label>
                                <div class="input-group">
                                    <span class="input-group-addon">
                                        <i class="fal fa-tag"></i>
                                    </span>
                                    <input type="text" name="tag" placeholder="请输入标签" class="form-control" value="{{ .flash.old.tag }}">
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
                                        {{$parent := Interface2Int64 .flash.old.parent}}
                                        {{range .articleCategories}}
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
                                    <textarea name="summary" rows="3" class="form-control">{{ .flash.old.summary }}</textarea>
                                </div>
                            </div>

                            <div class="form-group">
                                <label class="font-bold">审核</label>
                                {{$audit := Interface2Int64 .flash.old.audit}}
                                <div class="radio radio-primary">
                                    <input type="radio" name="audit" id="audit1" value="1" {{if eq $audit 1}}checked{{end}}>
                                    <label for="audit1">
                                        已审核
                                    </label>
                                </div>
                                <div class="radio radio-primary">
                                    <input type="radio" name="audit" id="audit2" value="0" {{if eq $audit 0}}checked{{end}}>
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
                                    <input type="text" name="sort" placeholder="" class="form-control" value="{{ .flash.old.sort }}">
                                </div>
                            </div>

                            <div class="form-group">
                                <label class="font-bold">关键字</label>
                                <div class="input-group">
                                    <span class="input-group-addon">
                                        <i class="fal fa-key"></i>
                                    </span>
                                    <input type="text" name="keyword" placeholder="" class="form-control" value="{{ .flash.old.keyword }}">
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
            $("#article-category-form").validate({
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