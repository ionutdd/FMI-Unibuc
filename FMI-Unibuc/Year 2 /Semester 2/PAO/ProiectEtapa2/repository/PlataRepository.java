package repository;

import config.DatabaseConfiguration;
import domain.Plata;
import domain.Utilizator;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class PlataRepository {
    public void createPlata(String username, int suma, String dataTranzactie) throws SQLException {
        String query = "INSERT INTO plata (username, suma, dataTranzactie) VALUES (?, ?, ?)";
        try (Connection connection = DatabaseConfiguration.getConnection();
             PreparedStatement statement = connection.prepareStatement(query)) {
            statement.setString(1, username);
            statement.setInt(2, suma);
            statement.setString(3, dataTranzactie);
            statement.executeUpdate();
        }
    }

    public Plata getPlata(String username, int suma, String dataTranzactie) throws SQLException {
        String query = "SELECT * FROM plata WHERE username = ? AND suma = ? AND dataTranzactie = ?";
        try (Connection connection = DatabaseConfiguration.getConnection();
             PreparedStatement statement = connection.prepareStatement(query)) {
            statement.setString(1, username);
            statement.setInt(2, suma);
            statement.setString(3, dataTranzactie);
            try (ResultSet resultSet = statement.executeQuery()) {
                if (resultSet.next()) {
                    Utilizator utilizator = new Utilizator(resultSet.getString("username"), "");
                    return new Plata(utilizator, resultSet.getInt("suma"), resultSet.getString("dataTranzactie"));
                }
            }
        }
        return null;
    }

    public List<Plata> getAllPlati() throws SQLException {
        List<Plata> plati = new ArrayList<>();
        String query = "SELECT * FROM plata";
        try (Connection connection = DatabaseConfiguration.getConnection();
             Statement statement = connection.createStatement();
             ResultSet resultSet = statement.executeQuery(query)) {
            while (resultSet.next()) {
                Utilizator utilizator = new Utilizator(resultSet.getString("username"), "");
                Plata plata = new Plata(utilizator, resultSet.getInt("suma"), resultSet.getString("dataTranzactie"));
                plati.add(plata);
            }
        }
        return plati;
    }

    public void updatePlata(String username, int oldSuma, String oldDataTranzactie, int newSuma, String newDataTranzactie) throws SQLException {
        String query = "UPDATE plata SET suma = ?, dataTranzactie = ? WHERE username = ? AND suma = ? AND dataTranzactie = ?";
        try (Connection connection = DatabaseConfiguration.getConnection();
             PreparedStatement statement = connection.prepareStatement(query)) {
            statement.setInt(1, newSuma);
            statement.setString(2, newDataTranzactie);
            statement.setString(3, username);
            statement.setInt(4, oldSuma);
            statement.setString(5, oldDataTranzactie);
            statement.executeUpdate();
        }
    }

    public void deletePlata(String username, int suma, String dataTranzactie) throws SQLException {
        String query = "DELETE FROM plata WHERE username = ? AND suma = ? AND dataTranzactie = ?";
        try (Connection connection = DatabaseConfiguration.getConnection();
             PreparedStatement statement = connection.prepareStatement(query)) {
            statement.setString(1, username);
            statement.setInt(2, suma);
            statement.setString(3, dataTranzactie);
            statement.executeUpdate();
        }
    }
}
