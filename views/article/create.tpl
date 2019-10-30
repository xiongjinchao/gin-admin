{{ define "css" }}
    <link href="/public/plug-in/bootstrap-fileinput/css/fileinput.min.css" rel="stylesheet">
    <link href="/public/plug-in/awesome-bootstrap-checkbox/awesome-bootstrap-checkbox.css" rel="stylesheet">
    <link href="/public/plug-in/editor-md/css/editormd.css" rel="stylesheet">
    <link href="/public/plug-in/bootstrap-tagsinput/bootstrap-tagsinput.css" rel="stylesheet">
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
                    <strong><i class="fal fa-file-word"></i> 文章管理</strong>
                </li>
            </ol>
        </div>
        <div class="col-lg-2">

        </div>
    </div>

    {{/*content*/}}
    <div class="wrapper wrapper-content animated fadeInRight">
        <div class="row">
            <div class="col-lg-10">
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
                        <form role="form" action="/admin/article" method="post" enctype="multipart/form-data">
                            <input type="hidden" name="_method" value="PUT">
                            <div class="form-group">
                                <label class="font-bold">标题</label>
                                <div class="input-group">
                                    <span class="input-group-addon">
                                        <i class="fal fa-heading"></i>
                                    </span>
                                    <input type="text" name="title" placeholder="请输入标题" class="form-control" value="{{ .flash.old.title }}">
                                </div>
                            </div>

                            <div class="form-group">
                                <label class="font-bold">所属分类</label>
                                <div class="input-group">
                                    <span class="input-group-addon">
                                        <i class="fal fa-list-ul"></i>
                                    </span>
                                    <select class="form-control" name="category_id">
                                        <option value="0">请选择</option>
                                        {{$CategoryID := Interface2Int64 .flash.old.category_id}}
                                        {{range .articleCategories}}
                                            <option value="{{.ID}}" {{if eq .ID $CategoryID}}selected{{end}}>{{.Space}}{{.Name}}</option>
                                        {{end}}
                                    </select>
                                </div>
                            </div>

                            <div class="form-group">
                                <label class="font-bold">内容</label>
                                <div id="content">
                                    <textarea style="display:none" name="content" placeholder="" class="form-control" rows="12">{{ .flash.old.content }}</textarea>
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
                                <label class="font-bold">标签</label>
                                <div class="input-group">
                                    <span class="input-group-addon">
                                        <i class="fal fa-tags"></i>
                                    </span>
                                    <input id="tags" type="text" name="tags" placeholder="回车添加标签" class="form-control" value="">
                                </div>
                            </div>

                            <div class="form-group">
                                <label class="font-bold">封面</label>
                                <input id="file" type="file" name="file" accept="image/*"
                                       data-category="article"
                                       data-initial-preview=''
                                       data-initial-preview-config=''>
                                <input id="cover" type="hidden" name="cover" value="">
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
                                <label class="font-bold">热门</label>
                                {{$hot := Interface2Int64 .flash.old.hot}}
                                <div class="radio radio-danger">
                                    <input type="radio" name="hot" id="hot1" value="1" {{if eq $hot 1}}checked{{end}}>
                                    <label for="hot1">
                                        已设为热门
                                    </label>
                                </div>
                                <div class="radio radio-danger">
                                    <input type="radio" name="hot" id="hot2" value="0" {{if eq $hot 0}}checked{{end}}>
                                    <label for="hot2">
                                        未设为热门
                                    </label>
                                </div>
                            </div>

                            <div class="form-group">
                                <label class="font-bold">推荐</label>
                                {{$recommend := Interface2Int64 .flash.old.recommend}}
                                <div class="radio radio-warning">
                                    <input type="radio" name="recommend" id="recommend1" value="1" {{if eq $recommend 1}}checked{{end}}>
                                    <label for="recommend1">
                                        已推荐
                                    </label>
                                </div>
                                <div class="radio radio-warning">
                                    <input type="radio" name="recommend" id="recommend2" value="0" {{if eq $recommend 0}}checked{{end}}>
                                    <label for="recommend2">
                                        未推荐
                                    </label>
                                </div>
                            </div>

                            <div class="form-group">
                                <label class="font-bold">点击量</label>
                                <div class="input-group">
                                    <span class="input-group-addon">
                                        <i class="fal fa-hand-point-up"></i>
                                    </span>
                                    <input type="text" name="hit" placeholder="" class="form-control" value="{{ .flash.old.hit }}">
                                </div>
                            </div>

                            <div class="form-group">
                                <label class="font-bold">喜欢量</label>
                                <div class="input-group">
                                    <span class="input-group-addon">
                                        <i class="fal fa-heart"></i>
                                    </span>
                                    <input type="text" name="favorite" placeholder="" class="form-control" value="{{ .flash.old.favorite }}">
                                </div>
                            </div>

                            <div class="form-group">
                                <label class="font-bold">评论量</label>
                                <div class="input-group">
                                    <span class="input-group-addon">
                                        <i class="fal fa-comment"></i>
                                    </span>
                                    <input type="text" name="comment" placeholder="" class="form-control" value="{{ .flash.old.comment }}">
                                </div>
                            </div>

                            <div class="form-group">
                                <label class="font-bold">所属用户</label>
                                <div class="input-group">
                                    <span class="input-group-addon">
                                        <i class="fal fa-list-ul"></i>
                                    </span>
                                    <select class="form-control" name="user_id">
                                        <option value="0">请选择</option>
                                        {{$UserID := Interface2Int64 .flash.old.user_id}}
                                        {{range .user}}
                                            <option value="{{.ID}}" {{if eq .ID $UserID}}selected{{end}}>{{.Name}}</option>
                                        {{end}}
                                    </select>
                                </div>
                            </div>

                            <div class="form-group">
                                <label class="font-bold">作者</label>
                                <div class="input-group">
                                    <span class="input-group-addon">
                                        <i class="fal fa-user"></i>
                                    </span>
                                    <input type="text" name="author" placeholder="" class="form-control" value="{{ .flash.old.author }}">
                                </div>
                            </div>

                            <div class="form-group">
                                <label class="font-bold">来源</label>
                                <div class="input-group">
                                    <span class="input-group-addon">
                                        <i class="fal fa-code"></i>
                                    </span>
                                    <input type="text" name="source" placeholder="" class="form-control" value="{{ .flash.old.source }}">
                                </div>
                            </div>

                            <div class="form-group">
                                <label class="font-bold">来源地址</label>
                                <div class="input-group">
                                    <span class="input-group-addon">
                                        <i class="fal fa-link"></i>
                                    </span>
                                    <input type="text" name="source_url" placeholder="" class="form-control" value="{{ .flash.old.source_url }}">
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
                                <button class="btn btn-sm btn-primary" type="button" onclick=form.submit()> <i class="fal fa-paper-plane"></i> 保存</button>
                            </div>
                        </form>
                    </div>
                </div>
            </div>
        </div>
    </div>
{{ end }}

{{ define "js" }}
    <script src="/public/plug-in/bootstrap-fileinput/js/piexif.min.js"></script>
    <script src="/public/plug-in/bootstrap-fileinput/js/sortable.min.js"></script>
    <script src="/public/plug-in/bootstrap-fileinput/js/purify.min.js"></script>
    <script src="/public/plug-in/bootstrap-fileinput/js/fileinput.min.js"></script>
    <script src="/public/plug-in/bootstrap-fileinput/js/zh.js"></script>

    <script src="/public/plug-in/editor-md/editormd.min.js"></script>
    <script src="/public/plug-in/bootstrap-tagsinput/bootstrap-tagsinput.js"></script>

    <script type="text/javascript">
        let editor = editormd("content", {
            width:"100%",
            height:"500",
            theme : "dark",
            previewTheme : "dark",
            editorTheme : "pastel-on-dark",
            codeFold : true,
            htmlDecode : true,
            tex : true,
            taskList : true,
            emoji : true,
            flowChart : true,
            sequenceDiagram : true,
            path:"/public/plug-in/editor-md/lib/",
            autoFocus:false,
            placeholder:"",
            imageUpload : true,
            imageFormats : ["jpg", "jpeg", "gif", "png", "bmp", "webp"],
            imageUploadURL : "/admin/file/editor-upload?category=article-content"
        });

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
            deleteExtraData: {key:$("#cover").val()},
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
            $("#cover").val(0);
        }).on('fileuploaded', function(event, data, previewId, index) {
            if(data.response.status == 'success') {
                $("#" + previewId).find(".kv-file-remove:visible").attr({
                    'data-key': data.response.data.key,
                    'data-url': '/admin/file/delete',
                });
                $("#cover").val(data.response.data.key);
            }
        }).on('filesuccessremove', function (event, id) {
            $("#cover").val(0);
        }).on('filedeleted', function(event, key, jqXHR, data) {
            $("#cover").val(0);
        });

        $("#tags").tagsinput({
            tagClass: 'label label-primary',
            maxTags: 4,
            trimValue: true
        });
    </script>
{{ end }}