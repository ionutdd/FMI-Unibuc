package service;

import domain.*;
import utils.Logger;

public class ServicePrietenie {
    //6
    public static Prietenie[] adaugaPrietenie(Prietenie[] prietenii, Prietenie nouaPrietenie) {
        int newSize = prietenii.length + 1;

        Prietenie[] newArray = new Prietenie[newSize];
        System.arraycopy(prietenii, 0, newArray, 0, prietenii.length);
        newArray[newSize - 1] = nouaPrietenie;


        Logger.log("adaugaPrietenie_Etapa1");
        return newArray;
    }

    //7

    public static void afiseazaPrieteniiDupa2023(Prietenie[] prietenii) {
        for (Prietenie prietenie : prietenii) {
            String An = prietenie.getData_inceput().substring(prietenie.getData_inceput().length() - 4);
            int anInceputPrietenie = Integer.parseInt(An);
            if (anInceputPrietenie >= 2024) {
                System.out.println("Prietenia dintre " + prietenie.getUtilizator1().getUsername() + " si " + prietenie.getUtilizator2().getUsername() + " s-a facut dupa data de 31.12.2023");
            }
        }
        Logger.log("afiseazaPrieteniiDupa2023_Etapa1");
    }
}
