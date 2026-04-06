<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Login - Intranet Workspace</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" rel="stylesheet">
    <style>
        :root {
            --tech-primary: #0052cc; /* Enterprise Blue */
            --tech-primary-hover: #0043a6;
            --tech-dark: #0f172a; /* Slate 900 */
            --tech-bg: #f1f5f9; /* Light Slate background */
            --tech-border: #e2e8f0;
            --tech-text-main: #1e293b;
            --tech-text-muted: #64748b;
        }

        * { margin: 0; padding: 0; box-sizing: border-box; }

        body {
            min-height: 100vh;
            display: flex;
            align-items: center;
            justify-content: center;
            font-family: -apple-system, BlinkMacSystemFont, "Segoe UI", Roboto, Helvetica, Arial, sans-serif;
            background-color: var(--tech-bg);
            background-image: radial-gradient(#cbd5e1 1px, transparent 1px);
            background-size: 30px 30px;
        }

        .wrapper {
            display: flex;
            width: 900px;
            min-height: 550px;
            background: #ffffff;
            border-radius: 8px;
            overflow: hidden;
            box-shadow: 0 10px 40px rgba(15, 23, 42, 0.1);
            border: 1px solid var(--tech-border);
        }

        /* Left Panel - Dark Mode Tech Vibe */
        .left-panel {
            flex: 1;
            background-color: var(--tech-dark);
            /* Subtle technical grid background */
            background-image: 
                linear-gradient(rgba(255, 255, 255, 0.03) 1px, transparent 1px),
                linear-gradient(90deg, rgba(255, 255, 255, 0.03) 1px, transparent 1px);
            background-size: 30px 30px;
            padding: 50px 40px;
            color: white;
            display: flex;
            flex-direction: column;
            justify-content: center;
            position: relative;
            border-right: 1px solid rgba(255,255,255,0.1);
        }

        .left-panel .brand-icon {
            width: 50px; height: 50px;
            background: var(--tech-primary);
            border-radius: 8px;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 1.5em;
            margin-bottom: 30px;
            box-shadow: 0 4px 15px rgba(0, 82, 204, 0.4);
        }

        .left-panel h2 {
            font-size: 1.7em;
            font-weight: 600;
            letter-spacing: -0.5px;
            margin-bottom: 15px;
            color: #f8fafc;
        }

        .left-panel p {
            font-size: 0.95em;
            color: #94a3b8;
            line-height: 1.6;
            margin-bottom: 40px;
        }

        .system-status {
            margin-top: auto;
            display: flex;
            align-items: center;
            gap: 10px;
            font-size: 0.85em;
            color: #cbd5e1;
            background: rgba(255,255,255,0.05);
            padding: 10px 15px;
            border-radius: 6px;
            border: 1px solid rgba(255,255,255,0.1);
        }

        .status-dot {
            width: 8px; height: 8px;
            background-color: #10b981; /* Success Green */
            border-radius: 50%;
            box-shadow: 0 0 8px #10b981;
        }

        /* Right Panel - Clean Minimalist Form */
        .right-panel {
            flex: 1.1;
            padding: 60px 50px;
            display: flex;
            flex-direction: column;
            justify-content: center;
            background: #ffffff;
        }

        .right-panel h3 {
            font-size: 1.6em;
            font-weight: 600;
            color: var(--tech-text-main);
            margin-bottom: 8px;
            letter-spacing: -0.5px;
        }

        .right-panel .subtitle {
            color: var(--tech-text-muted);
            font-size: 0.9em;
            margin-bottom: 35px;
        }

        .form-label {
            font-weight: 500;
            color: var(--tech-text-main);
            font-size: 0.85em;
            margin-bottom: 8px;
        }

        .form-control {
            padding: 12px 15px;
            border: 1px solid var(--tech-border);
            border-radius: 6px;
            font-size: 0.95em;
            color: var(--tech-text-main);
            transition: all 0.2s ease;
            box-shadow: 0 1px 2px rgba(0,0,0,0.02) inset;
        }

        .form-control:focus {
            border-color: var(--tech-primary);
            box-shadow: 0 0 0 3px rgba(0, 82, 204, 0.1);
            outline: none;
        }

        .btn-login {
            width: 100%;
            padding: 12px;
            background: var(--tech-primary);
            border: 1px solid var(--tech-primary-hover);
            border-radius: 6px;
            color: white;
            font-size: 0.95em;
            font-weight: 600;
            cursor: pointer;
            transition: background 0.2s ease;
            margin-top: 10px;
        }

        .btn-login:hover {
            background: var(--tech-primary-hover);
        }

        .row-options {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin: 15px 0 25px;
            font-size: 0.85em;
        }

        .remember-me {
            display: flex;
            align-items: center;
            gap: 8px;
            color: var(--tech-text-muted);
            cursor: pointer;
        }

        .remember-me input[type="checkbox"] {
            accent-color: var(--tech-primary);
            width: 14px; height: 14px;
        }

        .forgot-link {
            color: var(--tech-primary);
            text-decoration: none;
            font-weight: 500;
        }

        .forgot-link:hover { text-decoration: underline; }

        .divider {
            text-align: center;
            color: var(--tech-text-muted);
            font-size: 0.85em;
            margin: 25px 0;
            position: relative;
        }

        .divider::before, .divider::after {
            content: '';
            position: absolute;
            top: 50%;
            width: 42%;
            height: 1px;
            background: var(--tech-border);
        }
        .divider::before { left: 0; }
        .divider::after  { right: 0; }

        .register-link {
            text-align: center;
            font-size: 0.9em;
            color: var(--tech-text-muted);
        }

        .register-link a {
            color: var(--tech-primary);
            font-weight: 600;
            text-decoration: none;
        }
        
        .register-link a:hover { text-decoration: underline; }

        /* Alerts */
        .alert-msg { display: none; padding: 12px; border-radius: 6px; margin-bottom: 20px; font-size: 0.85em; font-weight: 500;}
        .alert-success { background: #ecfdf5; color: #065f46; border: 1px solid #a7f3d0; }
        .alert-error { background: #fef2f2; color: #991b1b; border: 1px solid #fecaca; }

    </style>
</head>
<body>

<div class="wrapper">
    <div class="left-panel">
        <div class="brand-icon">
            <i class="fas fa-network-wired"></i>
        </div>
        <h2>Intranet Workspace</h2>
        <p>Secure, centralized access to your organization's internal tools, messaging, and resources.</p>
        
        <div class="system-status">
            <div class="status-dot"></div>
            <span>All systems operational</span>
        </div>
    </div>

    <div class="right-panel">
        <h3>Sign in</h3>
        <p class="subtitle">Authenticate to access your workspace</p>

        <div class="alert-msg alert-success" id="successMsg">
            <i class="fas fa-check-circle me-2"></i> Account created successfully.
        </div>
        <div class="alert-msg alert-error" id="errorMsg">
            <i class="fas fa-shield-alt me-2"></i> Authentication failed. Invalid credentials.
        </div>

        <form id="loginForm" action="LoginServlet" method="post" novalidate>
            <div class="mb-3">
                <label class="form-label">Email Address</label>
                <input type="email" id="email" name="email" class="form-control" placeholder="name@company.com" required>
            </div>

            <div class="mb-1">
                <label class="form-label">Password</label>
                <input type="password" id="password" name="password" class="form-control" placeholder="*****" required>
            </div>

            <div class="row-options">
                <label class="remember-me">
                    <input type="checkbox" name="remember"> Remember this device
                </label>
                <a href="#" class="forgot-link">Forgot password?</a>
            </div>

            <button type="submit" class="btn-login" id="loginBtn">Authenticate</button>
        </form>

        <div class="divider">or</div>

        <div class="register-link">
            New employee? <a href="register.jsp">Request an account</a>
        </div>
    </div>
</div>

<script>
    // Handle URL parameters for alerts
    const params = new URLSearchParams(window.location.search);
    if (params.get('msg'))   { document.getElementById('successMsg').style.display = 'block'; }
    if (params.get('error')) { document.getElementById('errorMsg').style.display = 'block'; }

    // Validation & Submission
    document.getElementById('loginForm').addEventListener('submit', function (e) {
        e.preventDefault(); 
        
        const email = document.getElementById('email').value.trim();
        const password = document.getElementById('password').value;

        if (email === "" || password === "") {
            document.getElementById('errorMsg').innerHTML = '<i class="fas fa-exclamation-triangle me-2"></i> Please fill in all required fields.';
            document.getElementById('errorMsg').style.display = 'block';
            return;
        }

        // Proceed to Java Backend
        const btn = document.getElementById('loginBtn');
        btn.disabled = true;
        btn.innerHTML = '<i class="fas fa-circle-notch fa-spin me-2"></i> Authenticating...';
        
        document.getElementById('loginForm').submit();
    });
</script>
</body>
</html>