<%-- 
    Document   : select_poultry
    Created on : 11 May 2026, 14.58.20
    Author     : shahr
--%>

<%@page import="java.util.List"%>
<%@page import="com.poultryderby.model.Poultry"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <title>Select Your Champion</title>
</head>
<body class="bg-light">
    <%@include file="header.jsp" %>
    <div class="container">
        <h2 class="text-center my-4">Select Your Champion</h2>
        <div class="row">
            <% 
                List<Poultry> inventory = (List<Poultry>) request.getAttribute("inventory");
                if (inventory != null && !inventory.isEmpty()) {
                    for (Poultry p : inventory) {
            %>
            <div class="col-md-4 mb-4">
                <div class="card shadow-sm h-100 border-primary">
                    <div class="card-body text-center">
                        <h5 class="card-title text-primary"><%= p.getName() %></h5>
                        <p class="card-text text-muted mb-1"><%= p.getSpecies() %></p>
                        <span class="badge bg-dark mb-3"><%= p.getRarity() %></span>
                        <br>
                        <a href="career?action=start&poultryName=<%= p.getName() %>" class="btn btn-success w-100">Select & Start</a>
                    </div>
                </div>
            </div>
            <%      }
                } else { %>
            <div class="col-12 text-center py-5">
                <h4 class="text-muted">Your inventory is empty!</h4>
                <p>You need to pull at least one poultry from the Universal Banner.</p>
                <a href="gacha.jsp" class="btn btn-warning btn-lg shadow">Go to Gacha</a>
            </div>
            <%  } %>
        </div>
    </div>
</body>
</html>