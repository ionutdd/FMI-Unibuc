package repository;

import config.DatabaseConfiguration;
import domain.Utilizator;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class UtilizatorRepository {
    public void create(Utilizator utilizator) throws SQLException {
        String query = "INSERT INTO Utilizator (username, email) VALUES (?, ?)";
        try (Connection connection = DatabaseConfiguration.getConnection();
             PreparedStatement statement = connection.prepareStatement(query)) {
            statement.setString(1, utilizator.getUsername());
            statement.setString(2, utilizator.getEmail());
            statement.executeUpdate();
        }
    }

    public Utilizator read(String username) throws SQLException {
        String query = "SELECT * FROM Utilizator WHERE username = ?";
        try (Connection connection = DatabaseConfiguration.getConnection();
             PreparedStatement statement = connection.prepareStatement(query)) {
            statement.setString(1, username);
            try (ResultSet resultSet = statement.executeQuery()) {
                if (resultSet.next()) {
                    return new Utilizator(
                            resultSet.getString("username"),
                            resultSet.getString("email")
                    );
                }
            }
        }
        return null;
    }

    public List<Utilizator> readAll() throws SQLException {
        List<Utilizator> utilizatori = new ArrayList<>();
        String query = "SELECT * FROM Utilizator";
        try (Connection connection = DatabaseConfiguration.getConnection();
             Statement statement = connection.createStatement();
             ResultSet resultSet = statement.executeQuery(query)) {
            while (resultSet.next()) {
                Utilizator utilizator = new Utilizator(
                        resultSet.getString("username"),
                        resultSet.getString("email")
                );
                utilizatori.add(utilizator);
            }
        }
        return utilizatori;
    }

    public void update(Utilizator utilizator, String oldUsername) throws SQLException {
        String query = "UPDATE Utilizator SET username = ?, email = ? WHERE username = ?";
        try (Connection connection = DatabaseConfiguration.getConnection();
             PreparedStatement statement = connection.prepareStatement(query)) {
            statement.setString(1, utilizator.getUsername());
            statement.setString(2, utilizator.getEmail());
            statement.setString(3, oldUsername);
            statement.executeUpdate();
        }
    }

    public void delete(String username) throws SQLException {
        String query = "DELETE FROM Utilizator WHERE username = ?";
        try (Connection connection = DatabaseConfiguration.getConnection();
             PreparedStatement statement = connection.prepareStatement(query)) {
            statement.setString(1, username);
            statement.executeUpdate();
        }
    }
}
