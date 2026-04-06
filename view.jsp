<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.*" %>
<%
    if(session.getAttribute("userEmail") == null) {
        response.sendRedirect("login.jsp");
        return;
    }
    Map<String, String> msg = (Map<String, String>) request.getAttribute("messageDetails");
    if(msg == null) {
        response.sendRedirect("InboxServlet");
        return;
    }
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>View Message - Workspace</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" rel="stylesheet">
    <style>
        :root {
            --tech-primary: #0052cc;
            --tech-dark: #0f172a;
            --tech-bg: #f8fafc;
            --tech-border: #e2e8f0;
            --tech-text-main: #1e293b;
        }
        body { background-color: var(--tech-bg); font-family: -apple-system, BlinkMacSystemFont, "Segoe UI", Roboto, sans-serif; color: var(--tech-text-main); }
        
        .tech-navbar { background-color: var(--tech-dark); padding: 12px 24px; display: flex; justify-content: space-between; align-items: center; color: white; border-bottom: 3px solid var(--tech-primary); }
        .tech-navbar .brand { font-size: 1.1em; font-weight: 600; display: flex; align-items: center; gap: 10px; }
        
        .container-custom { max-width: 800px; margin: 40px auto; padding: 0 20px; }
        
        .action-bar { display: flex; justify-content: space-between; margin-bottom: 20px; }
        .btn-back { color: #475569; text-decoration: none; font-weight: 500; display: flex; align-items: center; gap: 8px; transition: 0.2s; }
        .btn-back:hover { color: var(--tech-primary); }
        
        .reading-pane { background: white; border: 1px solid var(--tech-border); border-radius: 8px; overflow: hidden; box-shadow: 0 1px 3px rgba(0,0,0,0.05); }
        
        .message-header { padding: 25px 30px; border-bottom: 1px solid var(--tech-border); background: #fbfcfd; }
        .message-subject { font-size: 1.5em; font-weight: 600; color: #0f172a; margin-bottom: 15px; }
        .meta-info { display: flex; justify-content: space-between; align-items: center; }
        .sender-badge { display: flex; align-items: center; gap: 12px; }
        .avatar { width: 40px; height: 40px; background: var(--tech-primary); color: white; border-radius: 50%; display: flex; align-items: center; justify-content: center; font-weight: bold; font-size: 1.1em; }
        .sender-details strong { display: block; color: #1e293b; }
        .sender-details span { font-size: 0.85em; color: #64748b; }
        .message-time { font-size: 0.85em; color: #94a3b8; }
        
        .message-body { padding: 35px 30px; min-height: 200px; font-size: 1.05em; line-height: 1.6; color: #334155; white-space: pre-wrap; }
        
        .message-footer { padding: 15px 30px; border-top: 1px solid var(--tech-border); background: #f8fafc; display: flex; justify-content: flex-end; gap: 15px; }
        .btn-tech { padding: 8px 20px; border-radius: 6px; font-weight: 500; text-decoration: none; cursor: pointer; transition: 0.2s; border: none; }
        .btn-reply { background: white; border: 1px solid var(--tech-border); color: #0f172a; }
        .btn-reply:hover { background: #f1f5f9; border-color: #cbd5e1; }
    </style>
</head>
<body>

    <header class="tech-navbar">
        <div class="brand"><i class="fas fa-network-wired"></i> Workspace Mail</div>
        <div>
            <span class="text-light me-3"><i class="fas fa-user-circle me-1"></i> <%= session.getAttribute("userName") %></span>
        </div>
    </header>

    <div class="container-custom">
        <div class="action-bar">
            <a href="InboxServlet" class="btn-back"><i class="fas fa-arrow-left"></i> Back to Inbox</a>
        </div>

        <div class="reading-pane">
            <div class="message-header">
                <div class="message-subject"><%= msg.get("subject") %></div>
                <div class="meta-info">
                    <div class="sender-badge">
                        <div class="avatar"><i class="fas fa-user"></i></div>
                        <div class="sender-details">
                            <strong><%= msg.get("sender") %></strong>
                            <span>to me</span>
                        </div>
                    </div>
                    <div class="message-time"><%= msg.get("timestamp") %></div>
                </div>
            </div>
            
            <div class="message-body"><%= msg.get("body") %></div>
            
            <div class="message-footer">
                <a href="compose.jsp?replyTo=<%= msg.get("sender") %>&subject=Re: <%= msg.get("subject") %>" class="btn-tech btn-reply">
                    <i class="fas fa-reply me-2"></i> Reply
                </a>
            </div>
        </div>
    </div>

</body>
</html>