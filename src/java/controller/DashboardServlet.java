package controller;

import dao.DashboardDAO;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import java.io.IOException;

public class DashboardServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);

    
        if (session == null || !"admin".equals(session.getAttribute("role"))) {
            response.sendRedirect("pages/login.jsp");
            return;
        }

        DashboardDAO dao = new DashboardDAO();

     
        request.setAttribute("totalMovies", dao.getTotalMovies());
        request.setAttribute("totalShowtimes", dao.getTotalShowtimes());
        request.setAttribute("totalBookings", dao.getTotalBookings());
        request.setAttribute("totalRevenue", dao.getTotalRevenue());

        // 👉 forward sang dashboard
        request.getRequestDispatcher("/pages/admin/dashboard.jsp")
               .forward(request, response);
    }
}