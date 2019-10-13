{{ define "css" }}
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
                <p>
                    <a class="btn btn-outline btn-success" href="/admin/article-category/edit/{{ .articleCategory.ID }}"><i class="fal fa-edit"></i> 更新</a>
                    <a class="btn btn-outline btn-danger" href="/admin/article-category/delete/{{ .articleCategory.ID }}"><i class="fal fa-trash-alt"></i> 删除</a>
                </p>
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
                        <table id="w0" class="table table-striped table-bordered detail-view">
                            <tbody>
                                <tr>
                                    <th>文章分类编号</th><td>{{ .articleCategory.ID }}</td>
                                </tr>
                                <tr>
                                    <th>名称</th><td>{{ .articleCategory.Name }}</td>
                                </tr>
                                <tr>
                                    <th>标签</th><td>{{ .articleCategory.Tag }}</td>
                                </tr>
                                <tr>
                                    <th>所属分类</th><td>{{ .articleCategory.Parent }}</td>
                                </tr>
                                <tr>
                                    <th>概要</th><td>{{ .articleCategory.Summary }}</td>
                                </tr>
                                <tr>
                                    <th>级别</th><td>{{ .articleCategory.Level }}</td>
                                </tr>
                                <tr>
                                    <th>审核</th><td>{{ .articleCategory.Audit }}</td>
                                </tr>
                                <tr>
                                    <th>排序</th><td>{{ .articleCategory.Sort }}</td>
                                </tr>
                                <tr>
                                    <th>关键字</th><td>{{ .articleCategory.Keyword }}</td>
                                </tr>
                                <tr>
                                    <th>创建时间</th><td>{{ .articleCategory.CreatedAt.Format "2006-01-02 15:04:05" }}</td>
                                </tr>
                                <tr>
                                    <th>更新时间</th><td>{{ .articleCategory.UpdatedAt.Format "2006-01-02 15:04:05" }}</td>
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