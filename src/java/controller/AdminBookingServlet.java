package controller;

import dao.BookingDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;

@WebServlet(name = "AdminBookingServlet", urlPatterns = {"/adminbooking"})
public class AdminBookingServlet extends HttpServlet {

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

        BookingDAO dao = new BookingDAO();
        String action = request.getParameter("action");

        if ("delete".equals(action)) {
            int bookingId = Integer.parseInt(request.getParameter("id"));
            dao.deleteBooking(bookingId);
            response.sendRedirect(request.getContextPath() + "/adminbooking");
            return;
        }

        request.setAttribute("bookings", dao.getAllBookingsForAdmin());
        request.getRequestDispatcher("/pages/admin/bookings.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        if (!isAdmin(request, response)) return;

        int bookingId = Integer.parseInt(request.getParameter("booking_id"));
        String paymentStatus = request.getParameter("payment_status");
        new BookingDAO().updateBookingStatus(bookingId, paymentStatus);
        response.sendRedirect(request.getContextPath() + "/adminbooking");
    }
}
