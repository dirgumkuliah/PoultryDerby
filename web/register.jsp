<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <title>Poultry Derby - Register</title>
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
                        <h2 class="display-6 fw-bold mb-2 blue-gradient-text">Register</h2>
                        <p class="text-muted">Join the ultimate poultry derby</p>
                    </div>

                    <form action="RegisterServlet" method="POST">
                        <div class="mb-4">
                            <label class="form-label">Username</label>
                            <input type="text" name="username" class="input-curved" placeholder="Choose a username" required>
                        </div>
                        <div class="mb-5">
                            <label class="form-label">Password</label>
                            <input type="password" name="password" class="input-curved" placeholder="Choose a password" required>
                        </div>

                        <button type="submit" class="btn-gradient w-100">
                            Create Account <i class="fas fa-user-plus ms-2 small"></i>
                        </button>

                        <div class="text-center mt-5">
                            <p class="mb-0 text-muted small">
                                Already have an account?
                                <a href="index.jsp" class="fw-bold text-decoration-none" style="color: var(--primary-blue)">Login here</a>
                            </p>
                        </div>

                        <% if (request.getParameter("error") != null) { %>
                            <div class="alert alert-danger mt-4 border-0 rounded-4 small py-2 text-center" style="background: rgba(239, 68, 68, 0.1); color: #dc2626;">
                                Register failed!
                            </div>
                        <% } %>
                    </form>
                </div>
            </div>
        </div>
    </div>
</body>
</html>
