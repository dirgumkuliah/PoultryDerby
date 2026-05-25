package com.poultryderby.controller;

import com.poultryderby.dao.UserDAO;
import com.poultryderby.model.GachaSystem;
import com.poultryderby.model.Poultry;
import com.poultryderby.model.UserBean;
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

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        UserBean user = (UserBean) request.getSession().getAttribute("user");
        if (user == null) {
            response.sendRedirect("index.jsp");
            return;
        }

        int pullCount = getPullCount(request);
        int cost = pullCount == 10 ? 900 : 100;

        if (user.getGachaCurrency() < cost) {
            response.sendRedirect("gacha.jsp?error=insufficient");
            return;
        }

        List<Poultry> pulledPoultries = new ArrayList<>();
        List<Boolean> dupeResults = new ArrayList<>();
        List<Integer> shopGains = new ArrayList<>();
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

            pulledPoultries.add(pulled);
            dupeResults.add(isDupe);
            shopGains.add(shopCurrencyGain);
        }

        userDAO.updateCurrency(user.getId(), -cost, totalShopCurrencyGain);

        // Refresh user session data
        user.setGachaCurrency(user.getGachaCurrency() - cost);
        user.setShopCurrency(user.getShopCurrency() + totalShopCurrencyGain);

        request.setAttribute("pulledPoultries", pulledPoultries);
        request.setAttribute("dupeResults", dupeResults);
        request.setAttribute("shopGains", shopGains);
        request.setAttribute("totalShopGain", totalShopCurrencyGain);
        request.setAttribute("pullCount", pullCount);
        request.getRequestDispatcher("gacha.jsp").forward(request, response);
    }

    private int getPullCount(HttpServletRequest request) {
        String pullCount = request.getParameter("pullCount");
        return "10".equals(pullCount) ? 10 : 1;
    }
}
