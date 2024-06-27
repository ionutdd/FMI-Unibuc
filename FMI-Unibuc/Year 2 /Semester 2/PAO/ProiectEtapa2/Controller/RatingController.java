package controller;

import domain.Plata;
import domain.Rating;
import service.ServicePlata;
import service.ServiceRating;
import utils.Logger;

import java.sql.SQLException;
import java.util.List;

public class RatingController {
    private final ServiceRating serviceRating;

    public RatingController() {
        this.serviceRating = new ServiceRating();
    }

    public void createRating(String username, int rapid, int blitz, int bullet) {
        try {
            serviceRating.createRating(username, rapid, blitz, bullet);
            System.out.println("Rating creat cu detaliile: " + " username: " + username + ", rapid: " + rapid + ", blitz: " + blitz + ", bullet: " + bullet);
        } catch (SQLException e) {
            e.printStackTrace();
        }
        Logger.log("createRating");
    }

    public void getRating(String username, int rapid, int blitz, int bullet) {
        try {
            Rating rating = serviceRating.getRating(username, rapid, blitz, bullet);
            if (rating != null) {
                System.out.println("Rating pentru utilizatorul mentionat gasit: " + rating);
            } else {
                System.out.println("Rating negasit.");
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        Logger.log("getRating");
    }

    public void getAllRating() {
        try {
            List<Rating> ratings = serviceRating.getAllRating();
            ratings.forEach(System.out::println);
        } catch (SQLException e) {
            e.printStackTrace();
        }
        Logger.log("getAllRating");
    }

    public void updateRating(String username, int oldRapid, int oldBlitz, int oldBullet, int newRapid, int newBlitz, int newBullet) {
        try {
            serviceRating.updateRating(username, oldRapid, oldBlitz, oldBullet, newRapid, newBlitz, newBullet);
            System.out.println("Rating updatat cu succes avand detaliile: " + " username: " + username + ", rapid: " + newRapid + ", blitz " + newBlitz + ", bullet " + newBullet + ".");
        } catch (SQLException e) {
            e.printStackTrace();
        }
        Logger.log("updateRating");
    }

    public void deleteRating(String username, int rapid, int blitz, int bullet) {
        try {
            serviceRating.deleteRating(username, rapid, blitz, bullet);
            System.out.println("Rating sters cu succes avand detaliile: " + " username: " + username + ", rapid: " + rapid + ", blitz: " + blitz + "bullet: " + bullet + ".");
        } catch (SQLException e) {
            e.printStackTrace();
        }
        Logger.log("deleteRating");
    }
}

