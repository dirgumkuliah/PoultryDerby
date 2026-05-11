package com.poultryderby.controller;

import com.poultryderby.dao.UserDAO;
import com.poultryderby.model.UserBean;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;

@WebServlet("/auth")
public class AuthServlet extends HttpServlet {
    private UserDAO userDAO = new UserDAO();

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getParameter("action");
        if ("login".equals(action)) {
            UserBean user = userDAO.login(request.getParameter("username"), request.getParameter("password"));
            if (user != null) {
                request.getSession().setAttribute("user", user);
                response.sendRedirect("home.jsp");
            } else {
                response.sendRedirect("index.jsp?error=invalid");
            }
        } else if ("logout".equals(action)) {
            request.getSession().invalidate();
            response.sendRedirect("index.jsp");
        }
    }
}
