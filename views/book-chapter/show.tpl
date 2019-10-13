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
                    <<i class="fal fa-th-large"></i> 基础数据
                </li>
                <li class="breadcrumb-item active">
                    <strong><i class="fal fa-bookmark"></i> 书籍章节</strong>
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
                    <a class="btn btn-outline btn-success" href="/admin/book-chapter/edit/{{ .bookChapter.ID }}"><i class="fal fa-edit"></i> 更新</a>
                    <a class="btn btn-outline btn-danger" href="/admin/book-chapter/delete/{{ .bookChapter.ID }}"><i class="fal fa-trash-alt"></i> 删除</a>
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
                                    <th>章节编号</th><td>{{ .bookChapter.ID }}</td>
                                </tr>
                                <tr>
                                    <th>名称</th><td>{{ .bookChapter.Title }}</td>
                                </tr>
                                <tr>
                                    <th>所属文章</th><td>{{ .bookChapter.BookID }}</td>
                                </tr>
                                <tr>
                                    <th>书籍章节</th><td>{{ .bookChapter.Chapter }}</td>
                                </tr>
                                <tr>
                                    <th>审核</th><td>{{ .bookChapter.Audit }}</td>
                                </tr>
                                <tr>
                                    <th>排序</th><td>{{ .bookChapter.Sort }}</td>
                                </tr>
                                <tr>
                                    <th>点击量</th><td>{{ .bookChapter.Hit }}</td>
                                </tr>
                                <tr>
                                    <th>喜欢量</th><td>{{ .bookChapter.Favorite }}</td>
                                </tr>
                                <tr>
                                    <th>评论量</th><td>{{ .bookChapter.Comment }}</td>
                                </tr>
                                <tr>
                                    <th>创建时间</th><td>{{ .bookChapter.CreatedAt.Format "2006-01-02 15:04:05" }}</td>
                                </tr>
                                <tr>
                                    <th>更新时间</th><td>{{ .bookChapter.UpdatedAt.Format "2006-01-02 15:04:05" }}</td>
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