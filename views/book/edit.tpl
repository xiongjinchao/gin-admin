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
                    <i class="fal fa-cogs"></i> 系统设置
                </li>
                <li class="breadcrumb-item active">
                    <strong><i class="fal fa-books"></i> 书籍管理</strong>
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
                        <form id="book-form" role="form" action="/admin/book/update/{{ .book.ID }}" method="post">
                            <div class="form-group">
                                <label class="font-bold">名称</label>
                                <div class="input-group">
                                    <span class="input-group-addon">
                                        <i class="fal fa-heading"></i>
                                    </span>
                                    <input type="text" name="name" placeholder="请输入书籍名称" class="form-control" value="{{ .book.Name }}">
                                </div>
                            </div>

                            <div class="form-group">
                                <label class="font-bold">标签</label>
                                <div class="input-group">
                                    <span class="input-group-addon">
                                        <i class="fal fa-tag"></i>
                                    </span>
                                    <input type="text" name="tag" placeholder="请输入标签" class="form-control" value="{{ .book.Tag }}">
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
                                        {{$CategoryID := .book.CategoryID}}
                                        {{range .bookCategories}}
                                            <option value="{{.ID}}" {{if eq .ID $CategoryID}}selected{{end}}>{{.Space}}{{.Name}}</option>
                                        {{end}}
                                    </select>
                                </div>
                            </div>

                            <div class="form-group">
                                <label class="font-bold">目录</label>
                                <div id="content">
                                    <textarea style="display:none" name="catalogue" placeholder="" class="form-control" rows="12">{{ .book.Catalogue }}</textarea>
                                </div>
                            </div>

                            <div class="form-group">
                                <label class="font-bold">概要</label>
                                <div class="input-group">
                                    <span class="input-group-addon" style="padding-top:28px;">
                                        <i class="fal fa-text-width"></i>
                                    </span>
                                    <textarea name="summary" rows="3" class="form-control">{{ .book.Summary }}</textarea>
                                </div>
                            </div>

                            <div class="form-group">
                                <label class="font-bold">封面</label>
                                <input id="file" type="file" name="file" accept="image/*"
                                       data-category="book"
                                       data-initial-preview='{{.initialPreview}}'
                                       data-initial-preview-config='{{.initialPreviewConfig}}'>
                                <input id="cover" type="hidden" name="cover" value="{{ .book.Cover }}">
                            </div>

                            <div class="form-group">
                                <label class="font-bold">标签</label>
                                <div class="input-group">
                                    <span class="input-group-addon">
                                        <i class="fal fa-tags"></i>
                                    </span>
                                    <input id="tags" type="text" name="tags" placeholder="回车添加标签" class="form-control" value="{{.tags}}">
                                </div>
                            </div>

                            <div class="form-group">
                                <label class="font-bold">点击量</label>
                                <div class="input-group">
                                    <span class="input-group-addon">
                                        <i class="fal fa-hand-point-up"></i>
                                    </span>
                                    <input type="text" name="hit" placeholder="" class="form-control" value="{{ .book.Hit }}">
                                </div>
                            </div>

                            <div class="form-group">
                                <label class="font-bold">喜欢量</label>
                                <div class="input-group">
                                    <span class="input-group-addon">
                                        <i class="fal fa-heart"></i>
                                    </span>
                                    <input type="text" name="favorite" placeholder="" class="form-control" value="{{ .book.Favorite }}">
                                </div>
                            </div>

                            <div class="form-group">
                                <label class="font-bold">评论量</label>
                                <div class="input-group">
                                    <span class="input-group-addon">
                                        <i class="fal fa-comment"></i>
                                    </span>
                                    <input type="text" name="comment" placeholder="" class="form-control" value="{{ .book.Comment }}">
                                </div>
                            </div>

                            <div class="form-group">
                                <label class="font-bold">审核</label>
                                <div class="radio radio-primary">
                                    <input type="radio" name="audit" id="audit1" value="1" {{if eq .book.Audit 1}}checked{{end}}>
                                    <label for="audit1">
                                        已审核
                                    </label>
                                </div>
                                <div class="radio radio-primary">
                                    <input type="radio" name="audit" id="audit2" value="0" {{if eq .book.Audit 0}}checked{{end}}>
                                    <label for="audit2">
                                        未审核
                                    </label>
                                </div>
                            </div>

                            <div class="form-group">
                                <label class="font-bold">关键字</label>
                                <div class="input-group">
                                    <span class="input-group-addon">
                                        <i class="fal fa-key"></i>
                                    </span>
                                    <input type="text" name="keyword" placeholder="" class="form-control" value="{{ .book.Keyword }}">
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
    <script src="/public/plug-in/bootstrap-fileinput/js/piexif.min.js"></script>
    <script src="/public/plug-in/bootstrap-fileinput/js/sortable.min.js"></script>
    <script src="/public/plug-in/bootstrap-fileinput/js/purify.min.js"></script>
    <script src="/public/plug-in/bootstrap-fileinput/js/fileinput.min.js"></script>
    <script src="/public/plug-in/bootstrap-fileinput/js/zh.js"></script>

    <script src="/public/plug-in/validate/jquery.validate.min.js"></script>
    <script src="/public/plug-in/validate/localization/messages_zh.js"></script>

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
            imageUploadURL : "/admin/file/editor-upload?category=book-catalogue"
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

        $().ready(function() {
            $("#book-form").validate({
                rules: {
                    name: "required",
                },
                messages: {
                    name: "请输入书籍名称",
                }
            })
        });

        $("#tags").tagsinput({
            tagClass: 'label label-primary',
            maxTags: 4,
            trimValue: true
        });
    </script>
{{ end }}