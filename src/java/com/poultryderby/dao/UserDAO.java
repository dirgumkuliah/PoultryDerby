package com.poultryderby.dao;

import com.poultryderby.model.UserBean;
import com.poultryderby.model.Poultry;
import java.sql.*;

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
}
