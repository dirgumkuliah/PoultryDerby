<%@page import="com.poultryderby.model.CareerManager" %>
<%@page contentType="text/html" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <title>Poultry Derby - Career Mode</title>
</head>
<body>
    <%@include file="header.jsp" %>
    <div class="container py-5 fade-up">
        <%
            CareerManager cm = (CareerManager) session.getAttribute("careerManager");
            if (cm == null) {
                response.sendRedirect("home.jsp");
                return;
            }
        %>
        <div class="row g-4">
            <div class="col-12 col-lg-4">
                <div class="curved-card p-5">
                    <div class="text-center mb-5">
                        <div class="d-inline-flex p-4 rounded-circle bg-light text-primary fs-1 mb-4 shadow-sm">
                            <i class="fas fa-award"></i>
                        </div>
                        <h3 class="fw-bold text-dark mb-1"><%= cm.getPoultry().getName()%></h3>
                        <p class="small text-muted"><%= cm.getPoultry().getSpecies()%> • <%= cm.getPoultry().getRarity()%></p>
                    </div>

                    <div class="stats mt-5">
                        <div class="mb-4">
                            <div class="d-flex justify-content-between small mb-2">
                                <span class="fw-bold"><i class="fas fa-shield-alt me-1 text-primary"></i> Attack</span>
                                <span class="fw-bold text-primary"><%= cm.getPoultry().getAttack()%> <span id="preview-attack" class="text-success" style="display:none"> +<%= cm.getPoultry().getExpectedAttackGain() %></span></span>
                            </div>
                            <div class="progress" style="height:6px; background: #f1f5f9; border-radius: 10px;">
                                <div class="progress-bar" style="background: var(--blue-gradient); width: <%= (cm.getPoultry().getAttack() / 10.0) %>%"></div>
                            </div>
                        </div>
                        <div class="mb-4">
                            <div class="d-flex justify-content-between small mb-2">
                                <span class="fw-bold"><i class="fas fa-bolt me-1 text-primary"></i> Speed</span>
                                <span class="fw-bold text-primary"><%= cm.getPoultry().getSpeed()%> <span id="preview-speed" class="text-success" style="display:none"> +<%= cm.getPoultry().getExpectedSpeedGain() %></span></span>
                            </div>
                            <div class="progress" style="height:6px; background: #f1f5f9; border-radius: 10px;">
                                <div class="progress-bar" style="background: var(--blue-gradient); width: <%= (cm.getPoultry().getSpeed() / 10.0) %>%"></div>
                            </div>
                        </div>
                        <div class="mb-4">
                            <div class="d-flex justify-content-between small mb-2">
                                <span class="fw-bold"><i class="fas fa-brain me-1 text-primary"></i> IQ</span>
                                <span class="fw-bold text-primary"><%= cm.getPoultry().getIq()%> <span id="preview-iq" class="text-success" style="display:none"> +<%= cm.getPoultry().getExpectedIqGain() %></span></span>
                            </div>
                            <div class="progress" style="height:6px; background: #f1f5f9; border-radius: 10px;">
                                <div class="progress-bar" style="background: var(--blue-gradient); width: <%= (cm.getPoultry().getIq() / 10.0) %>%"></div>
                            </div>
                        </div>
                        <div class="mt-5 pt-4 border-top border-light">
                            <div class="d-flex justify-content-between small mb-2">
                                <span class="fw-bold">Energy</span>
                                <span class="fw-bold <%= cm.getPoultry().getEnergy() < 30 ? "text-danger" : "text-success" %>">
                                    <%= cm.getPoultry().getEnergy()%>% <span id="preview-energy-cost" style="display:none"></span>
                                </span>
                            </div>
                            <div class="progress" style="height:10px; background: #f1f5f9; border-radius: 10px;">
                                <div class="progress-bar <%= cm.getPoultry().getEnergy() < 30 ? "bg-danger" : "bg-success" %>" style="width: <%= cm.getPoultry().getEnergy() %>%"></div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>

            <div class="col-12 col-lg-8">
                <div class="curved-card p-5">
                    <div class="d-flex justify-content-between align-items-center mb-5 pb-3 border-bottom border-light">
                        <span class="badge py-2 px-3 rounded-pill bg-light text-primary border border-primary">YEAR <%= cm.getYear()%></span>
                        <div class="text-muted fw-bold">TURN: <%= cm.getYearTurn()%> / <%= cm.getMaxYear()%></div>
                    </div>

                    <div class="text-center py-4">
                        <% if (cm.isCareerOver()) {%>
                            <div class="py-5">
                                <div class="mb-4 display-1 text-warning"><i class="fas fa-medal"></i></div>
                                <h2 class="display-6 fw-bold mb-5 blue-gradient-text"><%= cm.getOutcome()%>!</h2>
                                <p class="text-muted lead mb-5">Wins: <span class="text-dark fw-bold"><%= cm.getWins()%></span> | Boss Wins: <span class="text-dark fw-bold"><%= cm.getBossWins()%></span></p>
                                <a href="home.jsp" class="btn-gradient px-5">Return Headquarters</a>
                            </div>
                        <% } else { %>
                            <h4 class="fw-bold mb-5">Training Ground</h4>
                            <div class="row g-4 justify-content-center">
                                <div class="col-12 col-sm-6">
                                    <a href="career?action=turn&type=train_attack" id="btn-train-attack" class="btn-outline-blue w-100 py-3">Train Attack</a>
                                </div>
                                <div class="col-12 col-sm-6">
                                    <a href="career?action=turn&type=train_speed" id="btn-train-speed" class="btn-outline-blue w-100 py-3">Train Speed</a>
                                </div>
                                <div class="col-12 col-sm-6">
                                    <a href="career?action=turn&type=train_iq" id="btn-train-iq" class="btn-outline-blue w-100 py-3">Train IQ</a>
                                </div>
                                <div class="col-12 col-sm-6">
                                    <a href="career?action=turn&type=rest" id="btn-rest" class="btn-outline-blue w-100 py-3">Rest & Recover</a>
                                </div>
                                <div class="col-12 mt-5 pt-3">
                                    <a href="career?action=turn&type=fight" class="btn-gradient w-100 py-3 fs-5">
                                        <i class="fas fa-flag-checkered me-2"></i> ENTER COMPETITION
                                    </a>
                                </div>
                            </div>
                        <% }%>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <script>
        function setupHover(btnId, previewId, energyText) {
            const btn = document.getElementById(btnId);
            const preview = document.getElementById(previewId);
            const energyPreview = document.getElementById('preview-energy-cost');
            if (btn && preview) {
                btn.onmouseenter = () => {
                    preview.style.display = 'inline';
                    energyPreview.textContent = energyText;
                    energyPreview.style.display = 'inline';
                };
                btn.onmouseleave = () => {
                    preview.style.display = 'none';
                    energyPreview.style.display = 'none';
                };
            }
        }
        setupHover('btn-train-attack', 'preview-attack', ' (-20)');
        setupHover('btn-train-speed', 'preview-speed', ' (-20)');
        setupHover('btn-train-iq', 'preview-iq', ' (+Regen)');
    </script>
</body>
</html>
