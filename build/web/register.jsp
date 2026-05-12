<%-- 
    Document   : register
    Created on : May 12, 2026, 7:04:34 PM
    Author     : Bar
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
<head>
    <title>Poultry Derby - Register</title>

    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">

    <style>
        body {
            background: #f8f9fa;
            display: flex;
            align-items: center;
            justify-content: center;
            height: 100vh;
        }

        .register-card {
            width: 400px;
            padding: 20px;
            border-radius: 10px;
            box-shadow: 0 4px 15px rgba(0,0,0,0.1);
            background: white;
        }
    </style>
</head>

<body>

    <div class="register-card">

        <h2 class="text-center mb-4">
            Poultry Derby
        </h2>

        <form action="RegisterServlet" method="POST">

            <div class="mb-3">
                <label class="form-label">
                    Username
                </label>

                <input type="text"
                       name="username"
                       class="form-control"
                       required>
            </div>

            <div class="mb-3">
                <label class="form-label">
                    Password
                </label>

                <input type="password"
                       name="password"
                       class="form-control"
                       required>
            </div>

            <button type="submit"
                    class="btn btn-primary w-100">
                Register
            </button>

            <div class="text-center mt-3">
                <p class="mb-0">
                    Sudah punya akun?
                    <a href="index.jsp">
                        Login
                    </a>
                </p>
            </div>

            <% if (request.getParameter("error") != null) { %>
                <p class="text-danger mt-2 text-center">
                    Register gagal!
                </p>
            <% } %>

        </form>

    </div>

</body>
</html>
