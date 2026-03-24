/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package utils;

import jakarta.servlet.http.HttpSession;

public class SessionUtil {

    public static void setUser(HttpSession session, Object user) {
        session.setAttribute("user", user);
    }

    public static Object getUser(HttpSession session) {
        return session.getAttribute("user");
    }

    public static void logout(HttpSession session) {
        session.invalidate();
    }
}