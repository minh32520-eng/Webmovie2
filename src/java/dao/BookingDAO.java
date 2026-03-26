package dao;

import entity.Booking;
import entity.Seat;
import utils.DBUtil;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class BookingDAO {

    //  LẤY GHẾ ĐÃ ĐẶT THEO SUẤT CHIẾU 
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

    //  LẤY LỊCH SỬ ĐẶT VÉ THEO USER 
    public List<Booking> getBookingByUser(int userId) {
        List<Booking> list = new ArrayList<>();

        String sql = """
            SELECT b.*, m.title
            FROM bookings b
            JOIN showtimes s ON b.showtime_id = s.showtime_id
            JOIN movies m ON s.movie_id = m.movie_id
            WHERE b.user_id = ?
            ORDER BY b.created_at DESC
        """;

        try (Connection con = DBUtil.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setInt(1, userId);
            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                Booking b = new Booking();
                b.setBookingId(rs.getInt("booking_id"));
                b.setTotalAmount(rs.getDouble("total_amount"));
                b.setBookingCode(rs.getString("booking_code"));
                b.setPaymentStatus(rs.getString("payment_status"));
                b.setCreatedAt(rs.getTimestamp("created_at"));
                b.setMovieTitle(rs.getString("title"));
                list.add(b);
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return list;
    }

    //  TẠO BOOKING MỚI (trả về bookingId) 
    public int createBooking(int userId, int showtimeId, int totalAmount) {
        String sql = "INSERT INTO bookings (user_id, showtime_id, total_amount, booking_code, payment_status, paid_at) "
                   + "VALUES (?, ?, ?, ?, 'PAID', GETDATE())";

        try (Connection con = DBUtil.getConnection();
             PreparedStatement ps = con.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {

            String bookingCode = "BK" + System.currentTimeMillis();

            ps.setInt(1, userId);
            ps.setInt(2, showtimeId);
            ps.setInt(3, totalAmount);
            ps.setString(4, bookingCode);

            ps.executeUpdate();

            ResultSet rs = ps.getGeneratedKeys();
            if (rs.next()) return rs.getInt(1); // trả về bookingId

        } catch (Exception e) {
            e.printStackTrace();
        }
        return -1;
    }

    //  LẤY BOOKING_CODE VỪA TẠO 
    public String getBookingCodeById(int bookingId) {
        String sql = "SELECT booking_code FROM bookings WHERE booking_id = ?";

        try (Connection con = DBUtil.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setInt(1, bookingId);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) return rs.getString("booking_code");

        } catch (Exception e) {
            e.printStackTrace();
        }
        return "N/A";
    }

    // LƯU GHẾ ĐÃ CHỌN VÀO BOOKING_SEATS
    public void saveBookingSeats(int bookingId, int showtimeId, List<Integer> seatIds, double price) {
        String sql = "INSERT INTO booking_seats(booking_id, showtime_id, seat_id, price) VALUES (?, ?, ?, ?)";

        try (Connection con = DBUtil.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            for (int seatId : seatIds) {
                ps.setInt(1, bookingId);
                ps.setInt(2, showtimeId);
                ps.setInt(3, seatId);
                ps.setDouble(4, price);
                ps.addBatch();
            }
            ps.executeBatch();

        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    // LƯU TỪNG GHẾ VỚI GIÁ RIÊNG (VIP/STD/COUPLE) 
    public void saveBookingSeatWithPrice(int bookingId, int showtimeId, int seatId, int price) {
        String sql = "INSERT INTO booking_seats (booking_id, showtime_id, seat_id, price) VALUES (?, ?, ?, ?)";

        try (Connection con = DBUtil.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setInt(1, bookingId);
            ps.setInt(2, showtimeId);
            ps.setInt(3, seatId);
            ps.setInt(4, price);
            ps.executeUpdate();

        } catch (Exception e) {
            e.printStackTrace();
        }
    }


    public List<Booking> getAllBookingsForAdmin() {
        List<Booking> list = new ArrayList<>();
        String sql = """
            SELECT b.*, u.username, m.title, s.start_time
            FROM bookings b
            JOIN users u ON b.user_id = u.user_id
            JOIN showtimes s ON b.showtime_id = s.showtime_id
            JOIN movies m ON s.movie_id = m.movie_id
            ORDER BY b.created_at DESC
        """;
        try (Connection con = DBUtil.getConnection();
             PreparedStatement ps = con.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            while (rs.next()) {
                Booking b = new Booking();
                b.setBookingId(rs.getInt("booking_id"));
                b.setUserId(rs.getInt("user_id"));
                b.setShowtimeId(rs.getInt("showtime_id"));
                b.setTotalAmount(rs.getDouble("total_amount"));
                b.setPaymentMethod(rs.getString("payment_method"));
                b.setPaymentStatus(rs.getString("payment_status"));
                b.setBookingCode(rs.getString("booking_code"));
                b.setCreatedAt(rs.getTimestamp("created_at"));
                b.setPaidAt(rs.getTimestamp("paid_at"));
                b.setUsername(rs.getString("username"));
                b.setMovieTitle(rs.getString("title"));
                b.setShowtimeStart(rs.getTimestamp("start_time"));
                list.add(b);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }

    public boolean updateBookingStatus(int bookingId, String paymentStatus) {
        String sql = "UPDATE bookings SET payment_status = ?, paid_at = CASE WHEN ? = 'PAID' THEN GETDATE() ELSE paid_at END WHERE booking_id = ?";
        try (Connection con = DBUtil.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setString(1, paymentStatus);
            ps.setString(2, paymentStatus);
            ps.setInt(3, bookingId);
            return ps.executeUpdate() > 0;
        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }

    public boolean deleteBooking(int bookingId) {
        String sql = "DELETE FROM bookings WHERE booking_id = ?";
        try (Connection con = DBUtil.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setInt(1, bookingId);
            return ps.executeUpdate() > 0;
        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }

}
