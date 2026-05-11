<%@page import="java.util.List"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <title>Career History</title>
</head>
<body class="bg-light">
    <%@include file="header.jsp" %>
    <div class="container">
        <div class="card shadow-sm">
            <div class="card-header bg-dark text-white">Career Log</div>
            <div class="card-body">
                <table class="table table-hover">
                    <thead>
                        <tr>
                            <th>Entry</th>
                        </tr>
                    </thead>
                    <tbody>
                        <% 
                            List<String> logs = (List<String>) request.getAttribute("historyLogs");
                            if (logs != null && !logs.isEmpty()) {
                                for (String log : logs) {
                        %>
                            <tr><td><%= log %></td></tr>
                        <% 
                                }
                            } else {
                        %>
                            <tr><td class="text-center text-muted">No history found. Complete a career first!</td></tr>
                        <% } %>
                    </tbody>
                </table>
            </div>
        </div>
    </div>
</body>
</html>
