{{ define "css" }}
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
                        <form role="form" action="/admin/article/update/{{ .article.ID }}" method="post">
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
                                        {{range .articleCategory}}
                                            <option value="{{.ID}}">{{.Name}}</option>
                                        {{end}}
                                    </select>
                                </div>
                            </div>

                            <div class="form-group">
                                <label class="font-bold">内容</label>
                                <div class="input-group">
                                    <textarea name="content" placeholder="" class="form-control" rows="6">{{ .article.Content }}</textarea>
                                </div>
                            </div>

                            <div class="form-group">
                                <label class="font-bold">审核</label>
                                <div class="input-group">
                                    <span class="input-group-addon">
                                        <i class="fa fa-check"></i>
                                    </span>
                                    <input type="text" name="audit" placeholder="" class="form-control" value="{{ .article.Audit }}">
                                </div>
                            </div>

                            <div class="form-group">
                                <label class="font-bold">热门</label>
                                <div class="input-group">
                                    <span class="input-group-addon">
                                        <i class="fa fa-fire"></i>
                                    </span>
                                    <input type="text" name="hot" placeholder="" class="form-control" value="{{ .article.Hot }}">
                                </div>
                            </div>

                            <div class="form-group">
                                <label class="font-bold">推荐</label>
                                <div class="input-group">
                                    <span class="input-group-addon">
                                        <i class="fa fa-star-o"></i>
                                    </span>
                                    <input type="text" name="recommend" placeholder="" class="form-control" value="{{ .article.Recommend }}">
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
                                        <option>请选择</option>
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
{{ end }}