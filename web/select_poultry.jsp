<%@page import="java.util.List"%>
<%@page import="com.poultryderby.model.Poultry"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <title>Poultry Derby - Select Champion</title>
</head>
<body>
    <%@include file="header.jsp" %>
    <div class="container py-5 fade-up">
        <div class="text-center mb-5">
            <h2 class="display-5 fw-bold blue-gradient-text">Choose Your Champion</h2>
            <p class="text-muted">Select the poultry that will lead you to victory.</p>
        </div>

        <div class="row g-4 justify-content-center">
            <%
                List<Poultry> inventory = (List<Poultry>) request.getAttribute("inventory");
                if (inventory != null && !inventory.isEmpty()) {
                    for (Poultry p : inventory) {
            %>
            <div class="col-12 col-md-6 col-lg-4 col-xl-3">
                <div class="curved-card text-center p-5 h-100 d-flex flex-column transition-all">
                    <div class="mb-4">
                        <div class="d-inline-flex p-4 rounded-circle bg-light text-primary fs-2 shadow-sm">
                            <i class="fas fa-certificate"></i>
                        </div>
                    </div>
                    <h4 class="fw-bold mb-1"><%= p.getName() %></h4>
                    <p class="small text-muted mb-4"><%= p.getSpecies() %></p>
                    <div class="mb-5 mt-auto">
                        <span class="badge rounded-pill bg-primary px-3 py-2"><%= p.getRarity() %></span>
                    </div>
                    <a href="career?action=start&poultryName=<%= p.getName() %>" class="btn-gradient w-100 py-3">Select</a>
                </div>
            </div>
            <%      }
                } else { %>
            <div class="col-12 col-md-8 col-lg-6 text-center py-5">
                <div class="curved-card p-5">
                    <div class="mb-4 display-1 text-muted opacity-25"><i class="fas fa-box-open"></i></div>
                    <h3 class="fw-bold mb-3">Inventory Empty</h3>
                    <p class="text-muted mb-5">Obtain your first champion through the Gacha system.</p>
                    <a href="gacha.jsp" class="btn-gradient px-5">Go to Gacha</a>
                </div>
            </div>
            <%  } %>
        </div>
    </div>
</body>
</html>
