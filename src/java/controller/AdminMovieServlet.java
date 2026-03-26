package controller;

import dao.MovieDAO;
import entity.Movie;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import java.util.List;

@WebServlet(name = "AdminMovieServlet", urlPatterns = {"/adminmovie"})
public class AdminMovieServlet extends HttpServlet {

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

        MovieDAO dao = new MovieDAO();
        String action = request.getParameter("action");

        if ("add".equals(action)) {
            request.getRequestDispatcher("/pages/admin/addmovie.jsp").forward(request, response);
            return;
        }

        if ("edit".equals(action)) {
            int id = Integer.parseInt(request.getParameter("id"));
            Movie movie = dao.getMovieById(id);
            request.setAttribute("movie", movie);
            request.getRequestDispatcher("/pages/admin/addmovie.jsp").forward(request, response);
            return;
        }

        if ("delete".equals(action)) {
            int id = Integer.parseInt(request.getParameter("id"));
            dao.deleteMovie(id);
            response.sendRedirect(request.getContextPath() + "/adminmovie");
            return;
        }

        List<Movie> list = dao.getAllMovies();
        request.setAttribute("movies", list);
        request.getRequestDispatcher("/pages/admin/movies.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        if (!isAdmin(request, response)) return;

        request.setCharacterEncoding("UTF-8");
        MovieDAO dao = new MovieDAO();

        String movieIdRaw = request.getParameter("movie_id");
        String title = request.getParameter("title");
        String poster = request.getParameter("poster");
        String description = request.getParameter("description");
        int duration = parseInt(request.getParameter("duration"), 0);
        String genre = request.getParameter("genre");
        String language = request.getParameter("language");
        String director = request.getParameter("director");
        String castList = request.getParameter("cast_list");
        double rating = parseDouble(request.getParameter("rating"), 0);
        String ageLimit = request.getParameter("age_limit");
        String status = request.getParameter("status");

        if (movieIdRaw == null || movieIdRaw.isBlank()) {
            dao.insertMovie(title, poster, description, duration, genre,
                    language, director, castList,
                    rating, ageLimit, status);
        } else {
            int movieId = Integer.parseInt(movieIdRaw);
            dao.updateMovie(movieId, title, poster, description, duration, genre,
                    language, director, castList,
                    rating, ageLimit, status);
        }

        response.sendRedirect(request.getContextPath() + "/adminmovie");
    }

    private int parseInt(String value, int defaultValue) {
        try { return Integer.parseInt(value); } catch (Exception e) { return defaultValue; }
    }

    private double parseDouble(String value, double defaultValue) {
        try { return Double.parseDouble(value); } catch (Exception e) { return defaultValue; }
    }
}