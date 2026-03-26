package dao;

import entity.User;
import utils.DBUtil;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class UserDAO {

    public User login(String email, String password) {
        String sql = "SELECT user_id, username, email, role, phone, " + getActiveSelectSql() + " AS is_active FROM users WHERE email=? AND password=?";

        try (Connection con = DBUtil.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setString(1, email);
            ps.setString(2, password);

            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                return mapUser(rs);
            }

        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }

    public String getRole(int userId) {
        String sql = "SELECT role FROM users WHERE user_id=?";

        try (Connection con = DBUtil.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setInt(1, userId);
            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                return rs.getString("role");
            }

        } catch (Exception e) {
            e.printStackTrace();
        }
        return "user";
    }

    public boolean register(String username, String email, String password) {
        ensureIsActiveColumn();
        String sql = "INSERT INTO users(username,email,password,role,is_active) VALUES(?,?,?,?,?)";

        try (Connection con = DBUtil.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setString(1, username);
            ps.setString(2, email);
            ps.setString(3, password);
            ps.setString(4, "user");
            ps.setBoolean(5, true);

            return ps.executeUpdate() > 0;

        } catch (SQLException ex) {
            String fallbackSql = "INSERT INTO users(username,email,password,role) VALUES(?,?,?,?)";
            try (Connection con = DBUtil.getConnection();
                 PreparedStatement ps = con.prepareStatement(fallbackSql)) {
                ps.setString(1, username);
                ps.setString(2, email);
                ps.setString(3, password);
                ps.setString(4, "user");
                return ps.executeUpdate() > 0;
            } catch (Exception e) {
                e.printStackTrace();
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }

    public boolean checkEmailExists(String email) {
        String sql = "SELECT * FROM users WHERE email=?";

        try (Connection con = DBUtil.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setString(1, email);
            ResultSet rs = ps.executeQuery();

            return rs.next();

        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }

    public boolean updatePassword(String email, String password) {
        String sql = "UPDATE users SET password=? WHERE email=?";

        try (Connection conn = DBUtil.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setString(1, password);
            ps.setString(2, email);

            return ps.executeUpdate() > 0;

        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }

    public List<User> getAllUsers() {
        List<User> list = new ArrayList<>();
        String sql = "SELECT user_id, username, email, role, phone, " + getActiveSelectSql() + " AS is_active FROM users ORDER BY user_id DESC";

        try (Connection con = DBUtil.getConnection();
             PreparedStatement ps = con.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {
                list.add(mapUser(rs));
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }

    public boolean updateUserStatus(int userId, boolean active) {
        ensureIsActiveColumn();
        String sql = "UPDATE users SET is_active=? WHERE user_id=?";

        try (Connection con = DBUtil.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setBoolean(1, active);
            ps.setInt(2, userId);
            return ps.executeUpdate() > 0;
        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }

    public void ensureIsActiveColumn() {
        String checkSql = "SELECT COUNT(*) FROM sys.columns WHERE object_id = OBJECT_ID('dbo.users') AND name = 'is_active'";
        String alterSql = "ALTER TABLE users ADD is_active BIT NOT NULL CONSTRAINT DF_users_is_active DEFAULT 1";

        try (Connection con = DBUtil.getConnection();
             PreparedStatement check = con.prepareStatement(checkSql);
             ResultSet rs = check.executeQuery()) {
            if (rs.next() && rs.getInt(1) == 0) {
                try (PreparedStatement alter = con.prepareStatement(alterSql)) {
                    alter.execute();
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    private String getActiveSelectSql() {
        return hasIsActiveColumn() ? "CAST(is_active AS BIT)" : "CAST(1 AS BIT)";
    }

    private boolean hasIsActiveColumn() {
        String sql = "SELECT COUNT(*) FROM sys.columns WHERE object_id = OBJECT_ID('dbo.users') AND name = 'is_active'";
        try (Connection con = DBUtil.getConnection();
             PreparedStatement ps = con.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            return rs.next() && rs.getInt(1) > 0;
        } catch (Exception e) {
            return false;
        }
    }

    private User mapUser(ResultSet rs) throws SQLException {
        return new User(
                rs.getInt("user_id"),
                rs.getString("username"),
                rs.getString("email"),
                rs.getString("role"),
                rs.getString("phone"),
                rs.getBoolean("is_active")
        );
    }
}
