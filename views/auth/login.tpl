{{ define "auth/login" }}
<!DOCTYPE html>
<html>

    <head>

        <meta charset="utf-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">

        <title>INSPINIA | Login</title>

        <link href="/public/inspinia/css/bootstrap.min.css" rel="stylesheet">
        <link href="/public/inspinia/font-awesome/css/font-awesome.css" rel="stylesheet">

        <link href="/public/inspinia/css/animate.css" rel="stylesheet">
        <link href="/public/inspinia/css/style.css" rel="stylesheet">

    </head>

    <body class="gray-bg">

    <div class="middle-box text-center loginscreen animated fadeInDown">
        <div>
            <div>

                <h1 class="logo-name">IN+</h1>

            </div>
            <h3>Welcome to IN+</h3>
            <p>Login in. To see it in action.</p>
            <form class="m-t" role="form" action="/sign-in" method="post">
                {{if .flash}}
                    <div class="alert alert-danger text-left">
                        {{ range $f := .flash }}
                            <li class="danger-element">{{ $f }}</li>
                        {{ end }}
                    </div>
                {{end}}
                <div class="form-group">
                    <input type="text" class="form-control" name="mobile" required="" placeholder="手机号">
                </div>
                <div class="form-group">
                    <input type="password" class="form-control" name="password" required="" placeholder="密码">
                </div>
                <button type="submit" class="btn btn-primary block full-width m-b">登录</button>

                <a href="/forgot-password"><small>忘记密码?</small></a>
                <p class="text-muted text-center"><small>没有账号?</small></p>
                <a class="btn btn-sm btn-white btn-block" href="/register">创建一个新账号</a>
            </form>
            <p class="m-t"> <small>Inspinia we app framework base on Bootstrap 3 &copy; 2014</small> </p>
        </div>
    </div>

    <!-- Mainly scripts -->
    <script src="/public/inspinia/js/jquery-3.1.1.min.js"></script>
    <script src="/public/inspinia/js/bootstrap.min.js"></script>

    </body>

</html>
{{ end }}