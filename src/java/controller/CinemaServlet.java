/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;

import dao.CinemaDAO;
import dao.MovieDAO;
import entity.Cinema;
import entity.Movie;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.util.List;

/**
 *
 * @author DELL
 */
public class CinemaServlet extends HttpServlet {

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
   protected void doGet(HttpServletRequest request, HttpServletResponse response)
        throws ServletException, IOException {

   MovieDAO movieDAO = new MovieDAO();
CinemaDAO cinemaDAO = new CinemaDAO();

List<Movie> movies = movieDAO.getMoviesByStatus("NOW_SHOWING");
List<Cinema> cinemas = cinemaDAO.getAllCinemas();

request.setAttribute("movies", movies);
request.setAttribute("cinemas", cinemas);

    request.getRequestDispatcher("/pages/cinema.jsp")
           .forward(request, response);
}
}