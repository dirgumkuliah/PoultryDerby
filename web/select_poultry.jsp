<%@page import="java.net.URLEncoder"%>
<%@page import="java.nio.charset.StandardCharsets"%>
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
                        <div class="d-inline-flex align-items-center justify-content-center rounded-circle bg-light shadow-sm overflow-hidden" style="width: 80px; height: 80px; margin: 0 auto;">
                            <%
                                String fileName = p.getName().equalsIgnoreCase("Midget White Turkey") ? "turkey_default.png" :
                                               p.getSpecies().toLowerCase() + "_" + p.getRarity().toLowerCase() + ".png";
                            %>
                            <img src="assets/poultry/<%= fileName %>"
                                 alt="<%= p.getSpecies() %>"
                                 style="width: 100%; height: 100%; object-fit: cover;"
                                 onerror="this.src='https://ui-avatars.com/api/?name=<%= p.getSpecies() %>&background=random'">
                        </div>
                    </div>
                    <h4 class="fw-bold mb-1"><%= p.getName() %></h4>

                    <p class="small text-muted mb-3"><%= p.getSpecies() %></p>
                    <div class="mb-4">
                        <span class="badge rounded-pill bg-primary px-3 py-2"><%= p.getRarity() %></span>
                    </div>

                    <div class="text-start mb-5 mt-auto p-3 rounded-4 bg-light">
                        <% if (!"Pheasant".equalsIgnoreCase(p.getSpecies())) { %>
                        <div class="d-flex justify-content-between small mb-2">
                            <span class="fw-bold"><i class="fas fa-shield-alt me-1 text-primary"></i>Attack</span>
                            <span class="fw-bold text-primary"><%= p.getAttack() %></span>
                        </div>
                        <% } %>
                        <% if (!"Turkey".equalsIgnoreCase(p.getSpecies())) { %>
                        <div class="d-flex justify-content-between small mb-2">
                            <span class="fw-bold"><i class="fas fa-bolt me-1 text-primary"></i>Speed</span>
                            <span class="fw-bold text-primary"><%= p.getSpeed() %></span>
                        </div>
                        <% } %>
                        <div class="d-flex justify-content-between small mb-2">
                            <span class="fw-bold"><i class="fas fa-brain me-1 text-primary"></i>IQ</span>
                            <span class="fw-bold text-primary"><%= p.getIq() %></span>
                        </div>
                        <div class="d-flex justify-content-between small">
                            <span class="fw-bold"><i class="fas fa-battery-full me-1 text-success"></i>Energy</span>
                            <span class="fw-bold text-success"><%= p.getEnergy() %>%</span>
                        </div>
                    </div>

                    <a href="career?action=start&poultryName=<%= URLEncoder.encode(p.getName(), StandardCharsets.UTF_8.toString()) %>" class="btn-gradient w-100 py-3">Select</a>
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
