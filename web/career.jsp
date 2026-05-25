<%@page import="com.poultryderby.model.CareerManager" %>
<%@page contentType="text/html" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>

    <head>
        <title>Career Mode</title>
    </head>

    <body class="bg-light">
        <%@include file="header.jsp" %>
        <div class="container">
            <% CareerManager cm = (CareerManager) session.getAttribute("careerManager");
                        if (cm == null) {
                            response.sendRedirect("home.jsp");
                            return;
                        }%>
            <div class="row">
                <div class="col-md-4">
                    <div class="card shadow-sm mb-4">
                        <div class="card-header bg-primary text-white">Poultry Stats</div>
                        <div class="card-body">
                            <h5 class="card-title text-center">
                                <%= cm.getPoultry().getName()%>
                            </h5>
                            <p class="text-muted text-center">
                                <%= cm.getPoultry().getSpecies()%> (<%= cm.getPoultry().getRarity()%>)
                            </p>
                            <hr>
                            <p><strong>Attack:</strong>
                                <%= cm.getPoultry().getAttack()%>
                                <span id="preview-attack" class="text-success fw-bold" style="display: none;"> +<%= cm.getPoultry().getExpectedAttackGain() %></span>
                            </p>
                            <p><strong>Speed:</strong>
                                <%= cm.getPoultry().getSpeed()%>
                                <span id="preview-speed" class="text-success fw-bold" style="display: none;"> +<%= cm.getPoultry().getExpectedSpeedGain() %></span>
                            </p>
                            <p><strong>IQ:</strong>
                                <%= cm.getPoultry().getIq()%>
                                <span id="preview-iq" class="text-success fw-bold" style="display: none;"> +<%= cm.getPoultry().getExpectedIqGain() %></span>
                            </p>
                            <div class="mb-2"><strong>Energy:</strong>
                                <span id="preview-energy-cost" class="text-danger fw-bold" style="display: none;"></span>
                            </div>
                            <div class="progress mb-3">
                                 <div class="progress-bar <%= cm.getPoultry().getEnergy() < 30 ? " bg-danger"
                                                    : "bg-success"%>"
                                 role="progressbar" style="width: <%= cm.getPoultry().getEnergy()%>%">
                                    <%= cm.getPoultry().getEnergy()%>%
                                </div>
                            </div>
                        </div>
                    </div>
                </div>

                <div class="col-md-8">
                    <div class="card shadow-sm">
                        <div class="card-header bg-dark text-white d-flex justify-content-between">
                            <span>Year <%= cm.getYear()%></span>
                            <span>Turn <%= cm.getYearTurn()%> / <%= cm.getMaxYear()%></span>
                        </div>
                        <div class="card-body text-center py-5">
                            <% if (cm.isCareerOver()) {%>
                            <h2 class="text-<%= cm.getOutcome().equals(" Win") ? "success" : "danger"%>
                                ">
                                Career Finished: <%= cm.getOutcome()%>!
                            </h2>
                            <p class="lead">Wins: <%= cm.getWins()%> | Boss Wins: <%= cm.getBossWins()%>
                            </p>
                            <a href="home.jsp" class="btn btn-primary">Return Home</a>
                            <% } else { %>
                            <h3>Select Action</h3>
                            <div class="d-grid gap-3 col-6 mx-auto mt-4">
                                <a href="career?action=turn&type=train_attack" id="btn-train-attack"
                                   class="btn btn-outline-danger btn-lg position-relative">Train Attack
                                   <span class="hover-info badge bg-danger" style="display:none; position:absolute; top:-10px; right:-10px; font-size:0.65rem;">Atk +<%= cm.getPoultry().getExpectedAttackGain() %> | Energy -20</span>
                                </a>
                                <a href="career?action=turn&type=train_speed" id="btn-train-speed"
                                   class="btn btn-outline-info btn-lg position-relative">Train Speed
                                   <span class="hover-info badge bg-info" style="display:none; position:absolute; top:-10px; right:-10px; font-size:0.65rem;">Spd +<%= cm.getPoultry().getExpectedSpeedGain() %> | Energy -20</span>
                                </a>
                                <a href="career?action=turn&type=train_iq" id="btn-train-iq"
                                   class="btn btn-outline-warning btn-lg position-relative">Train IQ
                                   <span class="hover-info badge bg-warning text-dark" style="display:none; position:absolute; top:-10px; right:-10px; font-size:0.65rem;">IQ +<%= cm.getPoultry().getExpectedIqGain() %> | Energy +Regen</span>
                                </a>
                                <a href="career?action=turn&type=rest" id="btn-rest"
                                   class="btn btn-outline-success btn-lg position-relative">Rest (Restore Energy)
                                   <span class="hover-info badge bg-success" style="display:none; position:absolute; top:-10px; right:-10px; font-size:0.65rem;">Energy +40</span>
                                </a>
                                <a href="career?action=turn&type=fight"
                                   class="btn btn-dark btn-lg">Fight / Race</a>
                            </div>
                            <% }%>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <style>
            .btn.position-relative .hover-info {
                transition: opacity 0.25s ease, transform 0.25s ease;
                opacity: 0;
                transform: translateY(5px);
                pointer-events: none;
            }
            .btn.position-relative:hover .hover-info {
                display: inline-block !important;
                opacity: 1;
                transform: translateY(0);
            }
            #preview-attack, #preview-speed, #preview-iq, #preview-energy-cost {
                transition: opacity 0.3s ease;
            }
        </style>
        <script>
            // Fungsi untuk menyalakan dan mematikan efek preview stat + energy cost
            function setupHoverEffect(buttonId, previewSpanId, energyCostText) {
                const btn = document.getElementById(buttonId);
                const preview = document.getElementById(previewSpanId);
                const energyPreview = document.getElementById('preview-energy-cost');

                if (btn && preview) {
                    btn.addEventListener('mouseenter', function () {
                        preview.style.display = 'inline';
                        if (energyPreview && energyCostText) {
                            energyPreview.textContent = energyCostText;
                            energyPreview.style.display = 'inline';
                        }
                    });

                    btn.addEventListener('mouseleave', function () {
                        preview.style.display = 'none';
                        if (energyPreview) {
                            energyPreview.style.display = 'none';
                        }
                    });
                }
            }

            // Terapkan fungsi ke masing-masing tombol dengan info energy cost
            setupHoverEffect('btn-train-attack', 'preview-attack', ' -20');
            setupHoverEffect('btn-train-speed', 'preview-speed', ' -20');
            setupHoverEffect('btn-train-iq', 'preview-iq', ' +Regen');

            // Setup hover untuk tombol rest (hanya energy preview)
            (function() {
                const restBtn = document.getElementById('btn-rest');
                const energyPreview = document.getElementById('preview-energy-cost');
                if (restBtn && energyPreview) {
                    restBtn.addEventListener('mouseenter', function () {
                        energyPreview.textContent = ' +40';
                        energyPreview.className = 'text-success fw-bold';
                        energyPreview.style.display = 'inline';
                    });
                    restBtn.addEventListener('mouseleave', function () {
                        energyPreview.style.display = 'none';
                        energyPreview.className = 'text-danger fw-bold';
                    });
                }
            })();
        </script>                     
    </body>

</html>