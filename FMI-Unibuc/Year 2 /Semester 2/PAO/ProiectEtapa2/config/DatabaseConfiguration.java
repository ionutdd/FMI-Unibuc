package config;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class DatabaseConfiguration {
    private static final String URL = "jdbc:mysql://localhost:3307/chessDB";
    private static final String USER = "root";
    private static final String PASSWORD = "chess.com";

    public static Connection getConnection() throws SQLException {
        return DriverManager.getConnection(URL, USER, PASSWORD);
    }
}
