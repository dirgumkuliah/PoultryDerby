<%@page import="com.poultryderby.model.UserBean"%>
<%
    UserBean user = (UserBean) session.getAttribute("user");
    if (user == null && !request.getRequestURI().endsWith("index.jsp")) {
        response.sendRedirect("index.jsp");
        return;
    }
%>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
<link href="css/style.css" rel="stylesheet">
<link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">

<nav class="navbar navbar-expand-lg navbar-custom sticky-top">
    <div class="container">
        <a class="navbar-brand" href="home.jsp">Poultry Derby</a>
        <button class="navbar-toggler border-0 shadow-none" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav">
            <span class="navbar-toggler-icon"></span>
        </button>
        <div class="collapse navbar-collapse" id="navbarNav">
            <ul class="navbar-nav ms-auto align-items-center gap-2">
                <li class="nav-item"><a class="nav-link" href="home.jsp">Home</a></li>
                <li class="nav-item"><a class="nav-link" href="gacha.jsp">Gacha</a></li>
                <li class="nav-item"><a class="nav-link" href="shop">Shop</a></li>
                <li class="nav-item"><a class="nav-link" href="history">History</a></li>
                <li class="nav-item ms-lg-3">
                    <div class="d-flex align-items-center gap-3 p-2 px-4 rounded-pill bg-light border">
                        <span class="small fw-bold text-primary"><i class="fas fa-gem me-1"></i> Gacha: ${user.gachaCurrency}</span>
                        <div class="vr opacity-25" style="height: 15px;"></div>
                        <span class="small fw-bold text-dark"><i class="fas fa-shopping-bag me-1"></i> Shop: ${user.shopCurrency}</span>
                    </div>
                </li>
                <li class="nav-item ms-lg-2">
                    <form action="auth" method="POST" class="m-0">
                        <input type="hidden" name="action" value="logout">
                        <button type="submit" class="nav-link border-0 bg-transparent text-danger fw-bold"><i class="fas fa-sign-out-alt"></i></button>
                    </form>
                </li>
            </ul>
        </div>
    </div>
</nav>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
