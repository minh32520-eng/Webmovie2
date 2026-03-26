/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package utils;

/**
 *
 * @author DELL
 */


import java.sql.Connection;
import java.sql.DriverManager;

public class DBUtil {

    private static final String URL =
        "jdbc:sqlserver://localhost:1433;databaseName=Cinema;encrypt=true;trustServerCertificate=true";

    private static final String USER = "sa";
    private static final String PASSWORD = "123";

    public static Connection getConnection() {
        try {
            Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");
            return DriverManager.getConnection(URL, USER, PASSWORD);
        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }
    
    public static void main(String[] args) {
        DBUtil db=new DBUtil();
        if(db.getConnection()!=null){
            System.out.println("ket noi thanh cong");
        }else {
            System.out.println("ket noi that bai");
        }
                
    }
}