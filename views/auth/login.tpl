{{ define "auth/login" }}
<!DOCTYPE html>
<html>

<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <title>Gin Blog 后台系统</title>
    <link rel="stylesheet" type="text/css" href="/public/inspire/assets/css/bootstrap.min.css">
    <link rel="stylesheet" type="text/css" href="/public/inspire/assets/fonts/line-icons.css">
    <link rel="stylesheet" type="text/css" href="/public/inspire/assets/css/main.css">
    <link rel="stylesheet" type="text/css" href="/public/inspire/assets/css/responsive.css">
</head>

<body>
<div class="wrapper-page">
    <div class="container">
        <div class="row justify-content-center">
            <div class="col-lg-5 col-md-12 col-xs-12">
                <div class="card">
                    <div class="card-header border-bottom text-center">
                        <h4 class="card-title">登录</h4>
                    </div>
                    <div class="card-body">
                        <form class="form-horizontal m-t-20" action="/sign-in" method="post">

                            {{ range $f := .flash }}
                                <div class="alert alert-danger">{{ $f }}</div>
                            {{ end }}

                            <div class="form-group">
                                <input class="form-control" name="mobile" type="text" required="" placeholder="手机号">
                            </div>
                            <div class="form-group">
                                <input class="form-control" name="password" type="password" required="" placeholder="密码">
                            </div>
                            <div class="form-group">
                                <div class="custom-control custom-checkbox">
                                    <input type="checkbox" name="remember_me" value="1" class="custom-control-input" id="customCheck1">
                                    <label class="custom-control-label" for="customCheck1">记住我</label>
                                </div>
                            </div>
                            <div class="form-group text-center m-t-20">
                                <button class="btn btn-common btn-block" type="submit">登录</button>
                            </div>
                            <div class="form-group">
                                <div class="float-right">
                                    <a href="/forgot-password" class="text-muted"><i class="lni-lock"></i> 忘记密码？</a>
                                </div>
                                <div class="float-left">
                                    <a href="/register" class="text-muted"><i class="lni-user"></i> 创建新账号</a>
                                </div>
                            </div>
                        </form>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
<div id="preloader">
    <div class="loader" id="loader-1"></div>
</div>
<script src="/public/inspire/assets/js/jquery-min.js"></script>
<script src="/public/inspire/assets/js/popper.min.js"></script>
<script src="/public/inspire/assets/js/bootstrap.min.js"></script>
<script src="/public/inspire/assets/js/jquery.app.js"></script>
<script src="/public/inspire/assets/js/main.js"></script>
</body>

</html>
{{ end }}