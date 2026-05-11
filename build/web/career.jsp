<%@page import="com.poultryderby.model.CareerManager"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <title>Career Mode</title>
</head>
<body class="bg-light">
    <%@include file="header.jsp" %>
    <div class="container">
        <% 
            CareerManager cm = (CareerManager) session.getAttribute("careerManager");
            if (cm == null) {
                response.sendRedirect("home.jsp");
                return;
            }
        %>
        <div class="row">
            <div class="col-md-4">
                <div class="card shadow-sm mb-4">
                    <div class="card-header bg-primary text-white">Poultry Stats</div>
                    <div class="card-body">
                        <h5 class="card-title text-center"><%= cm.getPoultry().getName() %></h5>
                        <p class="text-muted text-center"><%= cm.getPoultry().getSpecies() %> (<%= cm.getPoultry().getRarity() %>)</p>
                        <hr>
                        <p><strong>Attack:</strong> <%= cm.getPoultry().getAttack() %></p>
                        <p><strong>Speed:</strong> <%= cm.getPoultry().getSpeed() %></p>
                        <p><strong>IQ:</strong> <%= cm.getPoultry().getIq() %></p>
                        <div class="mb-2"><strong>Energy:</strong></div>
                        <div class="progress mb-3">
                            <div class="progress-bar <%= cm.getPoultry().getEnergy() < 30 ? "bg-danger" : "bg-success" %>" 
                                 role="progressbar" style="width: <%= cm.getPoultry().getEnergy() %>%">
                                <%= cm.getPoultry().getEnergy() %>%
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            
            <div class="col-md-8">
                <div class="card shadow-sm">
                    <div class="card-header bg-dark text-white d-flex justify-content-between">
                        <span>Year <%= cm.getYear() %></span>
                        <span>Turn <%= cm.getCurrentTurn() %> / 60</span>
                    </div>
                    <div class="card-body text-center py-5">
                        <% if (cm.isCareerOver()) { %>
                            <h2 class="text-<%= cm.getOutcome().equals("Win") ? "success" : "danger" %>">
                                Career Finished: <%= cm.getOutcome() %>!
                            </h2>
                            <p class="lead">Wins: <%= cm.getWins() %> | Boss Wins: <%= cm.getBossWins() %></p>
                            <a href="home.jsp" class="btn btn-primary">Return Home</a>
                        <% } else { %>
                            <h3>Select Action</h3>
                            <div class="d-grid gap-3 col-6 mx-auto mt-4">
                                <a href="career?action=turn&type=train_attack" class="btn btn-outline-danger btn-lg">Train Attack</a>
                                <a href="career?action=turn&type=train_speed" class="btn btn-outline-info btn-lg">Train Speed</a>
                                <a href="career?action=turn&type=train_iq" class="btn btn-outline-warning btn-lg">Train IQ</a>
                                <a href="career?action=turn&type=rest" class="btn btn-outline-success btn-lg">Rest (Restore Energy)</a>
                                <a href="career?action=turn&type=fight" class="btn btn-dark btn-lg">Fight / Race</a>
                            </div>
                        <% } %>
                    </div>
                </div>
            </div>
        </div>
    </div>
</body>
</html>
