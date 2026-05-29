<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <title>Poultry Derby - Login</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="css/style.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">
</head>
<body class="d-flex align-items-center justify-content-center">
    <div class="container">
        <div class="row justify-content-center">
            <div class="col-12 col-md-8 col-lg-5 col-xl-4">
                <div class="curved-card fade-up">
                    <div class="text-center mb-5">
                        <h2 class="display-6 fw-bold mb-2 blue-gradient-text">Welcome Back</h2>
                        <p class="text-muted">Sign in to manage your champions</p>
                    </div>

                    <form action="auth" method="POST">
                        <input type="hidden" name="action" value="login">
                        <div class="mb-4">
                            <label class="form-label">Username</label>
                            <input type="text" name="username" class="input-curved" placeholder="Enter your username" required>
                        </div>
                        <div class="mb-5">
                            <label class="form-label">Password</label>
                            <input type="password" name="password" class="input-curved" placeholder="Enter your password" required>
                        </div>

                        <button type="submit" class="btn-gradient w-100">
                            Sign In <i class="fas fa-arrow-right ms-2 small"></i>
                        </button>

                        <% if (request.getParameter("success") != null) { %>
                            <div class="alert alert-success mt-4 border-0 rounded-4 small py-2 text-center" style="background: rgba(16, 185, 129, 0.1); color: #059669;">
                                Registration successful! Please log in.
                            </div>
                        <% } %>

                        <div class="text-center mt-5">
                            <p class="mb-0 text-muted small">
                                Don't have an account?
                                <a href="register.jsp" class="fw-bold text-decoration-none" style="color: var(--primary-blue)">Create one now</a>
                            </p>
                        </div>

                        <% if (request.getParameter("error") != null) { %>
                            <div class="alert alert-danger mt-4 border-0 rounded-4 small py-2 text-center" style="background: rgba(239, 68, 68, 0.1); color: #dc2626;">
                                Invalid credentials. Please try again.
                            </div>
                        <% } %>
                    </form>
                </div>
            </div>
        </div>
    </div>
</body>
</html>
