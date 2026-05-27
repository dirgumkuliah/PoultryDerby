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
    public static final int BUY_SUCCESS = 1;
    public static final int BUY_INSUFFICIENT_CURRENCY = 2;
    public static final int BUY_DUPLICATE = 3;
    public static final int BUY_FAILED = 4;

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

    public int buyPoultry(int userId, Poultry poultry, int price) {
        String checkCurrencySql = "SELECT shop_currency FROM users WHERE id = ? FOR UPDATE";
        String checkDuplicateSql = "SELECT id FROM inventory WHERE user_id = ? AND name = ?";
        String insertInventorySql = "INSERT INTO inventory (user_id, species, name, rarity) VALUES (?, ?, ?, ?)";
        String updateCurrencySql = "UPDATE users SET shop_currency = shop_currency - ? WHERE id = ?";

        try (Connection conn = DatabaseConfig.getConnection()) {
            conn.setAutoCommit(false);

            try (PreparedStatement checkCurrency = conn.prepareStatement(checkCurrencySql)) {
                checkCurrency.setInt(1, userId);
                ResultSet currencyResult = checkCurrency.executeQuery();

                if (!currencyResult.next() || currencyResult.getInt("shop_currency") < price) {
                    conn.rollback();
                    return BUY_INSUFFICIENT_CURRENCY;
                }
            }

            try (PreparedStatement checkDuplicate = conn.prepareStatement(checkDuplicateSql)) {
                checkDuplicate.setInt(1, userId);
                checkDuplicate.setString(2, poultry.getName());
                ResultSet duplicateResult = checkDuplicate.executeQuery();

                if (duplicateResult.next()) {
                    conn.rollback();
                    return BUY_DUPLICATE;
                }
            }

            try (PreparedStatement insertInventory = conn.prepareStatement(insertInventorySql);
                 PreparedStatement updateCurrency = conn.prepareStatement(updateCurrencySql)) {
                insertInventory.setInt(1, userId);
                insertInventory.setString(2, poultry.getSpecies());
                insertInventory.setString(3, poultry.getName());
                insertInventory.setString(4, poultry.getRarity());

                updateCurrency.setInt(1, price);
                updateCurrency.setInt(2, userId);

                int inserted = insertInventory.executeUpdate();
                int updated = updateCurrency.executeUpdate();

                if (inserted > 0 && updated > 0) {
                    conn.commit();
                    return BUY_SUCCESS;
                }

                conn.rollback();
            } catch (SQLException e) {
                conn.rollback();
                throw e;
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return BUY_FAILED;
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
