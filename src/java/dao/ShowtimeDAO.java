package dao;

import entity.Showtime;
import utils.DBUtil;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

public class ShowtimeDAO {

    //  Lấy suất chiếu sắp tới
    public List<Showtime> getHotShowtimes() {
        List<Showtime> list = new ArrayList<>();

        String sql = "SELECT * FROM showtimes "
                + "WHERE start_time >= GETDATE() "
                + "ORDER BY start_time";

        try (Connection con = DBUtil.getConnection(); PreparedStatement ps = con.prepareStatement(sql); ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {
                Showtime s = new Showtime();
                s.setShowtimeId(rs.getInt("showtime_id"));
                s.setMovieId(rs.getInt("movie_id"));
                s.setRoomId(rs.getInt("room_id"));
                s.setStartTime(rs.getTimestamp("start_time"));
                s.setEndTime(rs.getTimestamp("end_time"));
                list.add(s);
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return list;
    }

    //  Lấy suất chiếu theo phim 
    public List<Showtime> getShowtimeByMovie(int movieId) {
        List<Showtime> list = new ArrayList<>();

        String sql = "SELECT * FROM showtimes "
                + "WHERE movie_id = ? "
                + "AND start_time >= GETDATE() "
                + 
                "ORDER BY start_time";

        try (Connection con = DBUtil.getConnection(); PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setInt(1, movieId);
            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                Showtime s = new Showtime();
                s.setShowtimeId(rs.getInt("showtime_id"));
                s.setMovieId(rs.getInt("movie_id"));
                s.setRoomId(rs.getInt("room_id"));
                s.setStartTime(rs.getTimestamp("start_time"));
                s.setEndTime(rs.getTimestamp("end_time"));
                list.add(s);
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return list;
    }

    //  Lấy chi tiết suất chiếu
    public Showtime getShowtimeById(int id) {
        String sql = """
            SELECT s.*, 
                   m.title, m.poster,
                   c.name AS cinema_name
            FROM showtimes s
            JOIN movies m ON s.movie_id = m.movie_id
            JOIN rooms r ON s.room_id = r.room_id
            JOIN cinemas c ON r.cinema_id = c.cinema_id
            WHERE s.showtime_id = ?
        """;

        try (Connection con = DBUtil.getConnection(); PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setInt(1, id);
            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                Showtime s = new Showtime();
                s.setShowtimeId(rs.getInt("showtime_id"));
                s.setMovieId(rs.getInt("movie_id"));
                s.setRoomId(rs.getInt("room_id"));
                s.setStartTime(rs.getTimestamp("start_time"));
                s.setEndTime(rs.getTimestamp("end_time"));

                s.setMovieTitle(rs.getString("title"));
                s.setPoster(rs.getString("poster"));
                s.setCinemaName(rs.getString("cinema_name"));

                s.setPriceStd(rs.getDouble("price_std"));
                s.setPriceVip(rs.getDouble("price_vip"));
                s.setPriceCouple(rs.getDouble("price_couple"));

                return s;
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return null;
    }

    //  Lấy roomId
    public int getRoomIdByShowtime(int showtimeId) {
        String sql = "SELECT room_id FROM showtimes WHERE showtime_id = ?";

        try (Connection con = DBUtil.getConnection(); PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setInt(1, showtimeId);
            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                return rs.getInt("room_id");
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return -1;
    }


    //   suất chiếu + movie 
    public List<Showtime> getAllShowtimesWithMovie() {
        return getShowtimesByCinema(-1); // -1 = lấy tất cả rạp
    }

    //  Lấy suất chiếu theo rạp (cinemaId = -1 thì lấy tất cả)
    public List<Showtime> getShowtimesByCinema(int cinemaId) {
        List<Showtime> list = new ArrayList<>();

        String sql = """
        SELECT s.*, m.title, m.poster, m.status, c.name AS cinema_name
        FROM showtimes s
        JOIN movies m ON s.movie_id = m.movie_id
        JOIN rooms r ON s.room_id = r.room_id
        JOIN cinemas c ON r.cinema_id = c.cinema_id
        WHERE s.status = 'ACTIVE'
          AND m.status IN ('NOW_SHOWING', 'SPECIAL_SHOW')
          AND s.start_time >= GETDATE()
    """ + (cinemaId > 0 ? "AND c.cinema_id = ? " : "") +
        "ORDER BY m.movie_id, s.start_time";

        try (Connection con = DBUtil.getConnection(); PreparedStatement ps = con.prepareStatement(sql)) {

            if (cinemaId > 0) {
                ps.setInt(1, cinemaId);
            }
            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                Showtime s = new Showtime();
                s.setShowtimeId(rs.getInt("showtime_id"));
                s.setMovieId(rs.getInt("movie_id"));
                s.setRoomId(rs.getInt("room_id"));
                s.setStartTime(rs.getTimestamp("start_time"));
                s.setEndTime(rs.getTimestamp("end_time"));

                s.setMovieTitle(rs.getString("title"));
                s.setPoster(rs.getString("poster"));
                s.setCinemaName(rs.getString("cinema_name"));

                list.add(s);
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return list;
    }

    //  Tất cả suất chiếu + giá 
    public List<Showtime> getAllShowtimesWithPrice() {
        List<Showtime> list = new ArrayList<>();

        String sql = "SELECT s.*, m.title "
                + "FROM showtimes s "
                + "JOIN movies m ON s.movie_id = m.movie_id "
                + "WHERE s.start_time >= GETDATE()";   

        try (Connection con = DBUtil.getConnection(); PreparedStatement ps = con.prepareStatement(sql); ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {
                Showtime s = new Showtime();
                s.setShowtimeId(rs.getInt("showtime_id"));
                s.setMovieId(rs.getInt("movie_id"));
                s.setStartTime(rs.getTimestamp("start_time"));

                s.setMovieTitle(rs.getString("title"));

                s.setPriceStd(rs.getDouble("price_std"));
                s.setPriceVip(rs.getDouble("price_vip"));
                s.setPriceCouple(rs.getDouble("price_couple"));

                list.add(s);
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return list;
    }



    public List<Showtime> getAdminShowtimes() {
        List<Showtime> list = new ArrayList<>();
        String sql = """
            SELECT s.*, m.title, c.name AS cinema_name, r.room_name
            FROM showtimes s
            JOIN movies m ON s.movie_id = m.movie_id
            JOIN rooms r ON s.room_id = r.room_id
            JOIN cinemas c ON r.cinema_id = c.cinema_id
            ORDER BY s.start_time DESC
        """;
        try (Connection con = DBUtil.getConnection();
             PreparedStatement ps = con.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            while (rs.next()) {
                Showtime s = new Showtime();
                s.setShowtimeId(rs.getInt("showtime_id"));
                s.setMovieId(rs.getInt("movie_id"));
                s.setRoomId(rs.getInt("room_id"));
                s.setStartTime(rs.getTimestamp("start_time"));
                s.setEndTime(rs.getTimestamp("end_time"));
                s.setMovieTitle(rs.getString("title"));
                s.setCinemaName(rs.getString("cinema_name") + " - " + rs.getString("room_name"));
                s.setPriceStd(rs.getDouble("price_std"));
                s.setPriceVip(rs.getDouble("price_vip"));
                s.setPriceCouple(rs.getDouble("price_couple"));
                s.setFormat(rs.getString("format"));
                s.setStatus(rs.getString("status"));
                list.add(s);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }

    public Showtime getAdminShowtimeById(int id) {
        String sql = "SELECT * FROM showtimes WHERE showtime_id = ?";
        try (Connection con = DBUtil.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setInt(1, id);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                Showtime s = new Showtime();
                s.setShowtimeId(rs.getInt("showtime_id"));
                s.setMovieId(rs.getInt("movie_id"));
                s.setRoomId(rs.getInt("room_id"));
                s.setStartTime(rs.getTimestamp("start_time"));
                s.setEndTime(rs.getTimestamp("end_time"));
                s.setPriceStd(rs.getDouble("price_std"));
                s.setPriceVip(rs.getDouble("price_vip"));
                s.setPriceCouple(rs.getDouble("price_couple"));
                s.setFormat(rs.getString("format"));
                s.setStatus(rs.getString("status"));
                return s;
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }

    public java.util.List<entity.Room> getAllRooms() {
        java.util.List<entity.Room> list = new java.util.ArrayList<>();
        String sql = """
            SELECT r.*, c.name AS cinema_name
            FROM rooms r
            JOIN cinemas c ON r.cinema_id = c.cinema_id
            ORDER BY c.name, r.room_name
        """;
        try (Connection con = DBUtil.getConnection();
             PreparedStatement ps = con.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            while (rs.next()) {
                entity.Room room = new entity.Room();
                room.setRoomId(rs.getInt("room_id"));
                room.setCinemaId(rs.getInt("cinema_id"));
                room.setRoomName(rs.getString("cinema_name") + " - " + rs.getString("room_name"));
                room.setRoomType(rs.getString("room_type"));
                room.setTotalRows(rs.getInt("total_rows"));
                room.setTotalCols(rs.getInt("total_cols"));
                list.add(room);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }

    public boolean insertShowtime(int movieId, int roomId, java.sql.Timestamp startTime, java.sql.Timestamp endTime,
            double priceStd, double priceVip, double priceCouple, String format, String status) {
        String sql = """
            INSERT INTO showtimes(movie_id, room_id, start_time, end_time, price_std, price_vip, price_couple, format, status)
            VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?)
        """;
        try (Connection con = DBUtil.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setInt(1, movieId);
            ps.setInt(2, roomId);
            ps.setTimestamp(3, startTime);
            ps.setTimestamp(4, endTime);
            ps.setDouble(5, priceStd);
            ps.setDouble(6, priceVip);
            ps.setDouble(7, priceCouple);
            ps.setString(8, format);
            ps.setString(9, status);
            return ps.executeUpdate() > 0;
        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }

    public boolean updateShowtime(int showtimeId, int movieId, int roomId, java.sql.Timestamp startTime, java.sql.Timestamp endTime,
            double priceStd, double priceVip, double priceCouple, String format, String status) {
        String sql = """
            UPDATE showtimes
            SET movie_id = ?, room_id = ?, start_time = ?, end_time = ?, price_std = ?, price_vip = ?, price_couple = ?, format = ?, status = ?
            WHERE showtime_id = ?
        """;
        try (Connection con = DBUtil.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setInt(1, movieId);
            ps.setInt(2, roomId);
            ps.setTimestamp(3, startTime);
            ps.setTimestamp(4, endTime);
            ps.setDouble(5, priceStd);
            ps.setDouble(6, priceVip);
            ps.setDouble(7, priceCouple);
            ps.setString(8, format);
            ps.setString(9, status);
            ps.setInt(10, showtimeId);
            return ps.executeUpdate() > 0;
        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }

    public boolean deleteShowtime(int showtimeId) {
        String sql = "DELETE FROM showtimes WHERE showtime_id = ?";
        try (Connection con = DBUtil.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setInt(1, showtimeId);
            return ps.executeUpdate() > 0;
        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }

}
