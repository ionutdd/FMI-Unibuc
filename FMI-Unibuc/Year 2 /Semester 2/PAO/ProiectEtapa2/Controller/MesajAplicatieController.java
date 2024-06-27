package controller;

import domain.MesajAplicatie;
import domain.Plata;
import service.ServiceMesajAplicatie;
import service.ServicePlata;
import utils.Logger;

import java.sql.SQLException;
import java.util.List;

public class MesajAplicatieController {
    private final ServiceMesajAplicatie serviceMesajAplicatie;

    public MesajAplicatieController() {
        this.serviceMesajAplicatie = new ServiceMesajAplicatie();
    }

    public void createMesajAplicatie(String username, String titlu, String text) {
        try {
            serviceMesajAplicatie.createMesajAplicatie(username, titlu, text);
            System.out.println("Mesaj Aplicatie creata cu detaliile: " + " username: " + username + ", titlu: " + titlu + ", text: " + text);
        } catch (SQLException e) {
            e.printStackTrace();
        }
        Logger.log("createMesajAplicatie");
    }

    public void getMesajAplicatie(String username, String titlu, String text) {
        try {
            MesajAplicatie mesajAplicatie = serviceMesajAplicatie.getMesajAplicatie(username, titlu, text);
            if (mesajAplicatie != null) {
                System.out.println("MesajAplicatie gasita: " + mesajAplicatie);
            } else {
                System.out.println("MesajAplicatie negasita.");
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        Logger.log("getMesajAplicatie");
    }

    public void getAllMesajeAplicatie() {
        try {
            List<MesajAplicatie> mesajAplicatii = serviceMesajAplicatie.getAllMesajeAplicatie();
            mesajAplicatii.forEach(System.out::println);
        } catch (SQLException e) {
            e.printStackTrace();
        }
        Logger.log("getAllMesajeAplicatie");
    }

    public void updateMesajAplicatie(String username, String oldTitlu, String oldText, String newTitlu, String newText) {
        try {
            serviceMesajAplicatie.updateMesajAplicatie(username, oldTitlu, oldText, newTitlu, newText);
            System.out.println("Mesaj Aplicatie updatat cu succes avand detaliile: " + " username: " + username + ", titlu: " + newTitlu + ", text: " + newText + ".");
        } catch (SQLException e) {
            e.printStackTrace();
        }
        Logger.log("updateMesajAplicatie");
    }

    public void deleteMesajAplicatie(String username, String titlu, String text) {
        try {
            serviceMesajAplicatie.deleteMesajAplicatie(username, titlu, text);
            System.out.println("Mesaj Aplicatie stears cu succes avand detaliile: " + " username: " + username + ", titlu: " + titlu + ", text: " + text + ".");
        } catch (SQLException e) {
            e.printStackTrace();
        }
        Logger.log("deleteMesajAplicatie");
    }
}

