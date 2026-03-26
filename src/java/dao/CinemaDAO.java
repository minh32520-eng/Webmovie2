package dao;

import entity.Cinema;
import utils.DBUtil;
import java.sql.*;
import java.util.*;

public class CinemaDAO {

    public List<Cinema> getAllCinemas() {
        List<Cinema> list = new ArrayList<>();
        String sql = "SELECT * FROM cinemas";

        try (Connection con = DBUtil.getConnection();
             PreparedStatement ps = con.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {
                Cinema c = new Cinema();
                c.setCinemaId(rs.getInt("cinema_id"));
                c.setName(rs.getString("name"));
                c.setAddress(rs.getString("address"));
                list.add(c);
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return list;
    }
}