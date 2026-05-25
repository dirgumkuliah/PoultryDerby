package com.poultryderby.controller;

import com.poultryderby.dao.UserDAO;
import com.poultryderby.model.GachaSystem;
import com.poultryderby.model.Poultry;
import com.poultryderby.model.UserBean;
import com.poultryderby.util.GameConstants;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

@WebServlet("/gacha")
public class GachaServlet extends HttpServlet {
    private GachaSystem gachaSystem = new GachaSystem();
    private UserDAO userDAO = new UserDAO();

    public static class GachaResult {
        private Poultry poultry;
        private boolean duplicate;
        private int shopGain;

        public GachaResult(Poultry poultry, boolean duplicate, int shopGain) {
            this.poultry = poultry;
            this.duplicate = duplicate;
            this.shopGain = shopGain;
        }

        public Poultry getPoultry() { return poultry; }
        public boolean isDuplicate() { return duplicate; }
        public int getShopGain() { return shopGain; }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        UserBean user = (UserBean) request.getSession().getAttribute("user");
        if (user == null) {
            response.sendRedirect("index.jsp");
            return;
        }

        int pullCount = getPullCount(request);
        int totalCost = pullCount == 10 ? GameConstants.GACHA_TEN_PULL_COST : GameConstants.GACHA_PULL_COST;

        if (user.getGachaCurrency() < totalCost) {
            response.sendRedirect("gacha.jsp?error=insufficient");
            return;
        }

        List<GachaResult> results = new ArrayList<>();
        int totalShopCurrencyGain = 0;

        for (int i = 0; i < pullCount; i++) {
            Poultry pulled = gachaSystem.pull();
            boolean isDupe = userDAO.hasPoultry(user.getId(), pulled.getName());
            int shopCurrencyGain = 0;

            if (isDupe) {
                shopCurrencyGain = gachaSystem.getDuplicateValue(pulled.getRarity());
                totalShopCurrencyGain += shopCurrencyGain;
            } else {
                userDAO.addToInventory(user.getId(), pulled);
            }

            results.add(new GachaResult(pulled, isDupe, shopCurrencyGain));
        }

        userDAO.updateCurrency(user.getId(), -totalCost, totalShopCurrencyGain);

        // Refresh user session data
        user.setGachaCurrency(user.getGachaCurrency() - totalCost);
        user.setShopCurrency(user.getShopCurrency() + totalShopCurrencyGain);
        
        request.setAttribute("gachaResults", results);
        request.setAttribute("pullCount", pullCount);
        request.setAttribute("totalShopGain", totalShopCurrencyGain);
        request.getRequestDispatcher("gacha.jsp").forward(request, response);
    }

    private int getPullCount(HttpServletRequest request) {
        try {
            int pullCount = Integer.parseInt(request.getParameter("pullCount"));
            return pullCount == 10 ? 10 : 1;
        } catch (NumberFormatException e) {
            return 1;
        }
    }
}
