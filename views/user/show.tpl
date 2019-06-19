{{ define "content" }}
    <html>
    <h1>
        {{ .title }}
    </h1>
    <div>user show content</div>
    <p>{{ .user.Name}}</p>
    <p>{{ .user.Email}}</p>
    <p>{{ .user.Mobile}}</p>
    <p>{{ .user.CreatedAt.Format "2006-01-02 15:04:05" }}</p>
    <p>{{ .user.UpdatedAt.Format "2006-01-02 15:04:05" }}</p>
    </html>
{{ end }}