package com.poultryderby.controller;

import com.poultryderby.dao.HistoryDAO;
import com.poultryderby.dao.UserDAO;
import com.poultryderby.model.*;
import com.poultryderby.util.GameConstants;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.util.List;

@WebServlet("/career")
public class CareerServlet extends HttpServlet {
    private UserDAO userDAO = new UserDAO();
    private HistoryDAO historyDAO = new HistoryDAO();

   @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getParameter("action");
        HttpSession session = request.getSession();
        UserBean user = (UserBean) session.getAttribute("user");

        if (user == null) {
            response.sendRedirect("index.jsp");
            return;
        }

        if ("select".equals(action)) {
            List<Poultry> inventory = userDAO.getUserInventory(user.getId());
            request.setAttribute("inventory", inventory);
            request.getRequestDispatcher("select_poultry.jsp").forward(request, response);
            
        } else if ("start".equals(action)) {
            String selectedName = request.getParameter("poultryName");
            Poultry p = null;
            
            if (selectedName != null) {
                p = userDAO.getPoultryByName(user.getId(), selectedName);
            }
            
            if (p == null) {
                p = new Turkey("Default Turkey", "Common"); 
            }
            
            CareerManager cm = new CareerManager(p);
            session.setAttribute("careerManager", cm);
            response.sendRedirect("career.jsp");
            
        } else if ("turn".equals(action)) {
            CareerManager cm = (CareerManager) session.getAttribute("careerManager");
            if (cm != null && !cm.isCareerOver()) {
                cm.processTurn(request.getParameter("type"));
                
                if (cm.isCareerOver()) {
                    finalizeCareer(user, cm);
                }
            }
            response.sendRedirect("career.jsp");
        }
    }

    private void finalizeCareer(UserBean user, CareerManager cm) {
        int gachaReward = GameConstants.BASE_COMPLETION_CURRENCY + 
                         (cm.getBossWins() * GameConstants.BOSS_WIN_CURRENCY) + 
                         (cm.getWins() * GameConstants.ENEMY_WIN_CURRENCY);
        
        userDAO.updateCurrency(user.getId(), gachaReward, 0);
        user.setGachaCurrency(user.getGachaCurrency() + gachaReward);
        
        historyDAO.saveCareerHistory(user.getId(), cm.getPoultry(), cm.getWins(), cm.getLosses(), cm.getBossWins(), cm.getOutcome());
    }
}
