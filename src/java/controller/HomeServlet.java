package controller;

import dao.MovieDAO;
import dao.ShowtimeDAO;
import entity.Movie;
import entity.Showtime;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.util.List;

public class HomeServlet extends HttpServlet {

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // MOVIE 


     MovieDAO dao = new MovieDAO();
        List<Movie> movies = dao.getAllMovies();
        List<Movie> now = dao.getMoviesByStatus("NOW_SHOWING");
        List<Movie> coming = dao.getMoviesByStatus("COMING_SOON");
        List<Movie> special = dao.getMoviesByStatus("SPECIAL_SHOW");

        request.setAttribute("nowMovies", now);
        request.setAttribute("comingMovies", coming);
        request.setAttribute("specialMovies", special);
        
        
        
        //  SHOWTIME HOT 
        ShowtimeDAO showtimeDAO = new ShowtimeDAO();
        List<Showtime> hotShowtimes = showtimeDAO.getHotShowtimes();

        request.setAttribute("hotShowtimes", hotShowtimes);

        //  FORWARD 
        request.getRequestDispatcher("/pages/home.jsp")
               .forward(request, response);
    }
}