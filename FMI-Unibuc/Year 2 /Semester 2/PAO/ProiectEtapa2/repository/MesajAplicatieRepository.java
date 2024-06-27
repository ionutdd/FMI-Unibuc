package repository;

import config.DatabaseConfiguration;
import domain.MesajAplicatie;
import domain.Utilizator;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class MesajAplicatieRepository {
    public void createMesajAplicatie(String username, String titlu, String text) throws SQLException {
        String query = "INSERT INTO MesajAplicatie (username, titlu, text) VALUES (?, ?, ?)";
        try (Connection connection = DatabaseConfiguration.getConnection();
             PreparedStatement statement = connection.prepareStatement(query)) {
            statement.setString(1, username);
            statement.setString(2, titlu);
            statement.setString(3, text);
            statement.executeUpdate();
        }
    }

    public MesajAplicatie getMesajAplicatie(String username, String titlu, String text) throws SQLException {
        String query = "SELECT * FROM MesajAplicatie WHERE username = ? AND titlu = ? AND text = ?";
        try (Connection connection = DatabaseConfiguration.getConnection();
             PreparedStatement statement = connection.prepareStatement(query)) {
            statement.setString(1, username);
            statement.setString(2, titlu);
            statement.setString(3, text);
            try (ResultSet resultSet = statement.executeQuery()) {
                if (resultSet.next()) {
                    Utilizator utilizator = new Utilizator(resultSet.getString("username"), "");
                    return new MesajAplicatie(utilizator, resultSet.getString("titlu"), resultSet.getString("text"));
                }
            }
        }
        return null;
    }

    public List<MesajAplicatie> getAllMesajeAplicatie() throws SQLException {
        List<MesajAplicatie> mesajAplicatii = new ArrayList<>();
        String query = "SELECT * FROM MesajAplicatie";
        try (Connection connection = DatabaseConfiguration.getConnection();
             Statement statement = connection.createStatement();
             ResultSet resultSet = statement.executeQuery(query)) {
            while (resultSet.next()) {
                Utilizator utilizator = new Utilizator(resultSet.getString("username"), "");
                MesajAplicatie mesajAplicatie = new MesajAplicatie(utilizator, resultSet.getString("titlu"), resultSet.getString("text"));
                mesajAplicatii.add(mesajAplicatie);
            }
        }
        return mesajAplicatii;
    }

    public void updateMesajAplicatie(String username, String oldTitlu, String oldText, String newTitlu, String newText) throws SQLException {
        String query = "UPDATE MesajAplicatie SET titlu = ?, text = ? WHERE username = ? AND titlu = ? AND text = ?";
        try (Connection connection = DatabaseConfiguration.getConnection();
             PreparedStatement statement = connection.prepareStatement(query)) {
            statement.setString(1, newTitlu);
            statement.setString(2, newText);
            statement.setString(3, username);
            statement.setString(4, oldTitlu);
            statement.setString(5, oldText);
            statement.executeUpdate();
        }
    }

    public void deleteMesajAplicatie(String username, String titlu, String text) throws SQLException {
        String query = "DELETE FROM MesajAplicatie WHERE username = ? AND titlu = ? AND text = ?";
        try (Connection connection = DatabaseConfiguration.getConnection();
             PreparedStatement statement = connection.prepareStatement(query)) {
            statement.setString(1, username);
            statement.setString(2, titlu);
            statement.setString(3, text);
            statement.executeUpdate();
        }
    }
}