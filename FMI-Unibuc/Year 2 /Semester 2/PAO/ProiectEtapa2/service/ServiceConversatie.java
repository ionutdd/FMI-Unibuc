package service;

import domain.*;
import utils.Logger;

import java.util.*;

public class ServiceConversatie {

    //1
    public static Conversatie[] adaugaConversatie(Conversatie[] conversatii, Conversatie nouaConversatie) {
        int newSize = conversatii.length + 1;

        Conversatie[] newArray = new Conversatie[newSize];
        System.arraycopy(conversatii, 0, newArray, 0, conversatii.length);
        newArray[newSize - 1] = nouaConversatie;

        Logger.log("adaugaConversatie_Etapa1");
        return newArray;
    }

    //2
    public static void afiseazaUtilizatoriCuConversatii(Conversatie[] conversatii) {
        Scanner scanner = new Scanner(System.in);
        System.out.println("Introduceti numele utilizatorului pentru a verifica conversatiile:");
        String numeUtilizator = scanner.nextLine();
        scanner.close();

        // Parcurgem conversatiile și verificăm dacă utilizatorul dat are conversații cu alți utilizatori
        for (Conversatie conversatie : conversatii) {
            Utilizator utilizator1 = conversatie.getUtilizator1();
            Utilizator utilizator2 = conversatie.getUtilizator2();
            if (utilizator1.getUsername().equals(numeUtilizator)) {
                System.out.println("Utilizatorul " + utilizator2.getUsername() + " are o conversatie cu " + numeUtilizator);
            }
            if (utilizator2.getUsername().equals(numeUtilizator)) {
                System.out.println("Utilizatorul " + utilizator1.getUsername() + " are o conversatie cu " + numeUtilizator);
            }
        }
        Logger.log("afiseazaUtilizatoriCuConversatii_Etapa1");
    }


}
