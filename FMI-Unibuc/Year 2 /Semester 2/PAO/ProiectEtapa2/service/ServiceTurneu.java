package service;

import domain.Turneu;
import domain.Utilizator;
import utils.Logger;

import java.util.HashMap;
import java.util.Map;
import java.util.Objects;

public class ServiceTurneu {
    //10
    public static void afiseazaUtilizatoriCuDouaTurnee(Utilizator[] utilizatori, Turneu[] turnee) {
        Map<String, Integer> participariUtilizatori = new HashMap<>();

        for (Turneu turneu : turnee) {
            for (Utilizator utilizatorDinTurneu : turneu.getUtilizatori()) {
                String username = utilizatorDinTurneu.getUsername();
                participariUtilizatori.put(username, participariUtilizatori.getOrDefault(username, 0) + 1);
            }
        }

        for (Utilizator utilizator : utilizatori) {
            String username = utilizator.getUsername();
            int nrParticipari = participariUtilizatori.getOrDefault(username, 0);
            if (nrParticipari >= 2) {
                System.out.println("Utilizatorul " + username + " a jucat la cel putin 2 turnee");
            }
        }
        Logger.log("afiseazaUtilizatoriCuDouaTurnee_Etapa1");
    }
}
