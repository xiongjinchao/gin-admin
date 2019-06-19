{{ define "content" }}
    <html>
    <h1>
        {{ .title }}
    </h1>
    <div>user create content</div>

    <form action = "/admin/user" method="post">
        <input name="name" value="Ted">
        <input name="mobile" value="15911006066">
        <input name="email" value="67218027@qq.com">
        <input name="password" value="123456">
        <button type="submit">提交</button>
    </form>
    </html>
{{ end }}