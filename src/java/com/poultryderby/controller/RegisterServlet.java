package com.poultryderby.controller;

import com.poultryderby.dao.UserDAO;
import com.poultryderby.model.UserBean;

import java.io.IOException;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet(name = "RegisterServlet", urlPatterns = {"/RegisterServlet"})
public class RegisterServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String username = request.getParameter("username");
        String password = request.getParameter("password");

        System.out.println(username);
        System.out.println(password);

        UserBean user = new UserBean();

        user.setUsername(username);
        user.setPassword(password);

        UserDAO dao = new UserDAO();

        boolean success = dao.register(user);

        if(success){

            System.out.println("REGISTER BERHASIL");

            response.sendRedirect("index.jsp?success=1\"");

        } else {

            System.out.println("REGISTER GAGAL");

            response.sendRedirect("register.jsp?error=1");
        }
    }
}