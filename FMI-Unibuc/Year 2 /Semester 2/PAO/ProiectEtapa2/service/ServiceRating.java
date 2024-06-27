package service;

import domain.Plata;
import domain.Rating;
import domain.Utilizator;
import repository.PlataRepository;
import repository.RatingRepository;
import utils.Logger;

import java.sql.SQLException;
import java.util.Arrays;
import java.util.LinkedList;
import java.util.List;

public class ServiceRating {
    //8
    public static LinkedList<Utilizator> ordoneazaUtilizatoriDupaRatingBlitz(Utilizator[] utilizatori, Rating[] rating) {
        Utilizator[] utilizatoriCopie = Arrays.copyOf(utilizatori, utilizatori.length);

        Arrays.sort(utilizatoriCopie, (u1, u2) -> {
            int ratingBlitzU1 = gasesteRatingBlitz(u1, rating);
            int ratingBlitzU2 = gasesteRatingBlitz(u2, rating);

            return Integer.compare(ratingBlitzU2, ratingBlitzU1);
        });

        LinkedList<Utilizator> utilizatoriLinkedList = new LinkedList<>();
        for (Utilizator utilizator : utilizatoriCopie) {
            utilizatoriLinkedList.add(utilizator);
        }
        Logger.log("gasesteRatingBlitz_Etapa1");
        return utilizatoriLinkedList;
    }

    private static int gasesteRatingBlitz(Utilizator utilizator, Rating[] rating) {
        for (Rating r : rating) {
            if (r.getUtilizator().equals(utilizator)) {
                return r.getBlitz();
            }
        }
        return 0;
    }


    //9

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
        Logger.log("afiseazaUtilizatorCuCelMaiMareRating_Etapa1");

    }





    private final RatingRepository ratingRepository;

    public ServiceRating() {
        this.ratingRepository = new RatingRepository();
    }

    public void createRating(String username, int rapid, int blitz, int bullet) throws SQLException {
        ratingRepository.createRating(username, rapid, blitz, bullet);
    }

    public Rating getRating(String username, int rapid, int blitz, int bullet) throws SQLException {
        return ratingRepository.getRating(username, rapid, blitz, bullet);
    }

    public List<Rating> getAllRating() throws SQLException {
        return ratingRepository.getAllRating();
    }

    public void updateRating(String username, int oldRapid, int oldBlitz, int oldBullet, int newRapid, int newBlitz, int newBullet) throws SQLException {
        ratingRepository.updateRating(username, oldRapid, oldBlitz, oldBullet, newRapid, newBlitz, newBullet);
    }

    public void deleteRating(String username, int rapid, int blitz, int bullet) throws SQLException {
        ratingRepository.deleteRating(username, rapid, blitz, bullet);
    }
}
