{{ define "css" }}
    <link href="/public/plug-in/bootstrap-fileinput/css/fileinput.min.css" rel="stylesheet">
    <link href="/public/inspinia/css/plugins/awesome-bootstrap-checkbox/awesome-bootstrap-checkbox.css" rel="stylesheet">
    <link href="/public/inspinia/css/plugins/bootstrap-markdown/bootstrap-markdown.min.css" rel="stylesheet">
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
                    <strong><i class="fa fa-user-o"></i> 文章管理</strong>
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
                        <form role="form" action="/admin/article/update/{{ .article.ID }}" method="post" enctype="multipart/form-data">
                            <input type="hidden" name="_method" value="PUT">
                            <div class="form-group">
                                <label class="font-bold">标题</label>
                                <div class="input-group">
                                    <span class="input-group-addon">
                                        <i class="fa fa-header"></i>
                                    </span>
                                    <input type="text" name="title" placeholder="请输入标题" class="form-control" value="{{ .article.Title }}">
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
                                        {{$CategoryID := .article.CategoryID}}
                                        {{range .articleCategories}}
                                            <option value="{{.Base.id}}" {{if eq .Base.id $CategoryID}}selected{{end}}>{{.space}}{{.name}}</option>
                                        {{end}}
                                    </select>
                                </div>
                            </div>

                            <div class="form-group">
                                <label class="font-bold">封面</label>
                                <input id="file" type="file" name="file" accept="image/*"
                                       data-category="article"
                                       data-initial-preview='{{.initialPreview}}'
                                       data-initial-preview-config='{{.initialPreviewConfig}}'>
                                <input id="cover" type="hidden" name="cover" value="{{ .article.Cover }}">
                            </div>

                            <div class="form-group">
                                <label class="font-bold">内容</label>
                                <textarea id="content" name="content" placeholder="" class="form-control" rows="12">{{ .article.Content }}</textarea>
                            </div>

                            <div class="form-group">
                                <label class="font-bold">审核</label>
                                <div class="radio radio-primary">
                                    <input type="radio" name="audit" id="audit1" value="1" {{if eq .article.Audit 1}}checked{{end}}>
                                    <label for="audit1">
                                        已审核
                                    </label>
                                </div>
                                <div class="radio radio-primary">
                                    <input type="radio" name="audit" id="audit2" value="0" {{if eq .article.Audit 0}}checked{{end}}>
                                    <label for="audit2">
                                        未审核
                                    </label>
                                </div>
                            </div>

                            <div class="form-group">
                                <label class="font-bold">热门</label>
                                <div class="radio radio-danger">
                                    <input type="radio" name="hot" id="hot1" value="1" {{if eq .article.Hot 1}}checked{{end}}>
                                    <label for="hot1">
                                        已设为热门
                                    </label>
                                </div>
                                <div class="radio radio-danger">
                                    <input type="radio" name="hot" id="hot2" value="0" {{if eq .article.Hot 0}}checked{{end}}>
                                    <label for="hot2">
                                        未设为热门
                                    </label>
                                </div>
                            </div>

                            <div class="form-group">
                                <label class="font-bold">推荐</label>
                                <div class="radio radio-warning">
                                    <input type="radio" name="recommend" id="recommend1" value="1" {{if eq .article.Recommend 1}}checked{{end}}>
                                    <label for="recommend1">
                                        已推荐
                                    </label>
                                </div>
                                <div class="radio radio-warning">
                                    <input type="radio" name="recommend" id="recommend2" value="0" {{if eq .article.Recommend 0}}checked{{end}}>
                                    <label for="recommend2">
                                        未推荐
                                    </label>
                                </div>
                            </div>

                            <div class="form-group">
                                <label class="font-bold">点击量</label>
                                <div class="input-group">
                                    <span class="input-group-addon">
                                        <i class="fa fa-hand-o-up"></i>
                                    </span>
                                    <input type="text" name="hit" placeholder="" class="form-control" value="{{ .article.Hit }}">
                                </div>
                            </div>

                            <div class="form-group">
                                <label class="font-bold">所属用户</label>
                                <div class="input-group">
                                    <span class="input-group-addon">
                                        <i class="fa fa-th-list"></i>
                                    </span>
                                    <select class="form-control" name="user_id">
                                        <option value="0">请选择</option>
                                        {{$UserID := .article.UserID}}
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
                                        <i class="fa fa-user-o"></i>
                                    </span>
                                    <input type="text" name="author" placeholder="" class="form-control" value="{{ .article.Author }}">
                                </div>
                            </div>

                            <div class="form-group">
                                <label class="font-bold">来源</label>
                                <div class="input-group">
                                    <span class="input-group-addon">
                                        <i class="fa fa-code"></i>
                                    </span>
                                    <input type="text" name="source" placeholder="" class="form-control" value="{{ .article.Source }}">
                                </div>
                            </div>

                            <div class="form-group">
                                <label class="font-bold">来源地址</label>
                                <div class="input-group">
                                    <span class="input-group-addon">
                                        <i class="fa fa-link"></i>
                                    </span>
                                    <input type="text" name="source_url" placeholder="" class="form-control" value="{{ .article.SourceUrl }}">
                                </div>
                            </div>

                            <div class="form-group">
                                <label class="font-bold">SEO Title</label>
                                <div class="input-group">
                                    <span class="input-group-addon">
                                        <i class="fa fa-header"></i>
                                    </span>
                                    <input type="text" name="seo_title" placeholder="" class="form-control" value="{{ .article.SeoTitle }}">
                                </div>
                            </div>

                            <div class="form-group">
                                <label class="font-bold">SEO Description</label>
                                <div class="input-group">
                                    <span class="input-group-addon">
                                        <i class="fa fa-globe"></i>
                                    </span>
                                    <input type="text" name="seo_description" placeholder="" class="form-control" value="{{ .article.SeoDescription }}">
                                </div>
                            </div>

                            <div class="form-group">
                                <label class="font-bold">SEO Keyword</label>
                                <div class="input-group">
                                    <span class="input-group-addon">
                                        <i class="fa fa-key"></i>
                                    </span>
                                    <input type="text" name="seo_keyword" placeholder="" class="form-control" value="{{ .article.SeoKeyword }}">
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
    <script src="/public/plug-in/bootstrap-fileinput/js/piexif.min.js"></script>
    <script src="/public/plug-in/bootstrap-fileinput/js/sortable.min.js"></script>
    <script src="/public/plug-in/bootstrap-fileinput/js/purify.min.js"></script>
    <script src="/public/plug-in/bootstrap-fileinput/js/fileinput.min.js"></script>
    <script src="/public/plug-in/bootstrap-fileinput/js/zh.js"></script>

    <script src="/public/inspinia/js/plugins/bootstrap-markdown/bootstrap-markdown.js"></script>
    <script src="/public/inspinia/js/plugins/bootstrap-markdown/markdown.js"></script>
    <script src="/public/inspinia/js/plugins/bootstrap-markdown/bootstrap-markdown.zh.js"></script>

    <script type="text/javascript">
        $("#content").markdown({language:'zh'});
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
    </script>
{{ end }}