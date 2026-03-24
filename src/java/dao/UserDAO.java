package dao;

import entity.User;
import utils.DBUtil;
import java.sql.*;

public class UserDAO {

    public User login(String email, String password) {
        String sql = "SELECT * FROM users WHERE email=? AND password=?";

        try (Connection con = DBUtil.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setString(1, email);
            ps.setString(2, password);

            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                return new User(
                        rs.getInt("user_id"),
                        rs.getString("username"),
                        rs.getString("email")
                );
            }

        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }
public String getRole(int userId) {
    String sql = "SELECT r.role_name FROM user_roles ur " +
                 "JOIN roles r ON ur.role_id = r.role_id " +
                 "WHERE ur.user_id = ?";

    try (Connection con = DBUtil.getConnection();
         PreparedStatement ps = con.prepareStatement(sql)) {

        ps.setInt(1, userId);
        ResultSet rs = ps.executeQuery();

        if (rs.next()) {
            return rs.getString("role_name");
        }

    } catch (Exception e) {
        e.printStackTrace();
    }
    return "user"; // default
}
    public boolean register(String username, String email, String password) {
    String sqlUser = "INSERT INTO users(username,email,password) VALUES(?,?,?)";
    String sqlRole = "INSERT INTO user_roles(user_id, role_id) VALUES(?,2)"; // 2 = user

    try (Connection con = DBUtil.getConnection()) {
        con.setAutoCommit(false);

        PreparedStatement ps = con.prepareStatement(sqlUser, Statement.RETURN_GENERATED_KEYS);
        ps.setString(1, username);
        ps.setString(2, email);
        ps.setString(3, password);

        int affected = ps.executeUpdate();

        if (affected == 0) return false;

        ResultSet rs = ps.getGeneratedKeys();
        if (rs.next()) {
            int userId = rs.getInt(1);

            PreparedStatement psRole = con.prepareStatement(sqlRole);
            psRole.setInt(1, userId);
            psRole.executeUpdate();
        }

        con.commit();
        return true;

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
    try {
        Connection conn = DBUtil.getConnection();
        String sql = "UPDATE users SET password=? WHERE email=?";
        PreparedStatement ps = conn.prepareStatement(sql);
        ps.setString(1, password);
        ps.setString(2, email);
        return ps.executeUpdate() > 0;
    } catch (Exception e) {
        e.printStackTrace();
    }
    return false;
}
}