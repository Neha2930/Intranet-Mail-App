<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.*" %>
<%
    if(session.getAttribute("userEmail") == null) {
        response.sendRedirect("login.jsp");
        return;
    }
    // FIXED: Now correctly looking for "messages" instead of "emailList"
    List<Map<String, String>> messagesList = (List<Map<String, String>>) request.getAttribute("messages");
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Inbox - Workspace</title>
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
        .tech-navbar .user-area { display: flex; align-items: center; gap: 20px; font-size: 0.9em; }
        .logout-link { color: #cbd5e1; text-decoration: none; transition: color 0.2s; }
        .logout-link:hover { color: #f8fafc; }

        .container-custom { max-width: 1000px; margin: 40px auto; padding: 0 20px; }
        .page-header { display: flex; justify-content: space-between; align-items: center; margin-bottom: 25px; }
        .page-header h2 { font-size: 1.4em; font-weight: 600; margin: 0; }
        
        .btn-compose { background: var(--tech-primary); color: white; border: none; padding: 8px 16px; border-radius: 6px; font-weight: 500; text-decoration: none; display: flex; align-items: center; gap: 8px; transition: 0.2s; }
        .btn-compose:hover { background: #0043a6; color: white; }

        .data-card { background: white; border: 1px solid var(--tech-border); border-radius: 8px; overflow: hidden; box-shadow: 0 1px 3px rgba(0,0,0,0.05); }
        .table-custom { margin: 0; width: 100%; border-collapse: collapse; }
        .table-custom th { background: #f1f5f9; padding: 12px 20px; font-size: 0.8em; font-weight: 600; color: #64748b; text-transform: uppercase; letter-spacing: 0.5px; border-bottom: 1px solid var(--tech-border); text-align: left; }
        .table-custom td { padding: 16px 20px; border-bottom: 1px solid var(--tech-border); font-size: 0.9em; color: var(--tech-text-main); }
        .table-custom tr:last-child td { border-bottom: none; }
        .table-custom tbody tr { transition: background 0.1s; cursor: pointer; }
        .table-custom tbody tr:hover { background: #f8fafc; }
        
        .sender-col { font-weight: 600; width: 20%; color: #0f172a;}
        .subject-col { width: 60%; color: #0f172a; font-weight: 500;}
        .date-col { width: 20%; color: #94a3b8; font-size: 0.85em; text-align: right; }
        
        .empty-state { text-align: center; padding: 60px 20px; color: #94a3b8; }
        .empty-state i { font-size: 3em; margin-bottom: 15px; opacity: 0.5; }
    </style>
</head>
<body>

    <header class="tech-navbar">
        <div class="brand">
            <i class="fas fa-network-wired"></i> Workspace Mail
        </div>
        <div class="user-area">
            <span><i class="fas fa-user-circle me-1"></i> <%= session.getAttribute("userName") %></span>
            <a href="LogoutServlet" class="logout-link"><i class="fas fa-sign-out-alt"></i> Disconnect</a>
        </div>
    </header>

    <div class="container-custom">
        <div class="page-header">
            <h2>Inbox Data</h2>
            <a href="compose.jsp" class="btn-compose"><i class="fas fa-pen"></i> New Message</a>
        </div>

        <div class="data-card">
            <table class="table-custom">
                <thead>
                    <tr>
                        <th>Sender</th>
                        <th>Message Payload</th>
                        <th style="text-align: right;">Timestamp</th>
                    </tr>
                </thead>
                <tbody>
                    <% if (messagesList != null && !messagesList.isEmpty()) { 
                        for (Map<String, String> msg : messagesList) { %>
                            <tr>
                                <td class="sender-col"><%= msg.get("sender") %></td>
                                <td class="subject-col"><a href="ViewMessageServlet?id=<%= msg.get("id") %>" style="text-decoration: none; color: inherit; display: block;"><%= msg.get("subject") %></a></td>
                                <td class="date-col"><%= msg.get("timestamp") %></td>
                            </tr>
                    <%  } 
                       } else { %>
                            <tr>
                                <td colspan="3">
                                    <div class="empty-state">
                                        <i class="fas fa-inbox"></i>
                                        <p>No records found. The datastore is empty.</p>
                                    </div>
                                </td>
                            </tr>
                    <% } %>
                </tbody>
            </table>
        </div>
    </div>

</body>
</html>