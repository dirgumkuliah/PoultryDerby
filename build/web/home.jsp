<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <title>Poultry Derby - Home</title>
</head>
<body class="bg-light">
    <%@include file="header.jsp" %>
    <div class="container">
        <div class="row">
            <div class="col-md-8 offset-md-2 text-center">
                <div class="card p-5 shadow-sm">
                    <h1>Welcome, ${user.username}!</h1>
                    <p class="lead">Train your poultry to become the ultimate champion.</p>
                    <div class="mt-4">
                       <a href="career?action=select" class="btn btn-success btn-lg px-5">Start New Career</a>
                    </div>
                </div>
            </div>
        </div>
    </div>
</body>
</html>
