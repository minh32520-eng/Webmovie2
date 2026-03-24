package dao;

import entity.Movie;
import utils.DBUtil;
import java.sql.*;
import java.util.*;

public class MovieDAO {

    public List<Movie> getAllMovies() {
        List<Movie> list = new ArrayList<>();
        String sql = "SELECT * FROM movies";

        try (Connection con = DBUtil.getConnection();
             PreparedStatement ps = con.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {
                Movie m = new Movie(
                        rs.getInt("movie_id"),
                        rs.getString("title"),
                        rs.getString("poster"),
                        rs.getString("description"),
                        rs.getInt("duration"),
                        rs.getString("genre"),
                        rs.getString("language"),
                        rs.getString("director"),
                        rs.getString("cast_list"),
                        rs.getDate("release_date"),
                        rs.getDate("end_date"),
                        rs.getDouble("rating"),
                        rs.getString("age_limit"),
                        rs.getString("status"),
                        rs.getDate("created_at")
                );
                list.add(m);
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return list;
    }
    public List<Movie> getComingMovies() {
    List<Movie> list = new ArrayList<>();
    String sql = "SELECT * FROM movies WHERE status = N'coming'";

    try (Connection con = DBUtil.getConnection();
         PreparedStatement ps = con.prepareStatement(sql);
         ResultSet rs = ps.executeQuery()) {

        while (rs.next()) {
            list.add(mapMovie(rs));
        }
    } catch (Exception e) {
        e.printStackTrace();
    }
    return list;
}

public List<Movie> getNowShowing() {
    List<Movie> list = new ArrayList<>();
    String sql = "SELECT * FROM movies WHERE status = N'showing'";

    try (Connection con = DBUtil.getConnection();
         PreparedStatement ps = con.prepareStatement(sql);
         ResultSet rs = ps.executeQuery()) {

        while (rs.next()) {
            list.add(mapMovie(rs));
        }
    } catch (Exception e) {
        e.printStackTrace();
    }
    return list;
}
private Movie mapMovie(ResultSet rs) throws Exception {
    return new Movie(
        rs.getInt("movie_id"),
        rs.getString("title"),
        rs.getString("poster"),
        rs.getString("description"),
        rs.getInt("duration"),
        rs.getString("genre"),
        rs.getString("language"),
        rs.getString("director"),
        rs.getString("cast_list"),
        rs.getDate("release_date"),
        rs.getDate("end_date"),
        rs.getDouble("rating"),
        rs.getString("age_limit"),
        rs.getString("status"),
        rs.getDate("created_at")
    );
}
}