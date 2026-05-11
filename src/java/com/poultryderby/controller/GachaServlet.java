package com.poultryderby.controller;

import com.poultryderby.dao.UserDAO;
import com.poultryderby.model.GachaSystem;
import com.poultryderby.model.Poultry;
import com.poultryderby.model.UserBean;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;

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

        if (user.getGachaCurrency() < 100) {
            response.sendRedirect("gacha.jsp?error=insufficient");
            return;
        }

        Poultry pulled = gachaSystem.pull();
        boolean isDupe = userDAO.hasPoultry(user.getId(), pulled.getName());
        
        int shopCurrencyGain = 0;
        if (isDupe) {
            shopCurrencyGain = gachaSystem.getDuplicateValue(pulled.getRarity());
            userDAO.updateCurrency(user.getId(), -100, shopCurrencyGain);
        } else {
            userDAO.addToInventory(user.getId(), pulled);
            userDAO.updateCurrency(user.getId(), -100, 0);
        }

        // Refresh user session data
        user.setGachaCurrency(user.getGachaCurrency() - 100);
        user.setShopCurrency(user.getShopCurrency() + shopCurrencyGain);
        
        request.setAttribute("pulledPoultry", pulled);
        request.setAttribute("isDupe", isDupe);
        request.setAttribute("shopGain", shopCurrencyGain);
        request.getRequestDispatcher("gacha.jsp").forward(request, response);
    }
}
