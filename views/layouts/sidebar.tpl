{{ define "sidebar" }}
    <nav class="navbar-default navbar-static-side" role="navigation">
        <div class="sidebar-collapse">
            <ul class="nav metismenu" id="side-menu">
                <li class="nav-header">
                    <div class="dropdown profile-element text-center">
                        <img alt="image" class="rounded-circle" src="/public/inspinia/img/profile_small.jpg" />
                        <a data-toggle="dropdown" class="dropdown-toggle" href="#">
                            <span class="block m-t-xs font-bold">David Williams</span>
                            <span class="text-muted text-xs block">Art Director <b class="caret"></b></span>
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
                    <a href="/admin/dashboard"><i class="fa fa-desktop"></i> <span class="nav-label">系统面板</span></a>
                </li>
                <li>
                    <a href="#"><i class="fa fa-th-large"></i> <span class="nav-label">内容管理</span><span class="fa arrow"></span></a>
                    <ul class="nav nav-second-level collapse">
                        <li><a href="/admin/menu"><i class="fa fa-star text-info"></i> 菜单管理</a></li>
                        <li><a href="/admin/article"><i class="fa fa-file-text-o text-info"></i> 文章管理</a></li>
                        <li><a href="/admin/article-category"><i class="fa fa-th-list text-info"></i> 文章分类</a></li>
                        <li><a href="/admin/friend-link"><i class="fa fa-link text-info"></i> 友情链接</a></li>
                    </ul>
                </li>
                <li>
                    <a href="#"><i class="fa fa-gears"></i> <span class="nav-label">系统设置</span><span class="fa arrow"></span></a>
                    <ul class="nav nav-second-level collapse">
                        <li><a href="/admin/admin"><i class="fa fa-github-alt text-warning"></i> 管理员</a></li>
                        <li><a href="/admin/user"><i class="fa fa-user-o text-warning"></i> 用户管理</a></li>
                        <li><a href="/admin/role"><i class="fa fa-graduation-cap text-warning"></i> 角色管理</a></li>
                    </ul>
                </li>
                <li>
                    <a href="/logout"><i class="fa fa-power-off text-danger"></i> <span class="nav-label">退出登录 </span></a>
                </li>
                <li class="landing_link">
                    <a target="_blank" href="https://github.com/xiongjinchao/gin"><i class="fa fa-star"></i> <span class="nav-label">GitHub</span> <span class="label label-warning pull-right">HOT</span></a>
                </li>
                <li class="special_link">
                    <a href="/admin/database"><i class="fa fa-database"></i> <span class="nav-label">数据库</span></a>
                </li>
            </ul>
        </div>
    </nav>
{{ end }}