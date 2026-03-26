package dao;

import entity.Seat;
import utils.DBUtil;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

public class SeatDAO {

   public List<Seat> getSeatsByShowtime(int showtimeId) {
    List<Seat> list = new ArrayList<>();

    String sql = """
        SELECT s.*, st.price_std, st.price_vip, st.price_couple
        FROM seats s
        JOIN rooms r ON s.room_id = r.room_id
        JOIN showtimes st ON r.room_id = st.room_id
        WHERE st.showtime_id = ?
    """;

    try (Connection con = DBUtil.getConnection();
         PreparedStatement ps = con.prepareStatement(sql)) {

        ps.setInt(1, showtimeId);
        ResultSet rs = ps.executeQuery();

        while (rs.next()) {
            Seat s = new Seat();
            s.setSeatId(rs.getInt("seat_id"));
            s.setRowLabel(rs.getString("row_label"));
            s.setColNum(rs.getInt("col_num"));
            s.setSeatType(rs.getString("seat_type"));

            //  SET GIÁ THEO LOẠI GHẾ
            double price;
            String type = s.getSeatType();

            if ("VIP".equals(type)) {
                price = rs.getDouble("price_vip");
            } else if ("COUPLE".equals(type)) {
                price = rs.getDouble("price_couple");
            } else {
                price = rs.getDouble("price_std");
            }

            s.setPrice(price); //  QUAN TRỌNG

            list.add(s);
        }

    } catch (Exception e) {
        e.printStackTrace();
    }

    return list;
}
public Seat getSeatById(int id) {
    String sql = "SELECT * FROM seats WHERE seat_id = ?";
    try (Connection con = DBUtil.getConnection();
         PreparedStatement ps = con.prepareStatement(sql)) {

        ps.setInt(1, id);
        ResultSet rs = ps.executeQuery();

        if (rs.next()) {
            Seat s = new Seat();
            s.setSeatId(rs.getInt("seat_id"));
            s.setRowLabel(rs.getString("row_label"));
            s.setColNum(rs.getInt("col_num"));

            //  THÊM DÒNG NÀY
            s.setSeatType(rs.getString("seat_type"));

            return s;
        }
    } catch (Exception e) {
        e.printStackTrace();
    }
    return null;
}
    // LẤY GHẾ ĐÃ ĐẶT
    public List<Integer> getBookedSeats(int showtimeId) {
        List<Integer> list = new ArrayList<>();

        String sql = "SELECT seat_id FROM booking_seats WHERE showtime_id = ?";

        try (Connection con = DBUtil.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setInt(1, showtimeId);
            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                list.add(rs.getInt("seat_id"));
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return list;
    }
    public Seat getSeatByName(String row, int col) {
    String sql = "SELECT * FROM seats WHERE row_label=? AND col_num=?";
    
    try (Connection con = DBUtil.getConnection();
         PreparedStatement ps = con.prepareStatement(sql)) {

        ps.setString(1, row);
        ps.setInt(2, col);

        ResultSet rs = ps.executeQuery();

        if (rs.next()) {
            Seat s = new Seat();
            s.setSeatId(rs.getInt("seat_id"));
            s.setRowLabel(rs.getString("row_label"));
            s.setColNum(rs.getInt("col_num"));
            s.setSeatType(rs.getString("seat_type")); //  QUAN TRỌNG
            return s;
        }

    } catch (Exception e) {
        e.printStackTrace();
    }

    return null;
}
}