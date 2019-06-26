{{ define "auth/register" }}
<!DOCTYPE html>
<html>

    <head>

        <meta charset="utf-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">

        <title>GinBlog后台 | Register</title>

        <link href="/public/inspinia/css/bootstrap.min.css" rel="stylesheet">
        <link href="/public/inspinia/font-awesome/css/font-awesome.css" rel="stylesheet">
        <link href="/public/inspinia/css/plugins/iCheck/custom.css" rel="stylesheet">
        <link href="/public/inspinia/css/animate.css" rel="stylesheet">
        <link href="/public/inspinia/css/style.css" rel="stylesheet">

    </head>

    <body class="gray-bg">

    <div class="middle-box text-center loginscreen   animated fadeInDown">
        <div>
            <div>

                <h1 class="logo-name">GIN</h1>

            </div>
            <h3>Register to GIN</h3>
            <p>Create account to see it in action.</p>
            <form class="m-t" role="form" action="/sign-up">
                <div class="form-group">
                    <input type="text" class="form-control" placeholder="手机号码" required="">
                </div>
                <div class="form-group">
                    <input type="email" class="form-control" placeholder="邮箱" required="">
                </div>
                <div class="form-group">
                    <input type="password" class="form-control" placeholder="密码" required="">
                </div>
                <div class="form-group">
                    <div class="checkbox i-checks"><label> <input type="checkbox"><i></i> <span style="position: relative;top:2px">同意隐私政策 </span></label></div>
                </div>
                <button type="submit" class="btn btn-primary block full-width m-b">注册</button>

                <p class="text-muted text-center"><small>已有账号?</small></p>
                <a class="btn btn-sm btn-white btn-block" href="/login">登录</a>
            </form>
            <p class="m-t"> <small>gin blog &copy; 2014</small> </p>
        </div>
    </div>

    <!-- Mainly scripts -->
    <script src="/public/inspinia/js/jquery-3.1.1.min.js"></script>
    <script src="/public/inspinia/js/bootstrap.min.js"></script>
    <!-- iCheck -->
    <script src="/public/inspinia/js/plugins/iCheck/icheck.min.js"></script>
    <script>
        $(document).ready(function(){
            $('.i-checks').iCheck({
                checkboxClass: 'icheckbox_square-green',
                radioClass: 'iradio_square-green',
            });
        });
    </script>
    </body>

</html>
{{ end }}