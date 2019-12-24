{{ define "sidebar" }}
    <nav class="navbar-default navbar-static-side" role="navigation">
        <div class="sidebar-collapse">
            <ul class="nav metismenu" id="side-menu">
                <li class="nav-header">
                    <div class="dropdown profile-element text-center">
                        <img alt="image" class="rounded-circle" src="/public/plug-in/inspinia/img/profile_small.jpg" />
                        <a data-toggle="dropdown" class="dropdown-toggle" href="#">
                            <span class="block m-t-xs font-bold">Gin Blog管理员</span>
                            <span class="text-muted text-xs block">管理员 <b class="caret"></b></span>
                        </a>
                        <ul class="dropdown-menu animated fadeInRight m-t-xs">
                            <li><a class="dropdown-item" href="profile.html">Profile</a></li>
                            <li><a class="dropdown-item" href="contacts.html">Contacts</a></li>
                            <li><a class="dropdown-item" href="mailbox.html">Mailbox</a></li>
                            <li class="dropdown-divider"></li>
                            <li><a class="dropdown-item" href="login.html">Logout</a></li>
                        </ul>
                    </div>
                    <div class="logo-element">
                        GIN
                    </div>
                </li>
                <li>
                    <a href="/admin/dashboard"><i class="fal fa-desktop fa-fw"></i> <span class="nav-label">系统面板</span></a>
                </li>
                <li>
                    <a href="#"><i class="fal fa-th-large fa-fw"></i> <span class="nav-label">基础数据</span><span class="fa arrow"></span></a>
                    <ul class="nav nav-second-level collapse">
                        <li><a href="/admin/menu"><i class="fal fa-star-of-david text-danger fa-fw"></i> 菜单管理</a></li>
                        <li><a href="/admin/book"><i class="fal fa-books text-success fa-fw"></i> 书籍管理</a></li>
                        <li><a href="/admin/book-chapter"><i class="fal fa-bookmark text-success fa-fw"></i> 书籍章节</a></li>
                        <li><a href="/admin/book-category"><i class="fal fa-list-ul text-success fa-fw"></i> 书籍分类</a></li>
                        <li><a href="/admin/article"><i class="fal fa-file-word text-info fa-fw"></i> 文章管理</a></li>
                        <li><a href="/admin/article-category"><i class="fal fa-list-ul text-info fa-fw"></i> 文章分类</a></li>
                    </ul>
                </li>
                <li>
                    <a href="/admin/collect"><i class="fal fa-tools text-warning fa-fw"></i> <span class="nav-label">采集工具</span></a>
                </li>
                <li>
                    <a href="#"><i class="fal fa-cubes fa-fw"></i> <span class="nav-label">其他</span><span class="fa arrow"></span></a>
                    <ul class="nav nav-second-level collapse">
                        <li><a href="/admin/comment"><i class="fal fa-comments text-success fa-fw"></i> 评论管理</a></li>
                        <li><a href="/admin/tag-model"><i class="fal fa-tags text-success fa-fw"></i> 标签管理</a></li>
                        <li><a href="/admin/friend-link"><i class="fal fa-link text-success fa-fw"></i> 友情链接</a></li>
                        <li><a href="/admin/friend-link-category"><i class="fal fa-list-ul text-success fa-fw"></i> 链接分类</a></li>
                        <li><a href="/admin/action-log"><i class="fal fa-cabinet-filing text-success fa-fw"></i> 操作记录</a></li>
                    </ul>
                </li>
                <li>
                    <a href="#"><i class="fal fa-cogs fa-fw"></i> <span class="nav-label">系统设置</span><span class="fa arrow"></span></a>
                    <ul class="nav nav-second-level collapse">
                        <li><a href="/admin/admin"><i class="fal fa-user-tie text-warning fa-fw"></i> 管理员</a></li>
                        <li><a href="/admin/user"><i class="fal fa-user text-warning fa-fw"></i> 用户管理</a></li>
                        <li><a href="/admin/policy"><i class="fal fa-user-cog text-warning fa-fw"></i> 角色权限</a></li>
                    </ul>
                </li>
                <li>
                    <a href="/logout"><i class="fal fa-power-off text-danger fa-fw"></i> <span class="nav-label">退出登录 </span></a>
                </li>
                <li class="landing_link">
                    <a target="_blank" href="https://github.com/xiongjinchao/gin"><i class="fal fa-star-of-david fa-fw"></i> <span class="nav-label">GitHub</span> <span class="label label-warning pull-right">HOT</span></a>
                </li>
                <li class="special_link">
                    <a href="/admin/database"><i class="fal fa-database fa-fw"></i> <span class="nav-label">数据库</span></a>
                </li>
            </ul>
        </div>
    </nav>
{{ end }}