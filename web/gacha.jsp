<%@page import="com.poultryderby.model.Poultry"%>
<%@page import="java.util.List"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <title>Gacha System</title>
</head>
<body class="bg-light">
    <%@include file="header.jsp" %>
    <div class="container text-center">
        <div class="card shadow-sm p-5">
            <h1>Universal Banner</h1>
            <p class="text-muted mb-4">Choose your pull</p>

            <form action="gacha" method="POST" class="my-4">
                <div class="d-flex justify-content-center gap-3 flex-wrap">
                    <div>
                        <button type="submit" name="pullCount" value="1" class="btn btn-warning btn-lg px-5 shadow">
                            Pull x1
                        </button>
                        <p class="text-muted mt-2 mb-0">Cost: 100 Gacha Currency</p>
                    </div>
                    <div>
                        <button type="submit" name="pullCount" value="10" class="btn btn-danger btn-lg px-5 shadow">
                            Pull x10
                        </button>
                        <p class="text-muted mt-2 mb-0">
                            Cost: 900 <span class="text-decoration-line-through">1000</span> Gacha Currency
                        </p>
                    </div>
                </div>
            </form>
            
            <% if (request.getAttribute("pulledPoultries") != null) {
                List<Poultry> pulledPoultries = (List<Poultry>) request.getAttribute("pulledPoultries");
                List<Boolean> dupeResults = (List<Boolean>) request.getAttribute("dupeResults");
                List<Integer> shopGains = (List<Integer>) request.getAttribute("shopGains");
                int pullCount = (int) request.getAttribute("pullCount");
            %>
                <div class="alert alert-info mt-4 animate-fadeIn">
                    <h3>Pull x<%= pullCount %> Result</h3>
                    <div class="row g-3 mt-2">
                        <% for (int i = 0; i < pulledPoultries.size(); i++) {
                            Poultry p = pulledPoultries.get(i);
                            boolean isDupe = dupeResults.get(i);
                            int shopGain = shopGains.get(i);
                        %>
                            <div class="col-md-6">
                                <div class="border rounded p-3 bg-white h-100">
                                    <h5 class="mb-1"><%= i + 1 %>. <span class="text-primary"><%= p.getName() %></span></h5>
                                    <p class="mb-1">Rarity: <strong><%= p.getRarity() %></strong></p>
                                    <% if (isDupe) { %>
                                        <p class="text-danger mb-0">Duplicate! Converted to <%= shopGain %> Shop Currency.</p>
                                    <% } else { %>
                                        <p class="text-success mb-0">Added to inventory!</p>
                                    <% } %>
                                </div>
                            </div>
                        <% } %>
                    </div>
                    <% if ((int) request.getAttribute("totalShopGain") > 0) { %>
                        <p class="mt-3 mb-0">Total duplicate conversion: <strong><%= request.getAttribute("totalShopGain") %></strong> Shop Currency.</p>
                    <% } %>
                </div>
            <% } %>
            
            <% if (request.getParameter("error") != null) { %>
                <div class="alert alert-danger">Insufficient Gacha Currency!</div>
            <% } %>
        </div>
    </div>
</body>
</html>
