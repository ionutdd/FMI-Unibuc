package service;

import domain.*;
import jdk.jshell.execution.Util;

import java.util.*;

public class Service {

    //1
    public static Conversatie[] adaugaConversatie(Conversatie[] conversatii, Conversatie nouaConversatie) {
        int newSize = conversatii.length + 1;

        Conversatie[] newArray = new Conversatie[newSize];
        System.arraycopy(conversatii, 0, newArray, 0, conversatii.length);
        newArray[newSize - 1] = nouaConversatie;

        return newArray;
    }

    //2
    public static Prietenie[] adaugaPrietenie(Prietenie[] prietenii, Prietenie nouaPrietenie) {
        int newSize = prietenii.length + 1;

        Prietenie[] newArray = new Prietenie[newSize];
        System.arraycopy(prietenii, 0, newArray, 0, prietenii.length);
        newArray[newSize - 1] = nouaPrietenie;

        return newArray;
    }

    //3
    public static void afiseazaUtilizatoriCuDouaTurnee(Utilizator[] utilizatori, Turneu[] turnee) {
        for (Utilizator utilizator : utilizatori) {
            int nr = 0;
            for (Turneu turneu : turnee) {
                for (Utilizator utilizatorDinTurneu : turneu.getUtilizatori()) {
                    if (Objects.equals(utilizatorDinTurneu.getUsername(), utilizator.getUsername())) {
                        nr++;
                        break;
                }
                }
            }
            if (nr >= 2) {
                System.out.println("Utilizatorul " + utilizator.getUsername() + " a jucat la cel putin 2 turnee");
            }

        }

    }

    //4
    public static Utilizator[] ordoneazaUtilizatoriDupaRatingBlitz(Utilizator[] utilizatori, Rating[] rating) {
        Utilizator[] utilizatoriCopie = Arrays.copyOf(utilizatori, utilizatori.length);

        Arrays.sort(utilizatoriCopie, (u1, u2) -> {
            int ratingBlitzU1 = gasesteRatingBlitz(u1, rating);
            int ratingBlitzU2 = gasesteRatingBlitz(u2, rating);

            return Integer.compare(ratingBlitzU2, ratingBlitzU1);
        });

        return utilizatoriCopie;
    }

    private static int gasesteRatingBlitz(Utilizator utilizator, Rating[] rating) {
        for (Rating r : rating) {
            if (r.getUtilizator().equals(utilizator)) {
                return r.getBlitz();
            }
        }
        return 0;
    }

    //5

    public static void afiseazaUtilizatorCuCelMaiMareRating(Rating[] rating) {
        Utilizator utilizatorCuCelMaiMareRating = null;
        int sumaMaxima = Integer.MIN_VALUE;

        for (Rating r : rating) {
            int sumaTotala = r.getRapid() + r.getBlitz() + r.getBullet();
            if (sumaTotala > sumaMaxima) {
                sumaMaxima = sumaTotala;
                utilizatorCuCelMaiMareRating = r.getUtilizator();
            }
        }

        System.out.println("Utilizatorul cu cea mai mare suma totala de rating-uri este: " + utilizatorCuCelMaiMareRating.getUsername());

    }

    //6

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
    }

    //7
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
    }


    //8

    public static void afiseazaUtilizatoriCuInvitatiiLaTurneu(MesajAplicatie[] mesaje) {
        for (MesajAplicatie mesaj : mesaje) {
            if (mesaj.getText().toLowerCase().contains("turneu")) {
                System.out.println("Utilizatorul " + mesaj.getUtilizator().getUsername() + " a primit o invitație la turneu.");
            }
        }
    }


    //9

    public static void afiseazaPrieteniiDupa2023(Prietenie[] prietenii) {
        for (Prietenie prietenie : prietenii) {
            String An = prietenie.getData_inceput().substring(prietenie.getData_inceput().length() - 4);
            int anInceputPrietenie = Integer.parseInt(An);
            if (anInceputPrietenie >= 2024) {
                System.out.println("Prietenia dintre " + prietenie.getUtilizator1().getUsername() + " si " + prietenie.getUtilizator2().getUsername() + " s-a facut dupa data de 31.12.2023");
            }

        }
    }

    //10
    public static void afiseazaPartideleCuCelPutin20Mutari(Partida[] partide) {
        for (Partida partida : partide) {
            if (partida.getPgnPartida().contains("20")) {
                System.out.println("Partida dintre " + partida.getUtilizator1().getUsername() + " si " + partida.getUtilizator2().getUsername() + " are mai mult de 20 de mutari");
            }
        }
    }


}
