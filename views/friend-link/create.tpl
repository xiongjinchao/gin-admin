{{ define "css" }}
    <link href="/public/plug-in/bootstrap-fileinput/css/fileinput.min.css" rel="stylesheet">
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
                    <i class="fa fa-chrome"></i> 其他
                </li>
                <li class="breadcrumb-item active">
                    <strong><i class="fa fa-link"></i> 友情链接管理</strong>
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
                        <form id="friend-link-form" role="form" action="/admin/friend-link" method="post">
                            <div class="form-group">
                                <label class="font-bold">名称</label>
                                <div class="input-group">
                                    <span class="input-group-addon">
                                        <i class="fa fa-user-o"></i>
                                    </span>
                                    <input type="text" name="title" placeholder="请输入友情链接名称" class="form-control" value="{{ .flash.old.title }}">
                                </div>
                            </div>

                            <div class="form-group">
                                <label class="font-bold">所属分类</label>
                                <div class="input-group">
                                    <span class="input-group-addon">
                                        <i class="fa fa-th-list"></i>
                                    </span>
                                    <select class="form-control" name="category_id">
                                        <option value="0">请选择</option>
                                        {{$CategoryID := Interface2Int64 .flash.old.category_id}}
                                        {{range .friendLinkCategories}}
                                            <option value="{{.ID}}" {{if eq .ID $CategoryID}}selected{{end}}>{{.Space}}{{.Name}}</option>
                                        {{end}}
                                    </select>
                                </div>
                            </div>

                            <div class="form-group">
                                <label class="font-bold">链接</label>
                                <div class="input-group">
                                    <span class="input-group-addon">
                                        <i class="fa fa-link"></i>
                                    </span>
                                    <input type="text" name="link" placeholder="请输入链接" class="form-control" value="{{ .flash.old.link }}">
                                </div>
                            </div>

                            <div class="form-group">
                                <label class="font-bold">封面</label>
                                <input id="file" type="file" name="file" accept="image/*"
                                       data-category="friend_link"
                                       data-initial-preview=''
                                       data-initial-preview-config=''>
                                <input id="image" type="hidden" name="image" value="">
                            </div>

                            <div class="form-group">
                                <label class="font-bold">排序</label>
                                <div class="input-group">
                                    <span class="input-group-addon">
                                        <i class="fa fa-sort-amount-desc"></i>
                                    </span>
                                    <input type="text" name="sort" placeholder="" class="form-control" value="{{ .flash.old.sort }}">
                                </div>
                            </div>

                            <div class="form-group">
                                <label class="font-bold">开始时间</label>
                                <div class="input-group">
                                    <span class="input-group-addon">
                                        <i class="fa fa-calendar"></i>
                                    </span>
                                    <input type="text" name="start_at" placeholder="请输入开始时间" class="form-control" value="{{ .flash.old.start_at }}">
                                </div>
                            </div>

                            <div class="form-group">
                                <label class="font-bold">结束时间</label>
                                <div class="input-group">
                                    <span class="input-group-addon">
                                        <i class="fa fa-calendar"></i>
                                    </span>
                                    <input type="text" name="end_at" placeholder="请输入结束时间" class="form-control" value="{{ .flash.old.end_at }}">
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

    <script src="/public/plug-in/bootstrap-fileinput/js/piexif.min.js"></script>
    <script src="/public/plug-in/bootstrap-fileinput/js/sortable.min.js"></script>
    <script src="/public/plug-in/bootstrap-fileinput/js/purify.min.js"></script>
    <script src="/public/plug-in/bootstrap-fileinput/js/fileinput.min.js"></script>
    <script src="/public/plug-in/bootstrap-fileinput/js/zh.js"></script>

    <script type="text/javascript">
        $("#file").fileinput({
            uploadUrl: '/admin/file/upload',
            language: 'zh',
            maxFileSize: 5000,
            showRemove: false,
            showUpload: false,
            autoReplace: true,
            maxFileCount: 1,
            showClose: false,
            previewFileIcon: '<i class="glyphicon glyphicon-file"></i>',
            allowedFileExtensions: ["jpg", "png", "gif"],
            allowedFileTypes: ['image'],
            uploadExtraData: {category:$("#file").data('category')},
            deleteExtraData: {key:$("#image").val()},
            initialPreviewAsData: true,
            overwriteInitial: true,
            allowedPreviewTypes: ['image'],
            previewFileIconSettings: {
                'doc': '<i class="fas fa-file-word text-primary"></i>',
                'xls': '<i class="fas fa-file-excel text-success"></i>',
                'ppt': '<i class="fas fa-file-powerpoint text-danger"></i>',
                'jpg': '<i class="fas fa-file-image text-warning"></i>',
                'pdf': '<i class="fas fa-file-pdf text-danger"></i>',
                'zip': '<i class="fas fa-file-archive text-muted"></i>',
                'htm': '<i class="fas fa-file-code text-info"></i>',
                'txt': '<i class="fas fa-file-text text-info"></i>',
                'mov': '<i class="fas fa-file-movie-o text-warning"></i>',
                'mp3': '<i class="fas fa-file-audio text-warning"></i>',
            },
            previewFileExtSettings: {
                'doc': function(ext) {
                    return ext.match(/(doc|docx)$/i);
                },
                'xls': function(ext) {
                    return ext.match(/(xls|xlsx)$/i);
                },
                'ppt': function(ext) {
                    return ext.match(/(ppt|pptx)$/i);
                },
                'zip': function(ext) {
                    return ext.match(/(zip|rar|tar|gzip|gz|7z)$/i);
                },
                'htm': function(ext) {
                    return ext.match(/(php|js|css|htm|html)$/i);
                },
                'txt': function(ext) {
                    return ext.match(/(txt|ini|md)$/i);
                },
                'mov': function(ext) {
                    return ext.match(/(avi|mpg|mkv|mov|mp4|3gp|webm|wmv)$/i);
                },
                'mp3': function(ext) {
                    return ext.match(/(mp3|wav)$/i);
                },
            }
        }).on('filebatchselected', function(event, files) {
            $(".file-preview-success").remove();
            $("#image").val(0);
        }).on('fileuploaded', function(event, data, previewId, index) {
            if(data.response.status == 'success') {
                $("#" + previewId).find(".kv-file-remove:visible").attr({
                    'data-key': data.response.data.key,
                    'data-url': '/admin/file/delete',
                });
                $("#image").val(data.response.data.key);
            }
        }).on('filesuccessremove', function (event, id) {
            $("#image").val(0);
        }).on('filedeleted', function(event, key, jqXHR, data) {
            $("#image").val(0);
        });
        $().ready(function() {
            $("#friend-link-form").validate({
                rules: {
                    title: "required",
                    link: {
                        required: true,
                        url: true,
                    },
                    sort:{
                        digits:true
                    }
                },
                messages: {
                    title: "请输入友情链接名称",
                    link: {
                        required: "请输入链接地址",
                        url: "链接地址无效",
                    },
                    sort: {
                        digits: "排序值无效",
                    }
                }
            })
        });
    </script>
{{ end }}