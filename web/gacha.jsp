<%@page import="com.poultryderby.model.Poultry"%>
<%@page import="java.util.List"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <title>Poultry Derby - Gacha System</title>
</head>
<body>
    <%@include file="header.jsp" %>
    <div class="container py-5 fade-up">
        <div class="row justify-content-center">
            <div class="col-12 col-lg-10">
                <div class="curved-card text-center p-5">
                    <h1 class="display-6 fw-bold mb-2 blue-gradient-text">Universal Banner</h1>
                    <p class="text-muted mb-5">Choose your pull and get the rarest poultry!</p>

                    <form action="gacha" method="POST" class="my-5">
                        <div class="d-flex justify-content-center gap-4 flex-wrap">
                            <div class="p-5 border rounded-4 text-center transition-all bg-light border-0" style="min-width: 300px;">
                                <div class="mb-4 fs-1 text-primary"><i class="fas fa-egg"></i></div>
                                <button type="submit" name="pullCount" value="1" class="btn-gradient w-100 mb-3">
                                    Pull x1
                                </button>
                                <p class="mb-0 small fw-bold text-muted">Cost: 100 Gacha Currency</p>
                            </div>
                            <div class="p-5 border-0 rounded-4 text-center transition-all" style="min-width: 300px; background: #eef6ff;">
                                <div class="mb-4 fs-1 text-warning"><i class="fas fa-bolt"></i></div>
                                <button type="submit" name="pullCount" value="10" class="btn-gradient w-100 mb-3">
                                    Pull x10
                                </button>
                                <p class="mb-0 small fw-bold text-primary">
                                    Cost: 900 <span class="text-decoration-line-through opacity-50 small">1000</span>
                                </p>
                            </div>
                        </div>
                    </form>

                    <% if (request.getAttribute("pulledPoultries") != null) {
                        List<Poultry> pulledPoultries = (List<Poultry>) request.getAttribute("pulledPoultries");
                        List<Boolean> dupeResults = (List<Boolean>) request.getAttribute("dupeResults");
                    %>
                        <div class="mt-5 text-start p-4 rounded-4" style="background: #fafafa; border: 2px solid #f1f5f9;">
                            <h4 class="mb-4 text-center fw-bold">Gacha Results</h4>
                            <div class="row g-3">
                                <% for (int i = 0; i < pulledPoultries.size(); i++) {
                                    Poultry p = pulledPoultries.get(i);
                                    boolean isDupe = dupeResults.get(i);
                                %>
                                    <div class="col-12 col-md-6 col-lg-4">
                                        <div class="p-3 border rounded-3 bg-white">
                                            <div class="d-flex justify-content-between align-items-center mb-1">
                                                <span class="fw-bold"><%= p.getName() %></span>
                                                <span class="badge bg-primary rounded-pill"><%= p.getRarity() %></span>
                                            </div>
                                            <% if (isDupe) { %>
                                                <p class="text-danger mb-0 small">Duplicate found!</p>
                                            <% } else { %>
                                                <p class="text-success mb-0 small">New poultry entry!</p>
                                            <% } %>
                                        </div>
                                    </div>
                                <% } %>
                            </div>
                        </div>
                    <% } %>
                </div>
            </div>
        </div>
    </div>
</body>
</html>
