package repository;

import config.DatabaseConfiguration;
import domain.Plata;
import domain.Rating;
import domain.Utilizator;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class RatingRepository {
    public void createRating(String username, int rapid, int blitz, int bullet) throws SQLException {
        String query = "INSERT INTO Rating (username, rapid, blitz, bullet) VALUES (?, ?, ?, ?)";
        try (Connection connection = DatabaseConfiguration.getConnection();
             PreparedStatement statement = connection.prepareStatement(query)) {
            statement.setString(1, username);
            statement.setInt(2 , rapid);
            statement.setInt(3 , blitz);
            statement.setInt(4 , bullet);
            statement.executeUpdate();
        }
    }

    public Rating getRating(String username, int rapid, int blitz, int bullet) throws SQLException {
        String query = "SELECT * FROM Rating WHERE username = ?";
        try (Connection connection = DatabaseConfiguration.getConnection();
             PreparedStatement statement = connection.prepareStatement(query)) {
            statement.setString(1, username);
            try (ResultSet resultSet = statement.executeQuery()) {
                if (resultSet.next()) {
                    Utilizator utilizator = new Utilizator(resultSet.getString("username"), "");
                    return new Rating(utilizator, resultSet.getInt("rapid"), resultSet.getInt("blitz"), resultSet.getInt("bullet"));
                }
            }
        }
        return null;
    }

    public List<Rating> getAllRating() throws SQLException {
        List<Rating> ratings = new ArrayList<>();
        String query = "SELECT * FROM Rating";
        try (Connection connection = DatabaseConfiguration.getConnection();
             Statement statement = connection.createStatement();
             ResultSet resultSet = statement.executeQuery(query)) {
            while (resultSet.next()) {
                Utilizator utilizator = new Utilizator(resultSet.getString("username"), "");
                Rating rating = new Rating(utilizator, resultSet.getInt("rapid"), resultSet.getInt("blitz"), resultSet.getInt("bullet"));
                ratings.add(rating);
            }
        }
        return ratings;
    }

    public void updateRating(String username, int oldRapid, int oldBlitz, int oldBullet, int newRapid, int newBlitz, int newBullet) throws SQLException {
        String query = "UPDATE Rating SET rapid = ?, blitz = ?, bullet = ? WHERE username = ?";
        try (Connection connection = DatabaseConfiguration.getConnection();
             PreparedStatement statement = connection.prepareStatement(query)) {
            statement.setInt(1, newRapid);
            statement.setInt(2, newBlitz);
            statement.setInt(3, newBullet);
            statement.setString(4, username);
            statement.executeUpdate();
        }
    }

    public void deleteRating(String username, int rapid, int blitz, int bullet) throws SQLException {
        String query = "DELETE FROM Rating WHERE username = ?";
        try (Connection connection = DatabaseConfiguration.getConnection();
             PreparedStatement statement = connection.prepareStatement(query)) {
            statement.setString(1, username);
            statement.executeUpdate();
        }
    }
}
