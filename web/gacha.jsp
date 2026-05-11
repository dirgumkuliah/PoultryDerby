<%@page import="com.poultryderby.model.Poultry"%>
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
            <p class="text-muted">Cost: 100 Gacha Currency</p>
            
            <form action="gacha" method="POST" class="my-4">
                <button type="submit" class="btn btn-warning btn-lg px-5 shadow" 
                        ${user.gachaCurrency < 100 ? "disabled" : ""}>
                    Pull x1
                </button>
            </form>
            
            <% if (request.getAttribute("pulledPoultry") != null) { 
                Poultry p = (Poultry) request.getAttribute("pulledPoultry");
                boolean isDupe = (boolean) request.getAttribute("isDupe");
            %>
                <div class="alert alert-info mt-4 animate-fadeIn">
                    <h3>You pulled: <span class="text-primary"><%= p.getName() %></span></h3>
                    <p class="mb-0">Rarity: <strong><%= p.getRarity() %></strong></p>
                    <% if (isDupe) { %>
                        <p class="text-danger">Duplicate! Converted to <%= request.getAttribute("shopGain") %> Shop Currency.</p>
                    <% } else { %>
                        <p class="text-success">Added to inventory!</p>
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
