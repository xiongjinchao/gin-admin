{{ define "css" }}
    <link href="/public/inspinia/css/plugins/awesome-bootstrap-checkbox/awesome-bootstrap-checkbox.css" rel="stylesheet">
    <style>
        .checkbox label::before{top:1px; left:1px;}
        #policy-form .label{padding:0 8px;}
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
                        <form id="policy-form" role="form" action="/admin/policy" method="post">
                            <div class="form-group">
                                <label class="font-bold">角色名称</label>
                                <div class="input-group">
                                    <span class="input-group-addon">
                                        <i class="fa fa-user-o"></i>
                                    </span>
                                    <input type="text" name="name" placeholder="请输入角色名称" class="form-control" value="{{ .flash.old.name }}">
                                </div>
                            </div>

                            <div class="form-group">
                                <label class="font-bold full-width">选择角色 / 权限 <span class="pull-right"><span class="label label-primary">R</span> 角色 <span class="label label-warning">P</span> 权限</span></label>
                                <div class="row">
                                    {{ range $i, $v := .policy }}
                                        <div class="col-lg-3 col-md-6 py-3 policy">
                                            <div class="checkbox checkbox-primary py-2">
                                                <input type="checkbox" class="role" name="roles[]" id="{{$i}}" value="{{$i}}">
                                                <label for="{{$i}}" class="font-bold">
                                                    <span class="label label-primary">R</span> {{$i}}
                                                </label>
                                            </div>
                                            {{ range $p := $v }}
                                                <div class="checkbox checkbox-warning">
                                                    <input type="checkbox" class="permission" name="permissions[]" id="{{ Replace $p " " "_" 1 }}" value="{{$p}}">
                                                    <label for="{{ Replace $p " " "_" 1 }}">
                                                        <span class="label label-warning">P</span> {{$p}}
                                                    </label>
                                                </div>
                                            {{ end }}
                                        </div>
                                    {{ end }}
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
            $("#policy-form").validate({
                rules: {
                    name: "required",
                },
                messages: {
                    name: "请输入角色名称",
                }
            })
        });

        $("input.role").on("click",function(){
            if($(this).prop("checked")){
                $(this).closest(".policy").find(".permission").prop("checked",true);
                $(this).closest(".policy").find(".permission").attr("disabled",true);
            }else{
                $(this).closest(".policy").find(".permission").prop("checked",false);
                $(this).closest(".policy").find(".permission").removeAttr("disabled");
            }
        });

        $("input.permission").on("click",function(){
            if($(this).closest(".policy").find(".permission:checked").length == $(this).closest(".policy").find(".permission").length){
                $(this).closest(".policy").find(".role").prop("checked",true);
                $(this).closest(".policy").find(".permission").attr("disabled",true);
            }else{
                $(this).closest(".policy").find(".role").prop("checked",false);
                $(this).closest(".policy").find(".permission").removeAttr("disabled");
            }
        });

    </script>
{{ end }}