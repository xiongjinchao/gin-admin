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
                    <strong><i class="fal fa-comments"></i> 评论管理</strong>
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
                        <form id="comment-form" role="form" action="/admin/comment/update/{{ .comment.ID }}" method="post">
                            <div class="form-group">
                                <label class="font-bold">用户</label>
                                <div class="input-group">
                                    <span class="input-group-addon">
                                        <i class="fal fa-user"></i>
                                    </span>
                                    <input type="text" name="user_id" placeholder="请输入用户ID" class="form-control" value="{{ .comment.UserID }}">
                                </div>
                            </div>

                            <div class="form-group">
                                <label class="font-bold">模型名称</label>
                                <div class="input-group">
                                    <span class="input-group-addon">
                                        <i class="fal fa-list-ul"></i>
                                    </span>
                                    <input type="text" name="model" placeholder="" class="form-control" value="{{ .comment.Model }}">
                                </div>
                            </div>

                            <div class="form-group">
                                <label class="font-bold">模型编号</label>
                                <div class="input-group">
                                    <span class="input-group-addon">
                                        <i class="fal fa-id-card-alt"></i>
                                    </span>
                                    <input type="text" name="model_id" placeholder="" class="form-control" value="{{ .comment.ModelID }}">
                                </div>
                            </div>

                            <div class="form-group">
                                <label class="font-bold">根级</label>
                                <div class="input-group">
                                    <span class="input-group-addon">
                                        <i class="fal fa-sort-amount-down"></i>
                                    </span>
                                    <input type="text" name="root" placeholder="" class="form-control" value="{{ .comment.Root }}">
                                </div>
                            </div>

                            <div class="form-group">
                                <label class="font-bold">父级</label>
                                <div class="input-group">
                                    <span class="input-group-addon">
                                        <i class="fal fa-sort-amount-down"></i>
                                    </span>
                                    <input type="text" name="parent" placeholder="" class="form-control" value="{{ .comment.Parent }}">
                                </div>
                            </div>

                            <div class="form-group">
                                <label class="font-bold">内容</label>
                                <div class="input-group">
                                    <span class="input-group-addon" style="padding-top:28px;">
                                        <i class="fal fa-text-width"></i>
                                    </span>
                                    <textarea name="content" rows="3" class="form-control">{{ .comment.Content }}</textarea>
                                </div>
                            </div>

                            <div class="form-group">
                                <label class="font-bold">有用量</label>
                                <div class="input-group">
                                    <span class="input-group-addon">
                                        <i class="fal fa-thumbs-up"></i>
                                    </span>
                                    <input type="text" name="useful" placeholder="" class="form-control" value="{{ .comment.useful }}">
                                </div>
                            </div>

                            <div class="form-group">
                                <label class="font-bold">无用量</label>
                                <div class="input-group">
                                    <span class="input-group-addon">
                                        <i class="fal fa-thumbs-down"></i>
                                    </span>
                                    <input type="text" name="useless" placeholder="" class="form-control" value="{{ .comment.useless }}">
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
            $("#comment-form").validate({
                rules: {
                    user_id: {
                        required: true,
                        digits:true
                    },
                    model:"required",
                    model_id: {
                        required: true,
                        digits:true
                    },
                    root:{
                        required: true,
                        digits:true
                    },
                    parent:{
                        required: true,
                        digits:true
                    },
                    content:"required",
                },
                messages: {
                    user_id: {
                        required: "请输入用户ID",
                        digits: "用户ID无效"
                    },
                    model: "请输入模型名称",
                    model_id: {
                        required: "请输入模型ID",
                        digits:"模型ID无效"
                    },
                    root:{
                        required: "请输入评论根级ID",
                        digits:"根级ID无效"
                    },
                    parent:{
                        required: "请输入评论父级ID",
                        digits:"父级ID无效"
                    },
                    content:"请输入内容",
                }
            })
        });
    </script>
{{ end }}