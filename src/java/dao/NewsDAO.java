package dao;

import entity.News;
import utils.DBUtil;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import java.util.ArrayList;
import java.util.List;

public class NewsDAO {

    public List<News> getByType(String type) {
        List<News> list = new ArrayList<>();
        String sql = "SELECT * FROM news WHERE type = ? ORDER BY created_at DESC";

        try (Connection con = DBUtil.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setString(1, type);
            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                News n = new News();
                n.setNewsId(rs.getInt("news_id"));
                n.setTitle(rs.getString("title"));
                n.setContent(rs.getString("content"));
                n.setImage(rs.getString("image"));
                n.setType(rs.getString("type"));
                n.setCreatedAt(rs.getTimestamp("created_at"));
                list.add(n);
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return list;
    }
}