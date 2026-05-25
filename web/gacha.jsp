<%@page import="com.poultryderby.controller.GachaServlet.GachaResult"%>
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
            
            <div class="d-flex justify-content-center gap-3 my-4 flex-wrap">
                <form action="gacha" method="POST">
                    <input type="hidden" name="pullCount" value="1">
                    <button type="submit" class="btn btn-warning btn-lg px-5 shadow" 
                        ${user.gachaCurrency < 100 ? "disabled" : ""}>
                        Pull x1
                    </button>
                    <div class="text-muted mt-2">Cost: 100</div>
                </form>
                <form action="gacha" method="POST">
                    <input type="hidden" name="pullCount" value="10">
                    <button type="submit" class="btn btn-danger btn-lg px-5 shadow" 
                        ${user.gachaCurrency < 900 ? "disabled" : ""}>
                        Pull x10
                    </button>
                    <div class="text-muted mt-2">Cost: 900 <del>1000</del></div>
                </form>
            </div>
            
            <% if (request.getAttribute("gachaResults") != null) { 
                List<GachaResult> results = (List<GachaResult>) request.getAttribute("gachaResults");
                int totalShopGain = (int) request.getAttribute("totalShopGain");
            %>
                <div class="alert alert-info mt-4 animate-fadeIn">
                    <h3>Gacha Result x<%= request.getAttribute("pullCount") %></h3>
                    <% if (totalShopGain > 0) { %>
                        <p class="text-danger">Duplicate bonus: <%= totalShopGain %> Shop Currency.</p>
                    <% } %>
                    <div class="row g-3 mt-2">
                        <% for (GachaResult result : results) {
                            Poultry p = result.getPoultry();
                        %>
                            <div class="col-md-6 col-lg-4">
                                <div class="border rounded p-3 h-100 bg-white">
                                    <h5 class="text-primary mb-1"><%= p.getName() %></h5>
                                    <p class="mb-1">Species: <strong><%= p.getSpecies() %></strong></p>
                                    <p class="mb-1">Rarity: <strong><%= p.getRarity() %></strong></p>
                                    <% if (result.isDuplicate()) { %>
                                        <p class="text-danger mb-0">Duplicate +<%= result.getShopGain() %> Shop</p>
                                    <% } else { %>
                                        <p class="text-success mb-0">Added to inventory</p>
                                    <% } %>
                                </div>
                            </div>
                        <% } %>
                    </div>
                </div>
            <% } %>
            
            <% if (request.getParameter("error") != null) { %>
                <div class="alert alert-danger">Insufficient Gacha Currency!</div>
            <% } %>
        </div>
    </div>
</body>
</html>
