package service;

import dao.UserDAO;
import entity.User;

public class UserService {

    UserDAO dao = new UserDAO();

    // LOGIN
    public User login(String email, String password) {
        return dao.login(email, password);
    }

    // LẤY ROLE
    public String getRole(int userId) {
        return dao.getRole(userId);
    }
}