package com.poultryderby.controller;

import com.poultryderby.dao.UserDAO;
import com.poultryderby.model.Duck;
import com.poultryderby.model.Pheasant;
import com.poultryderby.model.Poultry;
import com.poultryderby.model.Turkey;
import com.poultryderby.model.UserBean;
import java.io.IOException;
import java.util.HashSet;
import java.util.List;
import java.util.Set;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet(name = "ShopServlet", urlPatterns = {"/shop"})
public class ShopServlet extends HttpServlet {
    private final UserDAO userDAO = new UserDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        UserBean user = (UserBean) request.getSession().getAttribute("user");
        if (user == null) {
            response.sendRedirect("index.jsp");
            return;
        }

        List<Poultry> inventory = userDAO.getUserInventory(user.getId());
        Set<String> ownedPoultryNames = new HashSet<>();
        for (Poultry poultry : inventory) {
            ownedPoultryNames.add(poultry.getName());
        }

        request.setAttribute("ownedPoultryNames", ownedPoultryNames);
        request.getRequestDispatcher("shop.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        UserBean user = (UserBean) request.getSession().getAttribute("user");
        if (user == null) {
            response.sendRedirect("index.jsp");
            return;
        }

        ShopItem item = getShopItem(request.getParameter("item"));
        if (item == null) {
            response.sendRedirect("shop?error=invalid");
            return;
        }

        int result = userDAO.buyPoultry(user.getId(), item.poultry, item.price);

        if (result == UserDAO.BUY_SUCCESS) {
            user.setShopCurrency(user.getShopCurrency() - item.price);
            response.sendRedirect("shop?success=1");
        } else if (result == UserDAO.BUY_DUPLICATE) {
            response.sendRedirect("shop?error=duplicate");
        } else if (result == UserDAO.BUY_INSUFFICIENT_CURRENCY) {
            response.sendRedirect("shop?error=insufficient");
        } else {
            response.sendRedirect("shop?error=failed");
        }
    }

    private ShopItem getShopItem(String itemId) {
        if (itemId == null) {
            return null;
        }

        switch (itemId) {
            case "legend_turkey":
                return new ShopItem(new Turkey("Bourbon Red Turkey", "Legend"), 200);
            case "legend_pheasant":
                return new ShopItem(new Pheasant("Himalayan Moral Pheasant", "Legend"), 200);
            case "legend_duck":
                return new ShopItem(new Duck("Madagascar Pochard Duck", "Legend"), 200);
            case "secret_turkey":
                return new ShopItem(new Turkey("Bronze Turkey", "Secret"), 750);
            case "secret_pheasant":
                return new ShopItem(new Pheasant("Crested Argus Pheasant", "Secret"), 750);
            case "secret_duck":
                return new ShopItem(new Duck("Mergus Serrator Duck", "Secret"), 750);
            case "hack_turkey":
                return new ShopItem(new Turkey("Silver Auburn Turkey", "Hack"), 3000);
            case "hack_pheasant":
                return new ShopItem(new Pheasant("Bornean Peacock Pheasant", "Hack"), 3000);
            case "hack_duck":
                return new ShopItem(new Duck("Donald Duck", "Hack"), 3000);
            default:
                return null;
        }
    }

    private static class ShopItem {
        private final Poultry poultry;
        private final int price;

        private ShopItem(Poultry poultry, int price) {
            this.poultry = poultry;
            this.price = price;
        }
    }
}
