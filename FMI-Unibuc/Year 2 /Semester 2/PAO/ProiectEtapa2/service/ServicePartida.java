package service;

import domain.Partida;
import domain.Plata;
import domain.Utilizator;
import repository.PlataRepository;
import utils.Logger;

import java.sql.SQLException;
import java.util.List;

public class ServicePartida {
    //4
    public static void afiseazaPartideleCuCelPutin20Mutari(Partida[] partide) {
        for (Partida partida : partide) {
            if (partida.getPgnPartida().contains("20")) {
                System.out.println("Partida dintre " + partida.getUtilizator1().getUsername() + " si " + partida.getUtilizator2().getUsername() + " are mai mult de 20 de mutari");
            }
        }
        Logger.log("afiseazaPartideleCuCelPutin20Mutari_Etapa1");
    }
}
