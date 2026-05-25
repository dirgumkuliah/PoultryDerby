<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <title>Poultry Derby - Home</title>
</head>
<body>
    <%@include file="header.jsp" %>

    <div class="container py-5 fade-up">
        <div class="row justify-content-center align-items-center" style="min-height:60vh;">
            <div class="col-12 col-md-10 col-lg-8">
                <div class="curved-card text-center">
                    <div class="mb-5">
                        <i class="fas fa-flag-checkered display-1 blue-gradient-text opacity-75"></i>
                    </div>

                    <h1 class="display-4 fw-bold mb-3 blue-gradient-text">Welcome, ${user.username}!</h1>
                    <p class="text-muted lead mb-5 px-lg-5">Your champions are resting in the stables. Are you ready to train the next ultimate derby winner?</p>

                    <div class="d-flex flex-wrap justify-content-center gap-3 mt-4">
                        <a href="career?action=select" class="btn-gradient">
                            <i class="fas fa-trophy me-2"></i> Start Career
                        </a>
                        <a href="gacha.jsp" class="btn-outline-blue">
                            <i class="fas fa-star me-2"></i> Pull Gacha
                        </a>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <footer class="mt-5 py-5 text-center text-muted small">
        <p>&copy; 2024 Poultry Derby. Engineered for performance. ❤️</p>
    </footer>
</body>
</html>
