package com.poultryderby.dao;

import com.poultryderby.model.Poultry;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class HistoryDAO {
    public boolean saveCareerHistory(int userId, Poultry poultry, int wins, int losses, int bossWins, String outcome) {
        String sql = "INSERT INTO career_history (user_id, poultry_name, final_attack, final_speed, final_iq, wins, losses, boss_wins, outcome) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?)";
        try (Connection conn = DatabaseConfig.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, userId);
            ps.setString(2, poultry.getName());
            ps.setInt(3, poultry.getAttack());
            ps.setInt(4, poultry.getSpeed());
            ps.setInt(5, poultry.getIq());
            ps.setInt(6, wins);
            ps.setInt(7, losses);
            ps.setInt(8, bossWins);
            ps.setString(9, outcome);
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    public List<String> getHistory(int userId) {
        List<String> history = new ArrayList<>();
        String sql = "SELECT * FROM career_history WHERE user_id = ? ORDER BY career_date DESC";
        try (Connection conn = DatabaseConfig.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, userId);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                String entry = rs.getString("poultry_name") + " | Outcome: " + rs.getString("outcome") + 
                               " | Wins: " + rs.getInt("wins") + " | Attack: " + rs.getInt("final_attack");
                history.add(entry);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return history;
    }
}
