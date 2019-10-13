{{ define "auth/register" }}
<!DOCTYPE html>
<html>

    <head>

        <meta charset="utf-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">

        <title>GinBlog后台 | Register</title>

        <link href="/public/css/bootstrap.min.css" rel="stylesheet">
        <link href="/public/plug-in/fontawesome/css/all.min.css" rel="stylesheet">
        <link href="/public/plug-in/iCheck/custom.css" rel="stylesheet">
        <link href="/public/plug-in/inspinia/css/animate.css" rel="stylesheet">
        <link href="/public/plug-in/inspinia/css/style.css" rel="stylesheet">

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
                <div class="form-group text-left">
                    <input type="text" name="mobile" class="form-control" placeholder="手机号码">
                </div>
                <div class="form-group text-left">
                    <input type="email" name="email" class="form-control" placeholder="邮箱">
                </div>
                <div class="form-group text-left">
                    <input type="password" name="password" class="form-control" placeholder="密码">
                </div>
                <div class="form-group text-left">
                    <input type="password" name="confirm_password" class="form-control" placeholder="密码">
                </div>
                <div class="form-group">
                    <div class="checkbox i-checks"><label> <input type="checkbox" name="agree" value="1"><i></i> <span style="position: relative;top:2px">同意隐私政策 </span></label></div>
                    <label id="agree-error" class="error is-hidden mt-0" for="agree"></label>
                </div>
                <button type="submit" class="btn btn-primary block full-width m-b">注册</button>

                <p class="text-muted text-center"><small>已有账号?</small></p>
                <a class="btn btn-sm btn-white btn-block" href="/login">登录</a>
            </form>
            <p class="m-t"> <small>gin blog &copy; 2014</small> </p>
        </div>
    </div>

    <!-- Mainly scripts -->
    <script src="/public/js/jquery-3.4.1.min.js"></script>
    <script src="/public/js/bootstrap.min.js"></script>
    <script src="/public/plug-in/validate/jquery.validate.min.js"></script>
    <script src="/public/plug-in/validate/localization/messages_zh.js"></script>
    <!-- iCheck -->
    <script src="/public/plug-in/iCheck/icheck.min.js"></script>
    <script>
        $().ready(function(){
            $("form").validate({
                rules: {
                    mobile: "required",
                    password: {
                        required: true,
                        minlength: 6,
                        maxlength: 16
                    },
                    email: {
                        required: true,
                        email: true
                    },
                    confirm_password: {
                        required: true,
                        minlength: 6,
                        maxlength: 16,
                        equalTo: "input[name=password]"
                    },
                    agree: "required"
                },
                messages: {
                    mobile: "请输入您的手机号码",
                    email: "请输入一个正确的邮箱",
                    password: {
                        required: "请输入密码",
                        minlength: "密码长度不能小于 6 个字母",
                        maxlength: "密码长度不能大于 16 个字母"
                    },
                    confirm_password: {
                        required: "请输入密码",
                        minlength: "密码长度不能小于 6 个字母",
                        maxlength: "密码长度不能大于 16 个字母",
                        equalTo: "两次密码输入不一致"
                    },
                    agree: "请接受我们的声明",
                }
            });

            $('.i-checks').iCheck({
                checkboxClass: 'icheckbox_square-green',
                radioClass: 'iradio_square-green',
            });
        });
    </script>
    </body>

</html>
{{ end }}