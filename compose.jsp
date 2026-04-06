<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    if(session.getAttribute("userEmail") == null) {
        response.sendRedirect("login.jsp");
        return;
    }
    
    // --- SMART PRE-FILL LOGIC ---
    // Look at the URL to see if we clicked "Reply". If yes, grab the data. If no, leave it blank.
    String replyTo = request.getParameter("replyTo") != null ? request.getParameter("replyTo") : "";
    String prefillSubject = request.getParameter("subject") != null ? request.getParameter("subject") : "";
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Compose - Workspace</title>
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
        
        .container-compose { max-width: 650px; margin: 40px auto; padding: 0 20px; }
        
        .compose-card { background: white; border: 1px solid var(--tech-border); border-radius: 8px; padding: 30px; box-shadow: 0 4px 6px rgba(0,0,0,0.02); }
        .compose-card h3 { font-size: 1.3em; font-weight: 600; margin-bottom: 20px; border-bottom: 1px solid var(--tech-border); padding-bottom: 15px; }

        .form-label { font-size: 0.85em; font-weight: 600; color: #475569; margin-bottom: 5px; }
        .form-control { border: 1px solid var(--tech-border); border-radius: 6px; padding: 10px 12px; font-size: 0.95em; transition: 0.2s; }
        .form-control:focus { border-color: var(--tech-primary); box-shadow: 0 0 0 3px rgba(0, 82, 204, 0.1); }
        
        .btn-toolbar { display: flex; justify-content: space-between; margin-top: 25px; padding-top: 20px; border-top: 1px solid var(--tech-border); }
        .btn-cancel { color: #64748b; text-decoration: none; padding: 8px 16px; font-weight: 500; border-radius: 6px; transition: 0.2s; }
        .btn-cancel:hover { background: #f1f5f9; color: var(--tech-text-main); }
        .btn-send { background: var(--tech-primary); color: white; border: none; padding: 8px 24px; border-radius: 6px; font-weight: 500; transition: 0.2s; }
        .btn-send:hover { background: #0043a6; }

        .alert-box { padding: 10px; border-radius: 6px; margin-bottom: 20px; font-size: 0.85em; display: none; }
        .alert-success { background: #ecfdf5; color: #065f46; border: 1px solid #a7f3d0; display: block; }
        .alert-error { background: #fef2f2; color: #991b1b; border: 1px solid #fecaca; display: block; }
    </style>
</head>
<body>

    <header class="tech-navbar">
        <div class="brand">
            <i class="fas fa-network-wired"></i> Workspace Mail
        </div>
        <div>
            <a href="InboxServlet" style="color: white; text-decoration: none; font-size: 0.9em;"><i class="fas fa-arrow-left"></i> Back to Dashboard</a>
        </div>
    </header>

    <div class="container-compose">
        <div class="compose-card">
            <h3><i class="far fa-envelope me-2"></i> New Transmission</h3>
            
            <% if(request.getParameter("msg") != null) { %>
                <div class="alert-box alert-success"><i class="fas fa-check-circle me-1"></i> Message transmitted successfully.</div>
            <% } else if(request.getParameter("error") != null) { %>
                <div class="alert-box alert-error"><i class="fas fa-exclamation-triangle me-1"></i> Transmission failed. Verify recipient address.</div>
            <% } %>

            <form action="ComposeServlet" method="post">
                <div class="mb-3">
                    <label class="form-label">Recipient Address</label>
                    <input type="email" name="receiver" class="form-control" value="<%= replyTo %>" placeholder="user@company.com" required>
                </div>
                <div class="mb-3">
                    <label class="form-label">Subject</label>
                    <input type="text" name="subject" class="form-control" value="<%= prefillSubject %>" placeholder="Re: Project Update" required>
                </div>
                <div class="mb-3">
                    <label class="form-label">Message Payload</label>
                    <textarea name="body" class="form-control" rows="8" placeholder="Enter your message here..." required autofocus></textarea>
                </div>
                
                <div class="btn-toolbar">
                    <a href="InboxServlet" class="btn-cancel">Cancel</a>
                    <button type="submit" class="btn-send"><i class="fas fa-paper-plane me-2"></i> Transmit</button>
                </div>
            </form>
        </div>
    </div>

</body>
</html>