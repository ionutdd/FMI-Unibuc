package controller;

import domain.Plata;
import service.ServicePlata;
import utils.Logger;

import java.sql.SQLException;
import java.util.List;

public class PlataController {
    private final ServicePlata servicePlata;

    public PlataController() {
        this.servicePlata = new ServicePlata();
    }

    public void createPlata(String username, int suma, String dataTranzactie) {
        try {
            servicePlata.createPlata(username, suma, dataTranzactie);
            System.out.println("Plata creata cu detaliile: " + " username: " + username + ", suma: " + suma + ", data tranzactie: " + dataTranzactie);
        } catch (SQLException e) {
            e.printStackTrace();
        }
        Logger.log("createPlata");
    }

    public void getPlata(String username, int suma, String dataTranzactie) {
        try {
            Plata plata = servicePlata.getPlata(username, suma, dataTranzactie);
            if (plata != null) {
                System.out.println("Plata gasita: " + plata);
            } else {
                System.out.println("Plata negasita.");
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        Logger.log("getPlata");
    }

    public void getAllPlati() {
        try {
            List<Plata> plati = servicePlata.getAllPlati();
            plati.forEach(System.out::println);
        } catch (SQLException e) {
            e.printStackTrace();
        }
        Logger.log("getAllPlati");
    }

    public void updatePlata(String username, int oldSuma, String oldDataTranzactie, int newSuma, String newDataTranzactie) {
        try {
            servicePlata.updatePlata(username, oldSuma, oldDataTranzactie, newSuma, newDataTranzactie);
            System.out.println("Plata updatata cu succes avand detaliile: " + " username: " + username + ", suma: " + newSuma + ", data tranzactie: " + newDataTranzactie + ".");
        } catch (SQLException e) {
            e.printStackTrace();
        }
        Logger.log("updatePlata");
    }

    public void deletePlata(String username, int suma, String dataTranzactie) {
        try {
            servicePlata.deletePlata(username, suma, dataTranzactie);
            System.out.println("Plata stearsa cu succes avand detaliile: " + " username: " + username + ", suma: " + suma + ", data tranzactie: " + dataTranzactie + ".");
        } catch (SQLException e) {
            e.printStackTrace();
        }
        Logger.log("deletePlata");
    }
}

