package dao;

import entity.Movie;
import utils.DBUtil;
import java.sql.*;
import java.util.*;

public class MovieDAO {

    public List<Movie> getAllMovies() {
        List<Movie> list = new ArrayList<>();
        String sql = "SELECT * FROM movies ORDER BY movie_id DESC";

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

 
    public boolean insertMovie(String title, String poster, String description,
            int duration, String genre, String language, String director, String castList,
            double rating, String ageLimit, String status) {

        String sql = """
            INSERT INTO movies
            (title, poster, description, duration, genre, language,
             director, cast_list, rating, age_limit, status, created_at)
            VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, GETDATE())
        """;

        try (Connection con = DBUtil.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            fillMovieStatement(ps, title, poster, description, duration, genre,
                    language, director, castList, rating, ageLimit, status);

            return ps.executeUpdate() > 0;

        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }

    
    public boolean updateMovie(int movieId, String title, String poster, String description,
            int duration, String genre, String language, String director, String castList,
            double rating, String ageLimit, String status) {

        String sql = """
            UPDATE movies
            SET title = ?, poster = ?, description = ?, duration = ?, genre = ?, language = ?,
                director = ?, cast_list = ?, rating = ?, age_limit = ?, status = ?
            WHERE movie_id = ?
        """;

        try (Connection con = DBUtil.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            fillMovieStatement(ps, title, poster, description, duration, genre,
                    language, director, castList, rating, ageLimit, status);

            ps.setInt(12, movieId);
            return ps.executeUpdate() > 0;

        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }

    public boolean deleteMovie(int movieId) {
        String sql = "DELETE FROM movies WHERE movie_id = ?";
        try (Connection con = DBUtil.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setInt(1, movieId);
            return ps.executeUpdate() > 0;
        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }

    public Movie getMovieById(int id) {
        String sql = "SELECT * FROM movies WHERE movie_id = ?";

        try (Connection con = DBUtil.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setInt(1, id);
            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                return mapMovie(rs);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }

    
    private void fillMovieStatement(PreparedStatement ps, String title, String poster, String description,
            int duration, String genre, String language, String director, String castList,
            double rating, String ageLimit, String status) throws Exception {

        ps.setString(1, title);
        ps.setString(2, poster);
        ps.setString(3, description);
        ps.setInt(4, duration);
        ps.setString(5, genre);
        ps.setString(6, language);
        ps.setString(7, director);
        ps.setString(8, castList);
        ps.setDouble(9, rating);
        ps.setString(10, ageLimit);
        ps.setString(11, status);
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
            rs.getDouble("rating"),
            rs.getString("age_limit"),
            rs.getString("status"),
            rs.getTimestamp("created_at")
        );
    }

    public List<Movie> getMoviesByStatus(String status) {
        List<Movie> list = new ArrayList<>();
        String sql = "SELECT * FROM movies WHERE status = ? ORDER BY movie_id DESC";

        try (Connection con = DBUtil.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setString(1, status);
            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                list.add(mapMovie(rs));
            }

        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }
}