package service;

import domain.Plata;
import domain.Utilizator;
import repository.PlataRepository;
import utils.Logger;

import java.sql.SQLException;
import java.util.List;

public class ServicePlata {
    //5

    public static void afiseazaCategoriiMembru(Plata[] plati, Utilizator[] utilizatori) {

        for (Utilizator utilizator : utilizatori) {
            int suma = 0;
            for (Plata plata : plati) {
                if (utilizator == plata.getUtilizator()) {
                    suma += plata.getSuma();
                }
            }
            if (suma >= 50 && suma < 100) {
                System.out.println("Utilizatorul " + utilizator.getUsername() + " este membru bronze.");
            } else if (suma >= 100 && suma < 500) {
                System.out.println("Utilizatorul " + utilizator.getUsername() + " este membru gold.");
            } else if (suma >= 500) {
                System.out.println("Utilizatorul " + utilizator.getUsername() + " este membru diamond.");
            }
        }
        Logger.log("afiseazaCategoriiMembru_Etapa1");
    }

    private final PlataRepository plataRepository;

    public ServicePlata() {
        this.plataRepository = new PlataRepository();
    }

    public void createPlata(String username, int suma, String dataTranzactie) throws SQLException {
        plataRepository.createPlata(username, suma, dataTranzactie);
    }

    public Plata getPlata(String username, int suma, String dataTranzactie) throws SQLException {
        return plataRepository.getPlata(username, suma, dataTranzactie);
    }

    public List<Plata> getAllPlati() throws SQLException {
        return plataRepository.getAllPlati();
    }

    public void updatePlata(String username, int oldSuma, String oldDataTranzactie, int newSuma, String newDataTranzactie) throws SQLException {
        plataRepository.updatePlata(username, oldSuma, oldDataTranzactie, newSuma, newDataTranzactie);
    }

    public void deletePlata(String username, int suma, String dataTranzactie) throws SQLException {
        plataRepository.deletePlata(username, suma, dataTranzactie);
    }
}
