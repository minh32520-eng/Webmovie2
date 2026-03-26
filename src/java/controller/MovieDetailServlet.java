package controller;

import dao.MovieDAO;
import dao.ShowtimeDAO;
import entity.Movie;
import entity.Showtime;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.util.List;

public class MovieDetailServlet extends HttpServlet {

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        int id = Integer.parseInt(request.getParameter("id"));

        MovieDAO dao = new MovieDAO();
        Movie movie = dao.getMovieById(id);
         ShowtimeDAO showtime= new ShowtimeDAO();
          List<Showtime> listtime = showtime.getShowtimeByMovie(movie.getMovieId());
                request.setAttribute("showtimes", listtime);
        request.setAttribute("movie", movie);
        request.getRequestDispatcher("/pages/movieDetail.jsp")
               .forward(request, response);
    }
}