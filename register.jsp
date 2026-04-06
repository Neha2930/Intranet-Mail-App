<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Request Access - Intranet Workspace</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" rel="stylesheet">
    <style>
        :root {
            --tech-primary: #0052cc;
            --tech-primary-hover: #0043a6;
            --tech-dark: #0f172a;
            --tech-bg: #f1f5f9;
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
            font-family: -apple-system, BlinkMacSystemFont, "Segoe UI", Roboto, sans-serif;
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

        .left-panel {
            flex: 1;
            background-color: var(--tech-dark);
            background-image: 
                linear-gradient(rgba(255, 255, 255, 0.03) 1px, transparent 1px),
                linear-gradient(90deg, rgba(255, 255, 255, 0.03) 1px, transparent 1px);
            background-size: 30px 30px;
            padding: 50px 40px;
            color: white;
            display: flex;
            flex-direction: column;
            justify-content: center;
            border-right: 1px solid rgba(255,255,255,0.1);
        }

        .brand-icon {
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

        .left-panel h2 { font-size: 1.7em; font-weight: 600; margin-bottom: 15px; color: #f8fafc; }
        .left-panel p { font-size: 0.95em; color: #94a3b8; line-height: 1.6; }

        .right-panel {
            flex: 1.1;
            padding: 50px;
            display: flex;
            flex-direction: column;
            justify-content: center;
            background: #ffffff;
        }

        .right-panel h3 { font-size: 1.6em; font-weight: 600; color: var(--tech-text-main); margin-bottom: 8px; }
        .right-panel .subtitle { color: var(--tech-text-muted); font-size: 0.9em; margin-bottom: 25px; }

        .form-label { font-weight: 500; color: var(--tech-text-main); font-size: 0.85em; margin-bottom: 6px; }
        .form-control {
            padding: 10px 14px;
            border: 1px solid var(--tech-border);
            border-radius: 6px;
            font-size: 0.95em;
            margin-bottom: 15px;
        }
        .form-control:focus { border-color: var(--tech-primary); box-shadow: 0 0 0 3px rgba(0, 82, 204, 0.1); outline: none; }

        .btn-primary-tech {
            width: 100%;
            padding: 12px;
            background: var(--tech-primary);
            border: 1px solid var(--tech-primary-hover);
            border-radius: 6px;
            color: white;
            font-size: 0.95em;
            font-weight: 600;
            cursor: pointer;
            transition: background 0.2s;
            margin-top: 10px;
        }
        .btn-primary-tech:hover { background: var(--tech-primary-hover); }

        .login-link { text-align: center; font-size: 0.9em; color: var(--tech-text-muted); margin-top: 25px; }
        .login-link a { color: var(--tech-primary); font-weight: 600; text-decoration: none; }
        
        .alert-error { display: none; background: #fef2f2; color: #991b1b; padding: 12px; border-radius: 6px; border: 1px solid #fecaca; margin-bottom: 15px; font-size: 0.85em; }
    </style>
</head>
<body>

<div class="wrapper">
    <div class="left-panel">
        <div class="brand-icon"><i class="fas fa-user-plus"></i></div>
        <h2>Join Workspace</h2>
        <p>Request an account to access internal tools, collaborate with your team, and manage your communications securely.</p>
    </div>

    <div class="right-panel">
        <h3>Create Account</h3>
        <p class="subtitle">Enter your details to provision a new user profile</p>

        <div class="alert-error" id="errorMsg">
            <i class="fas fa-exclamation-triangle me-2"></i> Registration failed. User may already exist.
        </div>

        <form action="RegisterServlet" method="post" id="registerForm">
            <label class="form-label">Full Name</label>
            <input type="text" name="fullName" id="fullName" class="form-control" placeholder="Enter Full name" required>

            <label class="form-label">Corporate Email</label>
            <input type="email" name="email" id="email" class="form-control" placeholder="name@company.com" required>

            <label class="form-label">Password</label>
            <input type="password" name="password" id="password" class="form-control" placeholder="*****" required>

            <label class="form-label">Confirm Password</label>
            <input type="password" id="confirmPassword" class="form-control" placeholder="*****" required>

            <button type="submit" class="btn-primary-tech" id="regBtn">Create Account</button>
        </form>

        <div class="login-link">
            Already provisioned? <a href="login.jsp">Return to Login</a>
        </div>
    </div>
</div>

<script>
    // Check for server-side errors in the URL
    if (new URLSearchParams(window.location.search).get('error')) {
        const errorDiv = document.getElementById('errorMsg');
        errorDiv.innerHTML = '<i class="fas fa-exclamation-triangle me-2"></i> Registration failed. User may already exist.';
        errorDiv.style.display = 'block';
    }
    
    // Client-side validation before sending data to Java
    document.getElementById('registerForm').addEventListener('submit', function(e) {
        const pwd = document.getElementById('password').value;
        const confirmPwd = document.getElementById('confirmPassword').value;
        const errorDiv = document.getElementById('errorMsg');

        // 1. Check if passwords match
        if (pwd !== confirmPwd) {
            e.preventDefault(); // Stop the form from submitting!
            errorDiv.innerHTML = '<i class="fas fa-exclamation-circle me-2"></i> Passwords do not match.';
            errorDiv.style.display = 'block';
            return; // Exit the function
        }

        // 2. If they match and fields aren't empty, show the loading spinner
        if(document.getElementById('fullName').value.trim() !== "" && document.getElementById('email').value.trim() !== "") {
            errorDiv.style.display = 'none'; // Hide error if it was showing
            document.getElementById('regBtn').innerHTML = '<i class="fas fa-circle-notch fa-spin me-2"></i> Processing...';
        }
    });
</script>
</body>
</html>