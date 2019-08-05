{{ define "auth/login" }}
<!DOCTYPE html>
<html>

    <head>

        <meta charset="utf-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">

        <title>GinBlog后台 | Login</title>

        <link href="/public/inspinia/css/bootstrap.min.css" rel="stylesheet">
        <link href="/public/inspinia/font-awesome/css/font-awesome.css" rel="stylesheet">

        <link href="/public/inspinia/css/animate.css" rel="stylesheet">
        <link href="/public/inspinia/css/style.css" rel="stylesheet">

    </head>

    <body class="gray-bg">

    <div class="middle-box text-center loginscreen animated fadeInDown">
        <div>
            <div>

                <h1 class="logo-name">GIN</h1>

            </div>
            <h3>Welcome to gin blog</h3>
            <p>Login in. To see it in action.</p>
            <form id="login-form" role="form" class="m-t" action="/sign-in" method="post">
                {{if .flash.error}}
                    <div class="alert alert-danger text-left">
                        {{ range .flash.error }}
                            <li class="danger-element">{{ . }}</li>
                        {{ end }}
                    </div>
                {{end}}
                <div class="form-group text-left">
                    <input type="text" class="form-control" name="mobile" placeholder="手机号">
                </div>
                <div class="form-group text-left">
                    <input type="password" class="form-control" name="password" placeholder="密码">
                </div>
                <button type="submit" class="btn btn-primary block full-width m-b">登录</button>

                <a href="/forgot-password"><small>忘记密码?</small></a>
                <p class="text-muted text-center"><small>没有账号?</small></p>
                <a class="btn btn-sm btn-white btn-block" href="/register">创建一个新账号</a>
            </form>
            <p class="m-t"> <small>gin blog &copy; 2019</small> </p>
        </div>
    </div>

    <!-- Mainly scripts -->
    <script src="/public/inspinia/js/jquery-3.1.1.min.js"></script>
    <script src="/public/inspinia/js/bootstrap.min.js"></script>
    <script src="/public/inspinia/js/plugins/validate/jquery.validate.min.js"></script>
    <script src="/public/inspinia/js/plugins/validate/localization/messages_zh.js"></script>

    <script type="text/javascript">
        $().ready(function() {
            $("#login-form").validate({
                rules: {
                    mobile: "required",
                    password: {
                        required: true,
                        minlength: 6,
                        maxlength: 16
                    }
                },
                messages: {
                    mobile: "请输入您的手机号码",
                    password: {
                        required: "请输入密码",
                        minlength: "密码长度不能小于 6 个字母",
                        maxlength: "密码长度不能大于 16 个字母"
                    }
                }
            })
        });
    </script>

    </body>

</html>
{{ end }}