<%@page import="java.util.List"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <title>Poultry Derby - Career History</title>
</head>
<body>
    <%@include file="header.jsp" %>
    <div class="container py-5 fade-up">
        <div class="row justify-content-center">
            <div class="col-12 col-lg-10">
                <div class="curved-card p-5">
                    <h2 class="fw-bold mb-5 blue-gradient-text">Activity Log</h2>
                    <div class="table-responsive">
                        <table class="table-rounded">
                            <tbody>
                                <%
                                    List<String> logs = (List<String>) request.getAttribute("historyLogs");
                                    if (logs != null && !logs.isEmpty()) {
                                        for (String log : logs) {
                                %>
                                    <tr>
                                        <td>
                                            <div class="d-flex align-items-center">
                                                <div class="p-2 rounded-circle bg-light me-3 text-primary"><i class="fas fa-check-circle"></i></div>
                                                <span class="text-muted"><%= log %></span>
                                            </div>
                                        </td>
                                    </tr>
                                <%
                                        }
                                    } else {
                                %>
                                    <tr>
                                        <td class="text-center py-5">
                                            <div class="mb-3 display-4 text-muted opacity-25"><i class="fas fa-folder-open"></i></div>
                                            <p class="text-muted mb-0">No history found yet.</p>
                                        </td>
                                    </tr>
                                <% } %>
                            </tbody>
                        </table>
                    </div>
                </div>
            </div>
        </div>
    </div>
</body>
</html>
