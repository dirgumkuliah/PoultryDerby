<%@page import="com.poultryderby.model.UserBean"%>
<%
    UserBean user = (UserBean) session.getAttribute("user");
    if (user == null && !request.getRequestURI().endsWith("index.jsp")) {
        response.sendRedirect("index.jsp");
        return;
    }
%>
<nav class="navbar navbar-expand-lg navbar-dark bg-dark mb-4">
    <div class="container">
        <a class="navbar-brand" href="home.jsp">Poultry Derby</a>
        <div class="collapse navbar-collapse">
            <ul class="navbar-nav me-auto">
                <li class="nav-item"><a class="nav-link" href="home.jsp">Home</a></li>
                <li class="nav-item"><a class="nav-link" href="gacha.jsp">Gacha</a></li>
                <li class="nav-item"><a class="nav-link" href="history">History</a></li>
            </ul>
            <span class="navbar-text me-3">
                Gacha: ${user.gachaCurrency} | Shop: ${user.shopCurrency}
            </span>
            <form action="auth" method="POST" class="d-inline">
                <input type="hidden" name="action" value="logout">
                <button type="submit" class="btn btn-outline-light btn-sm">Logout</button>
            </form>
        </div>
    </div>
</nav>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
