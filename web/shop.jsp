<%@page import="java.util.Set"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    if (request.getAttribute("ownedPoultryNames") == null && request.getRequestURI().endsWith("shop.jsp")) {
        response.sendRedirect("shop");
        return;
    }
%>
<!DOCTYPE html>
<html>
<head>
    <title>Poultry Derby - Shop</title>
</head>
<body>
    <%@include file="header.jsp" %>

    <div class="container py-5 fade-up">
        <div class="text-center mb-5">
            <h1 class="display-5 fw-bold blue-gradient-text">Poultry Shop</h1>
            <p class="text-muted">Shop Currency is earned when gacha pulls give you duplicate poultry.</p>
        </div>

        <% if (request.getParameter("success") != null) { %>
            <div class="alert alert-success border-0 rounded-4 text-center fw-bold mb-4">
                Purchase successful! Poultry has been added to your inventory.
            </div>
        <% } %>

        <% if ("insufficient".equals(request.getParameter("error"))) { %>
            <div class="alert alert-danger border-0 rounded-4 text-center fw-bold mb-4">
                Shop Currency is not enough for this poultry.
            </div>
        <% } else if ("duplicate".equals(request.getParameter("error"))) { %>
            <div class="alert alert-warning border-0 rounded-4 text-center fw-bold mb-4">
                You already own this poultry.
            </div>
        <% } else if (request.getParameter("error") != null) { %>
            <div class="alert alert-danger border-0 rounded-4 text-center fw-bold mb-4">
                Purchase failed. Please try again.
            </div>
        <% } %>

        <div class="curved-card mb-5 p-4">
            <div class="d-flex flex-wrap justify-content-between align-items-center gap-3">
                <div>
                    <h5 class="fw-bold mb-1"><i class="fas fa-shopping-bag me-2 text-primary"></i>Your Shop Currency</h5>
                    <p class="text-muted small mb-0">Pull gacha again; duplicate poultry will automatically become Shop Currency.</p>
                </div>
                <div class="display-6 fw-bold blue-gradient-text">${user.shopCurrency}</div>
            </div>
        </div>

        <div class="row g-4">
            <%
                Set<String> ownedPoultryNames = (Set<String>) request.getAttribute("ownedPoultryNames");

                String[][] items = {
                    {"legend_turkey", "Bourbon Red Turkey", "Turkey", "Legend", "200"},
                    {"legend_pheasant", "Himalayan Moral Pheasant", "Pheasant", "Legend", "200"},
                    {"legend_duck", "Madagascar Pochard Duck", "Duck", "Legend", "200"},
                    {"secret_turkey", "Bronze Turkey", "Turkey", "Secret", "750"},
                    {"secret_pheasant", "Crested Argus Pheasant", "Pheasant", "Secret", "750"},
                    {"secret_duck", "Mergus Serrator Duck", "Duck", "Secret", "750"},
                    {"hack_turkey", "Silver Auburn Turkey", "Turkey", "Hack", "3000"},
                    {"hack_pheasant", "Bornean Peacock Pheasant", "Pheasant", "Hack", "3000"},
                    {"hack_duck", "Donald Duck", "Duck", "Hack", "3000"}
                };

                for (String[] item : items) {
                    String species = item[2];
                    String rarity = item[3];
                    String badgeClass = "Legend".equals(rarity) ? "bg-warning text-dark" : ("Secret".equals(rarity) ? "bg-dark" : "bg-danger");
                    int price = Integer.parseInt(item[4]);
                    boolean soldOut = ownedPoultryNames != null && ownedPoultryNames.contains(item[1]);
                    boolean canAfford = user != null && user.getShopCurrency() >= price;
            %>
                <div class="col-12 col-md-6 col-xl-4">
                    <div class="curved-card h-100 p-4 d-flex flex-column transition-all">
                        <div class="d-flex justify-content-between align-items-start mb-4">
                            <div class="d-inline-flex align-items-center justify-content-center rounded-circle bg-light shadow-sm overflow-hidden" style="width: 80px; height: 80px;">
                                <img src="assets/poultry/<%= species.toLowerCase() %>_<%= rarity.toLowerCase() %>.png"
                                     alt="<%= species %>"
                                     style="width: 100%; height: 100%; object-fit: cover;"
                                     onerror="this.src='https://ui-avatars.com/api/?name=<%= species %>&background=random'">
                            </div>
                            <span class="badge rounded-pill <%= badgeClass %> px-3 py-2"><%= rarity %></span>
                        </div>

                        <h4 class="fw-bold mb-1"><%= item[1] %></h4>
                        <p class="text-muted small mb-4"><%= item[2] %> • Primary champion candidate</p>

                        <div class="mt-auto">
                            <div class="d-flex justify-content-between align-items-center mb-4 p-3 rounded-4 bg-light">
                                <span class="small fw-bold text-muted">Price</span>
                                <span class="fw-bold text-primary"><i class="fas fa-shopping-bag me-1"></i><%= price %></span>
                            </div>

                            <form action="shop" method="POST" class="m-0">
                                <input type="hidden" name="item" value="<%= item[0] %>">
                                <button type="submit" class="<%= (!soldOut && canAfford) ? "btn-gradient" : "btn btn-secondary rounded-pill py-3" %> w-100" <%= (!soldOut && canAfford) ? "" : "disabled" %>>
                                    <%= soldOut ? "SOLD OUT" : (canAfford ? "Buy Poultry" : "Not Enough Currency") %>
                                </button>
                            </form>
                        </div>
                    </div>
                </div>
            <% } %>
        </div>
    </div>
</body>
</html>
