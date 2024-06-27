package service;

import domain.MesajAplicatie;
import domain.Plata;
import repository.MesajAplicatieRepository;
import repository.PlataRepository;
import utils.Logger;

import java.sql.SQLException;
import java.util.List;

public class ServiceMesajAplicatie {
    //3
    public static void afiseazaUtilizatoriCuInvitatiiLaTurneu(MesajAplicatie[] mesaje) {
        for (MesajAplicatie mesaj : mesaje) {
            if (mesaj.getText().toLowerCase().contains("turneu")) {
                System.out.println("Utilizatorul " + mesaj.getUtilizator().getUsername() + " a primit o invitație la turneu.");
            }
        }
        Logger.log("afiseazaUtilizatoriCuInvitatiiLaTurneu_Etapa1");
    }

    private final MesajAplicatieRepository mesajAplicatieRepository;

    public ServiceMesajAplicatie() {
        this.mesajAplicatieRepository = new MesajAplicatieRepository();
    }

    public void createMesajAplicatie(String username, String titlu, String text) throws SQLException {
        mesajAplicatieRepository.createMesajAplicatie(username, titlu, text);
    }

    public MesajAplicatie getMesajAplicatie(String username, String titlu, String text) throws SQLException {
        return mesajAplicatieRepository.getMesajAplicatie(username, titlu, text);
    }

    public List<MesajAplicatie> getAllMesajeAplicatie() throws SQLException {
        return mesajAplicatieRepository.getAllMesajeAplicatie();
    }

    public void updateMesajAplicatie(String username, String oldTitlu, String oldText, String newTitlu, String newText) throws SQLException {
        mesajAplicatieRepository.updateMesajAplicatie(username, oldTitlu, oldText, newTitlu, newText);
    }

    public void deleteMesajAplicatie(String username, String titlu, String text) throws SQLException {
        mesajAplicatieRepository.deleteMesajAplicatie(username, titlu, text);
    }
}
