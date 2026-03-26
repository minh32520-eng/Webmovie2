package controller;

import dao.MovieDAO;
import dao.ShowtimeDAO;
import entity.Showtime;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import java.sql.Timestamp;

@WebServlet(name = "AdminShowtimeServlet", urlPatterns = {"/adminshowtime"})
public class AdminShowtimeServlet extends HttpServlet {

    private boolean isAdmin(HttpServletRequest request, HttpServletResponse response) throws IOException {
        HttpSession session = request.getSession(false);
        if (session == null || !"admin".equals(session.getAttribute("role"))) {
            response.sendRedirect(request.getContextPath() + "/pages/login.jsp");
            return false;
        }
        return true;
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        if (!isAdmin(request, response)) return;

        ShowtimeDAO dao = new ShowtimeDAO();
        String action = request.getParameter("action");

        if ("edit".equals(action)) {
            int id = Integer.parseInt(request.getParameter("id"));
            request.setAttribute("editShowtime", dao.getAdminShowtimeById(id));
        } else if ("delete".equals(action)) {
            int id = Integer.parseInt(request.getParameter("id"));
            dao.deleteShowtime(id);
            response.sendRedirect(request.getContextPath() + "/adminshowtime");
            return;
        }

        request.setAttribute("showtimes", dao.getAdminShowtimes());
        request.setAttribute("movies", new MovieDAO().getAllMovies());
        request.setAttribute("rooms", dao.getAllRooms());
        request.getRequestDispatcher("/pages/admin/showtimes.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        if (!isAdmin(request, response)) return;

        request.setCharacterEncoding("UTF-8");
        ShowtimeDAO dao = new ShowtimeDAO();


        String idRaw = request.getParameter("showtime_id");
        String movieIdRaw = request.getParameter("movie_id");
        String roomIdRaw = request.getParameter("room_id");
        String startRaw = request.getParameter("start_time");
        String endRaw = request.getParameter("end_time");
        String priceStdRaw = request.getParameter("price_std");
        String priceVipRaw = request.getParameter("price_vip");
        String priceCoupleRaw = request.getParameter("price_couple");
        String format = request.getParameter("format");
        String status = request.getParameter("status");

        String error = null;

     
        if (movieIdRaw == null || movieIdRaw.isBlank() ||
            roomIdRaw == null || roomIdRaw.isBlank() ||
            startRaw == null || startRaw.isBlank() ||
            endRaw == null || endRaw.isBlank() ||
            priceStdRaw == null || priceStdRaw.isBlank() ||
            priceVipRaw == null || priceVipRaw.isBlank() ||
            priceCoupleRaw == null || priceCoupleRaw.isBlank() ||
            format == null || format.isBlank() ||
            status == null || status.isBlank()) {

            error = "Vui lòng nhập đầy đủ thông tin!";
        }

        int movieId = 0, roomId = 0;
        double priceStd = 0, priceVip = 0, priceCouple = 0;
        Timestamp startTime = null, endTime = null;

        // 
        if (error == null) {
            try {
                movieId = Integer.parseInt(movieIdRaw);
                roomId = Integer.parseInt(roomIdRaw);

                startTime = Timestamp.valueOf(startRaw.replace("T", " ") + ":00");
                endTime = Timestamp.valueOf(endRaw.replace("T", " ") + ":00");

                priceStd = Double.parseDouble(priceStdRaw);
                priceVip = Double.parseDouble(priceVipRaw);
                priceCouple = Double.parseDouble(priceCoupleRaw);

                // ===== 3. Validate logic =====
                if (endTime.before(startTime)) {
                    error = "Thời gian kết thúc phải sau thời gian bắt đầu!";
                }

            } catch (Exception e) {
                error = "Dữ liệu nhập không hợp lệ!";
            }
        }

        //   Nếu lỗi quay lại trang 
        if (error != null) {
            request.setAttribute("error", error);
            request.setAttribute("showtimes", dao.getAdminShowtimes());
            request.setAttribute("movies", new MovieDAO().getAllMovies());
            request.setAttribute("rooms", dao.getAllRooms());
            request.getRequestDispatcher("/pages/admin/showtimes.jsp").forward(request, response);
            return;
        }

        //  Insert hoặc Update 
        if (idRaw == null || idRaw.isBlank()) {
            dao.insertShowtime(movieId, roomId, startTime, endTime,
                    priceStd, priceVip, priceCouple, format, status);
        } else {
            int showtimeId = Integer.parseInt(idRaw);
            dao.updateShowtime(showtimeId, movieId, roomId, startTime, endTime,
                    priceStd, priceVip, priceCouple, format, status);
        }

        response.sendRedirect(request.getContextPath() + "/adminshowtime");
    }
}