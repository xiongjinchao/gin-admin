$(function(){
    $(".toastr-success li").each(function(i,item){
        setTimeout(function () {
            toastr.options = {
                closeButton: true,
                progressBar: true,
                showMethod: 'slideDown',
                timeOut: 4000
            };
            toastr.success($(item).text(), '系统提示');
        }, 1000);
    });

    $(".toastr-error li").each(function(i,item){
        setTimeout(function () {
            toastr.options = {
                closeButton: true,
                progressBar: true,
                showMethod: 'slideDown',
                timeOut: 60000,
                extendedTimeOut: 60000
            };
            toastr.error($(item).text(), '系统错误');
        }, 1000);
    });
});