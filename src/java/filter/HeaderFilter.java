package filter;
import dao.CinemaDAO;
import entity.Cinema;
import jakarta.servlet.Filter;
import jakarta.servlet.FilterChain;
import jakarta.servlet.ServletException;
import jakarta.servlet.ServletRequest;
import jakarta.servlet.ServletResponse;
import jakarta.servlet.annotation.WebFilter;
import jakarta.servlet.http.HttpServletRequest;
import java.io.IOException;
import java.util.List;

@WebFilter("/*")
public class HeaderFilter implements Filter {

    public void doFilter(ServletRequest request, ServletResponse response,
                         FilterChain chain)
            throws IOException, ServletException {

        HttpServletRequest req = (HttpServletRequest) request;

        CinemaDAO dao = new CinemaDAO();
        List<Cinema> cinemas = dao.getAllCinemas();

        req.setAttribute("cinemas", cinemas);

        chain.doFilter(request, response);
    }
}