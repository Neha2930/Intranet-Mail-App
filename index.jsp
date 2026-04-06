<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    // SMART ROUTING: If the user is already logged in, skip this page and go straight to the Inbox!
    if(session.getAttribute("userEmail") != null) {
        response.sendRedirect("InboxServlet");
        return;
    }
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Intranet Workspace Mail - Enterprise Intranet</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" rel="stylesheet">
    <style>
        :root {
            --tech-primary: #0052cc;
            --tech-primary-hover: #0043a6;
            --tech-dark: #0f172a;
            --tech-darker: #0b1120;
            --tech-text-muted: #94a3b8;
        }

        body {
            font-family: -apple-system, BlinkMacSystemFont, "Segoe UI", Roboto, sans-serif;
            background-color: var(--tech-darker);
            color: #f8fafc;
            margin: 0;
            padding: 0;
            overflow-x: hidden;
        }

        /* --- Custom CSS Logo --- */
        .brand-logo {
            display: flex;
            align-items: center;
            gap: 12px;
            text-decoration: none;
            color: white;
            font-weight: 700;
            font-size: 1.4em;
            letter-spacing: -0.5px;
        }
        
        .brand-icon-wrapper {
            width: 40px;
            height: 40px;
            background: linear-gradient(135deg, var(--tech-primary), #3b82f6);
            border-radius: 10px;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 1.1em;
            box-shadow: 0 4px 15px rgba(0, 82, 204, 0.4);
            position: relative;
        }

        /* --- Navigation --- */
        .navbar-custom {
            padding: 20px 50px;
            display: flex;
            justify-content: space-between;
            align-items: center;
            background: rgba(11, 17, 32, 0.8);
            backdrop-filter: blur(10px);
            position: fixed;
            width: 100%;
            top: 0;
            z-index: 1000;
            border-bottom: 1px solid rgba(255,255,255,0.05);
        }

        .nav-links a {
            color: #e2e8f0;
            text-decoration: none;
            font-weight: 500;
            font-size: 0.95em;
            margin-left: 25px;
            transition: color 0.2s;
        }

        .nav-links a:hover { color: white; }

        /* --- Hero Section --- */
        .hero {
            min-height: 100vh;
            display: flex;
            flex-direction: column;
            justify-content: center;
            align-items: center;
            text-align: center;
            padding: 0 20px;
            position: relative;
            background-image: 
                radial-gradient(circle at 15% 50%, rgba(0, 82, 204, 0.15), transparent 25%),
                radial-gradient(circle at 85% 30%, rgba(59, 130, 246, 0.15), transparent 25%);
        }

        .hero-badge {
            background: rgba(0, 82, 204, 0.2);
            color: #60a5fa;
            padding: 6px 16px;
            border-radius: 20px;
            font-size: 0.85em;
            font-weight: 600;
            letter-spacing: 1px;
            text-transform: uppercase;
            margin-bottom: 25px;
            border: 1px solid rgba(0, 82, 204, 0.3);
            animation: fadeInDown 0.8s ease-out;
        }

        .hero h1 {
            font-size: 4.5em;
            font-weight: 800;
            letter-spacing: -1.5px;
            line-height: 1.1;
            margin-bottom: 20px;
            background: linear-gradient(to right, #ffffff, #94a3b8);
            -webkit-background-clip: text;
            -webkit-text-fill-color: transparent;
            max-width: 900px;
            animation: fadeInUp 0.8s ease-out 0.2s both;
        }

        .hero p {
            font-size: 1.25em;
            color: var(--tech-text-muted);
            max-width: 600px;
            margin-bottom: 40px;
            line-height: 1.6;
            animation: fadeInUp 0.8s ease-out 0.4s both;
        }

        .cta-buttons {
            display: flex;
            gap: 20px;
            animation: fadeInUp 0.8s ease-out 0.6s both;
        }

        .btn-primary-tech {
            background: var(--tech-primary);
            color: white;
            padding: 14px 32px;
            border-radius: 8px;
            text-decoration: none;
            font-weight: 600;
            font-size: 1.1em;
            transition: all 0.2s;
            border: 1px solid var(--tech-primary-hover);
            box-shadow: 0 4px 14px rgba(0, 82, 204, 0.3);
        }

        .btn-primary-tech:hover {
            background: var(--tech-primary-hover);
            transform: translateY(-2px);
            color: white;
        }

        .btn-secondary-tech {
            background: rgba(255,255,255,0.05);
            color: white;
            padding: 14px 32px;
            border-radius: 8px;
            text-decoration: none;
            font-weight: 600;
            font-size: 1.1em;
            transition: all 0.2s;
            border: 1px solid rgba(255,255,255,0.1);
        }

        .btn-secondary-tech:hover {
            background: rgba(255,255,255,0.1);
            color: white;
        }

        /* --- Features Section --- */
        .features {
            padding: 100px 20px;
            background: var(--tech-dark);
            border-top: 1px solid rgba(255,255,255,0.05);
        }

        .feature-card {
            background: rgba(255,255,255,0.02);
            border: 1px solid rgba(255,255,255,0.05);
            padding: 40px 30px;
            border-radius: 12px;
            height: 100%;
            transition: transform 0.3s;
        }

        .feature-card:hover { transform: translateY(-5px); border-color: rgba(0, 82, 204, 0.5); }

        .feature-icon {
            font-size: 2em;
            color: #60a5fa;
            margin-bottom: 20px;
        }

        .feature-card h3 { font-size: 1.3em; font-weight: 600; margin-bottom: 15px; }
        .feature-card p { color: var(--tech-text-muted); font-size: 0.95em; line-height: 1.6; margin: 0; }

        /* Animations */
        @keyframes fadeInUp {
            from { opacity: 0; transform: translateY(20px); }
            to { opacity: 1; transform: translateY(0); }
        }
        @keyframes fadeInDown {
            from { opacity: 0; transform: translateY(-20px); }
            to { opacity: 1; transform: translateY(0); }
        }
    </style>
</head>
<body>

    <nav class="navbar-custom">
        <a href="index.jsp" class="brand-logo">
            <div class="brand-icon-wrapper">
                <i class="fas fa-layer-group"></i>
            </div>
            Intranet Workspace Mail
        </a>
        <div class="nav-links">
            <a href="login.jsp">Employee Login</a>
            <a href="register.jsp" class="btn-primary-tech" style="padding: 8px 20px; margin-left: 15px; font-size: 0.9em;">Request Access</a>
        </div>
    </nav>

    <header class="hero">
        <div class="hero-badge">v1.0 Internal Release</div>
        <h1>The central nervous system for your team.</h1>
        <p>A secure, high-performance intranet mailing platform designed specifically to keep your organization's internal communications completely private and remarkably fast.</p>
        
        <div class="cta-buttons">
            <a href="login.jsp" class="btn-primary-tech"><i class="fas fa-sign-in-alt me-2"></i> Authenticate</a>
            <a href="#features" class="btn-secondary-tech">Explore Infrastructure</a>
        </div>
    </header>

    <section class="features" id="features">
        <div class="container">
            <div class="row g-4">
                <div class="col-md-4">
                    <div class="feature-card">
                        <i class="fas fa-shield-alt feature-icon"></i>
                        <h3>On-Premise Security</h3>
                        <p>All data is stored securely on your local intranet MySQL database. No external tracking, no third-party servers. Your corporate data stays within the building.</p>
                    </div>
                </div>
                <div class="col-md-4">
                    <div class="feature-card">
                        <i class="fas fa-bolt feature-icon"></i>
                        <h3>Zero Latency</h3>
                        <p>Built purely on Java Servlets and optimized JDBC connections, internal message routing happens instantly without relying on external internet bandwidth.</p>
                    </div>
                </div>
                <div class="col-md-4">
                    <div class="feature-card">
                        <i class="fas fa-sitemap feature-icon"></i>
                        <h3>Role-Based Architecture</h3>
                        <p>Session-based authentication ensures that only provisioned employees can access the directory, transmit messages, or view historical inbox data.</p>
                    </div>
                </div>
            </div>
        </div>
    </section>

    <footer style="text-align: center; padding: 30px; background: var(--tech-darker); border-top: 1px solid rgba(255,255,255,0.05); color: #64748b; font-size: 0.85em;">
        &copy; 2026 4<subset>th<subset> Infantry. Built with Java Enterprise.
    </footer>

</body>
</html>