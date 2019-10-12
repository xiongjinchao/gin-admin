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
                <p>
                    <a class="btn btn-outline btn-success" href="/admin/article/edit/{{ .article.ID }}"><i class="fa fa-edit"></i> 更新</a>
                    <a class="btn btn-outline btn-danger" href="/admin/article/delete/{{ .article.ID }}"><i class="fa fa-trash"></i> 删除</a>
                </p>
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
                        <table id="w0" class="table table-striped table-bordered detail-view">
                            <tbody>
                                <tr>
                                    <th>文章编号</th><td>{{ .article.ID }}</td>
                                </tr>
                                <tr>
                                    <th>标题</th><td>{{ .article.Title }}</td>
                                </tr>
                                <tr>
                                    <th>封面</th><td>{{ .article.Cover }}</td>
                                </tr>
                                <tr>
                                    <th>文章分类</th><td>{{ .article.CategoryID }}</td>
                                </tr>
                                <tr>
                                    <th>概要</th><td>{{ .article.Summary }}</td>
                                </tr>
                                <tr>
                                    <th>内容</th><td>{{ .article.Content }}</td>
                                </tr>
                                <tr>
                                    <th>审核</th><td>{{ .article.Audit }}</td>
                                </tr>
                                <tr>
                                    <th>热门</th><td>{{ .article.Hot }}</td>
                                </tr>
                                <tr>
                                    <th>推荐</th><td>{{ .article.Recommend }}</td>
                                </tr>
                                <tr>
                                    <th>点击量</th><td>{{ .article.Hit }}</td>
                                </tr>
                                <tr>
                                    <th>喜欢量</th><td>{{ .article.Favorite }}</td>
                                </tr>
                                <tr>
                                    <th>评论量</th><td>{{ .article.Comment }}</td>
                                </tr>
                                <tr>
                                    <th>用户编号</th><td>{{ .article.UserID }}</td>
                                </tr>
                                <tr>
                                    <th>作者</th><td>{{ .article.Author }}</td>
                                </tr>
                                <tr>
                                    <th>来源</th><td>{{ .article.Source }}</td>
                                </tr>
                                <tr>
                                    <th>来源地址</th><td>{{ .article.SourceUrl }}</td>
                                </tr>
                                <tr>
                                    <th>关键字</th><td>{{ .article.Keyword }}</td>
                                </tr>
                                <tr>
                                    <th>创建时间</th><td>{{ .article.CreatedAt.Format "2006-01-02 15:04:05" }}</td>
                                </tr>
                                <tr>
                                    <th>更新时间</th><td>{{ .article.UpdatedAt.Format "2006-01-02 15:04:05" }}</td>
                                </tr>
                            </tbody>
                        </table>
                    </div>
                </div>
            </div>
        </div>
    </div>
{{ end }}

{{ define "js" }}
{{ end }}