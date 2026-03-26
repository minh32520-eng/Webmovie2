package controller;

import dao.UserDAO;
import entity.User;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.*;
import java.io.IOException;

public class AuthServlet extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String action = request.getParameter("action");

        if (action == null) {
            response.sendRedirect("pages/login.jsp");
            return;
        }

        switch (action) {
            case "login":
                login(request, response);
                break;
            case "register":
                register(request, response);
                break;
            case "logout":
                logout(request, response);
                break;
            case "forgot":
                forgotPassword(request, response);
                break;
            case "reset":
                resetPassword(request, response);
                break;
            default:
                response.sendRedirect("home");
        }
    }

    // LOGIN 
    private void login(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        String username = request.getParameter("username");
        String email = request.getParameter("email");
        String password = request.getParameter("password");
        

      
        UserDAO dao = new UserDAO();
        
        User user = dao.login(email, password);

        if (user != null) {
            if (!user.isActive()) {
                request.setAttribute("error", "Tài khoản của bạn đã bị khóa!");
                request.getRequestDispatcher("/pages/login.jsp").forward(request, response);
                return;
            }

            session.setAttribute("user", user);

            String role = dao.getRole(user.getUserId());
            session.setAttribute("role", role);

            if ("admin".equals(role)) {
                response.sendRedirect(request.getContextPath() + "/admin");
            } else {
                response.sendRedirect("home");
            }

        } else {
            request.setAttribute("error", "Email hoặc mật khẩu sai!");
            request.getRequestDispatcher("/pages/login.jsp")
                    .forward(request, response);
        }
    }

    //  REGISTER 
    private void register(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
      HttpSession session = request.getSession();
        String username = request.getParameter("username");
        String email = request.getParameter("email");
        String password = request.getParameter("password");
        String confirm = request.getParameter("confirm");
        
        
          if (!password.equals(confirm)) {
            session.setAttribute("error", "Mật khẩu xác nhận không khớp!");
            request.getRequestDispatcher("/pages/login.jsp").forward(request, response);
            return;
        }

        UserDAO dao = new UserDAO();

        // check email tồn tại
        if (dao.checkEmailExists(email)) {
            request.setAttribute("error", "Email đã tồn tại!");
            request.getRequestDispatcher("/pages/register.jsp")
                    .forward(request, response);
            return;
        }

        boolean success = dao.register(username, email, password);

        if (success) {
            response.sendRedirect("pages/login.jsp");
        } else {
            request.setAttribute("error", "Đăng ký thất bại!");
            request.getRequestDispatcher("/pages/register.jsp")
                    .forward(request, response);
        }
    }

    //  LOGOUT 
    private void logout(HttpServletRequest request, HttpServletResponse response)
            throws IOException {

         HttpSession session = request.getSession(false);
        if (session != null) {
            session.invalidate();
        }
        response.sendRedirect(request.getContextPath() + "/home");
    }

    private void forgotPassword(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String email = request.getParameter("email");

        // nếu chưa nhập email chỉ hiển thị form
        if (email == null) {
            request.getRequestDispatcher("/pages/forgot.jsp").forward(request, response);
            return;
        }

        UserDAO dao = new UserDAO();

        if (!dao.checkEmailExists(email)) {
            request.setAttribute("error", "Email không tồn tại!");
            request.getRequestDispatcher("/pages/forgot.jsp").forward(request, response);
            return;
        }

        String token = String.valueOf(System.currentTimeMillis());

        HttpSession session = request.getSession();
        session.setAttribute("resetToken", token);
        session.setAttribute("resetEmail", email);

        response.sendRedirect("pages/reset.jsp?token=" + token);
    }

    private void resetPassword(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String password = request.getParameter("password");
        String token = request.getParameter("token");

        HttpSession session = request.getSession();
        String savedToken = (String) session.getAttribute("resetToken");
        String email = (String) session.getAttribute("resetEmail");

        if (savedToken == null || !savedToken.equals(token)) {
            request.setAttribute("error", "Token không hợp lệ!");
            request.getRequestDispatcher("/pages/reset.jsp").forward(request, response);
            return;
        }

        UserDAO dao = new UserDAO();
        boolean success = dao.updatePassword(email, password);

        if (success) {
            session.removeAttribute("resetToken");
            session.removeAttribute("resetEmail");
            response.sendRedirect("pages/login.jsp");
        } else {
            request.setAttribute("error", "Reset thất bại!");
            request.getRequestDispatcher("/pages/reset.jsp").forward(request, response);
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }
}
