package controller;

import dao.UserDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;

@WebServlet(name = "AdminUserServlet", urlPatterns = {"/adminuser"})
public class AdminUserServlet extends HttpServlet {

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

        UserDAO dao = new UserDAO();
        dao.ensureIsActiveColumn();

        String action = request.getParameter("action");
        String idRaw = request.getParameter("id");

        if (action != null && idRaw != null) {
            int userId = Integer.parseInt(idRaw);
            Object userObj = request.getSession().getAttribute("user");
            int currentUserId = userObj instanceof entity.User ? ((entity.User) userObj).getUserId() : -1;

            if (userId != currentUserId) {
                if ("ban".equals(action)) {
                    dao.updateUserStatus(userId, false);
                } else if ("unban".equals(action)) {
                    dao.updateUserStatus(userId, true);
                }
            }
        }

        request.setAttribute("users", dao.getAllUsers());
        request.getRequestDispatcher("/pages/admin/users.jsp").forward(request, response);
    }
}
