package controller;

import domain.Utilizator;
import service.ServiceUtilizator;
import utils.Logger;

import java.sql.SQLException;
import java.util.List;

public class UtilizatorController {
    private ServiceUtilizator serviceUtilizator;

    public UtilizatorController() {
        this.serviceUtilizator = new ServiceUtilizator();
    }

    public void createUtilizator(String username, String email) {
        Utilizator utilizator = new Utilizator(username, email);
        try {
            serviceUtilizator.createUtilizator(utilizator);
            System.out.println("Utilizator creat: " + utilizator);
        } catch (SQLException e) {
            e.printStackTrace();
        }
        Logger.log("createUtilizator");
    }

    public void getUtilizatorByUsername(String username) {
        try {
            Utilizator utilizator = serviceUtilizator.getUtilizatorByUsername(username);
            if (utilizator != null) {
                System.out.println("Utilizator gasit: " + utilizator);
            } else {
                System.out.println("Utilizator negasit cu username-ul: " + username);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        Logger.log("getUtilizatorByUsername");
    }

    public void getAllUtilizatori() {
        try {
            List<Utilizator> utilizatori = serviceUtilizator.getAllUtilizatori();
            utilizatori.forEach(System.out::println);
        } catch (SQLException e) {
            e.printStackTrace();
        }
        Logger.log("getAllUtilizatori");
    }

    public void updateUtilizator(String oldUsername, String newUsername, String email) {
        Utilizator utilizator = new Utilizator(newUsername, email);
        try {
            serviceUtilizator.updateUtilizator(utilizator, oldUsername);
            System.out.println("Utilizator updatat: " + utilizator);
        } catch (SQLException e) {
            e.printStackTrace();
        }
        Logger.log("updateUtilizator");
    }

    public void deleteUtilizator(String username) {
        try {
            serviceUtilizator.deleteUtilizator(username);
            System.out.println("Utilizator sters cu username-ul: " + username);
        } catch (SQLException e) {
            e.printStackTrace();
        }
        Logger.log("deleteUtilizator");
    }
}

