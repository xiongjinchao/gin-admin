<!DOCTYPE html>
<html>

<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <title>Inspire - Admin and Dashboard Template</title>
    <link rel="stylesheet" type="text/css" href="/public/inspire/assets/css/bootstrap.min.css">
    <link rel="stylesheet" type="text/css" href="/public/inspire/assets/fonts/line-icons.css">
    <link rel="stylesheet" href="/public/inspire/assets/plugins/morris/morris.css">
    <link rel="stylesheet" type="text/css" href="/public/inspire/assets/css/main.css">
    <link rel="stylesheet" type="text/css" href="/public/inspire/assets/css/responsive.css">
</head>

<body>
<div class="app header-default side-nav-dark">
    <div class="layout">
        {{ template "header"}}

        {{ template "sidebar"}}

        <div class="page-container">
            {{ template "content" .}}
            {{ template "footer"}}
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
<script src="/public/inspire/assets/plugins/morris/morris.min.js"></script>
<script src="/public/inspire/assets/plugins/raphael/raphael-min.js"></script>
<script src="/public/inspire/assets/js/dashborad1.js"></script>
</body>

</html>