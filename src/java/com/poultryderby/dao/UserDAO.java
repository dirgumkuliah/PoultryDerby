package com.poultryderby.dao;

import com.poultryderby.model.Duck;
import com.poultryderby.model.Pheasant;
import com.poultryderby.model.UserBean;
import com.poultryderby.model.Poultry;
import com.poultryderby.model.Turkey;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class UserDAO {
    public UserBean login(String username, String password) {
        String sql = "SELECT * FROM users WHERE username = ? AND password = ?";
        try (Connection conn = DatabaseConfig.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, username);
            ps.setString(2, password);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                UserBean user = new UserBean();
                user.setId(rs.getInt("id"));
                user.setUsername(rs.getString("username"));
                user.setGachaCurrency(rs.getInt("gacha_currency"));
                user.setShopCurrency(rs.getInt("shop_currency"));
                return user;
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    public boolean addToInventory(int userId, Poultry poultry) {
        String sql = "INSERT INTO inventory (user_id, species, name, rarity) VALUES (?, ?, ?, ?)";
        try (Connection conn = DatabaseConfig.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, userId);
            ps.setString(2, poultry.getSpecies());
            ps.setString(3, poultry.getName());
            ps.setString(4, poultry.getRarity());
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    public boolean hasPoultry(int userId, String name) {
        String sql = "SELECT id FROM inventory WHERE user_id = ? AND name = ?";
        try (Connection conn = DatabaseConfig.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, userId);
            ps.setString(2, name);
            ResultSet rs = ps.executeQuery();
            return rs.next();
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    public boolean updateCurrency(int userId, int gachaChange, int shopChange) {
        String sql = "UPDATE users SET gacha_currency = gacha_currency + ?, shop_currency = shop_currency + ? WHERE id = ?";
        try (Connection conn = DatabaseConfig.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, gachaChange);
            ps.setInt(2, shopChange);
            ps.setInt(3, userId);
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }
    public List<Poultry> getUserInventory(int userId) { 
        List<Poultry> list = new ArrayList<>();
        String sql = "SELECT * FROM inventory WHERE user_id = ?";
        try (Connection conn = DatabaseConfig.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, userId);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                String species = rs.getString("species");
                String name = rs.getString("name");
                String rarity = rs.getString("rarity");

                if ("Turkey".equals(species)) list.add(new Turkey(name, rarity));
                else if ("Pheasant".equals(species)) list.add(new Pheasant(name, rarity));
                else list.add(new Duck(name, rarity));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }
    public Poultry getPoultryByName(int userId, String name) {
        String sql = "SELECT * FROM inventory WHERE user_id = ? AND name = ?";
        try (Connection conn = DatabaseConfig.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, userId);
            ps.setString(2, name);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                String species = rs.getString("species");
                String rarity = rs.getString("rarity");
                if ("Turkey".equals(species)) return new Turkey(name, rarity);
                if ("Pheasant".equals(species)) return new Pheasant(name, rarity);
                return new Duck(name, rarity);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }
    
    public boolean register(UserBean user) {

    boolean success = false;

    try {

        Connection conn = DatabaseConfig.getConnection();

        String sql = "INSERT INTO users(username, password) VALUES (?, ?)";

        PreparedStatement ps = conn.prepareStatement(sql);

        ps.setString(1, user.getUsername());
        ps.setString(2, user.getPassword());

        int rows = ps.executeUpdate();

        if (rows > 0) {
            success = true;
        }

        ps.close();
        conn.close();

    } catch (Exception e) {
        e.printStackTrace();
    }

    return success;
    }   
}
