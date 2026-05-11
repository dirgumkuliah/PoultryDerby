package com.poultryderby.controller;

import com.poultryderby.dao.HistoryDAO;
import com.poultryderby.model.UserBean;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.util.List;

@WebServlet("/history")
public class HistoryServlet extends HttpServlet {
    private HistoryDAO historyDAO = new HistoryDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        UserBean user = (UserBean) request.getSession().getAttribute("user");
        if (user == null) {
            response.sendRedirect("index.jsp");
            return;
        }

        List<String> logs = historyDAO.getHistory(user.getId());
        request.setAttribute("historyLogs", logs);
        request.getRequestDispatcher("history.jsp").forward(request, response);
    }
}
