package dao;

import entity.Showtime;
import utils.DBUtil;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

public class ShowtimeDAO {

    public List<Showtime> getHotShowtimes() {
        List<Showtime> list = new ArrayList<>();

        String sql = "SELECT TOP 8 * FROM showtimes " +
                     "WHERE CAST(start_time AS DATE) = CAST(GETDATE() AS DATE) " +
                     "ORDER BY start_time";

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

                list.add(s);
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return list;
    }
}