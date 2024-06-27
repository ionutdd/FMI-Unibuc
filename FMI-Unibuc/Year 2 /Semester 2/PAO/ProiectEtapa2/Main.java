import controller.MesajAplicatieController;
import controller.PlataController;
import controller.RatingController;
import controller.UtilizatorController;
import domain.*;
import service.*;

import java.util.LinkedList;

public class Main {
    public static void main(String[] args) {

        Utilizator[] utilizatori = new Utilizator[5];
        utilizatori[0] = new Utilizator("ionut", "ionut@gmail.com");
        utilizatori[1] = new Utilizator("alex", "alex@gmail.com");
        utilizatori[2] = new Utilizator("hikaru", "hikaru@gmail.com");
        utilizatori[3] = new Utilizator("carlsenMagnus", "carlsen@gmail.com");
        utilizatori[4] = new Utilizator("gukesh", "gukesh@gmail.com");

        Conversatie[] conversatii = new Conversatie[5];
        conversatii[0] = new Conversatie(utilizatori[0], utilizatori[1], "02.03.2024");
        conversatii[1] = new Conversatie(utilizatori[0], utilizatori[2], "02.02.2024");
        conversatii[2] = new Conversatie(utilizatori[0], utilizatori[3], "02.01.2024");
        conversatii[3] = new Conversatie(utilizatori[3], utilizatori[4], "02.04.2024");
        conversatii[4] = new Conversatie(utilizatori[0], utilizatori[4], "01.01.2024");

        MesajAplicatie[] mesaje = new MesajAplicatie[3];
        mesaje[0] = new MesajAplicatie(utilizatori[0], "Invitatie turneu", "Va invitam la turneul de azi de Titled TUesday!");
        mesaje[1] = new MesajAplicatie(utilizatori[1], "Puncte oferite inapoi", "Ai redobandit 8 puncte din cauza unui cheater care a castigat impotriva ta.");
        mesaje[2] = new MesajAplicatie(utilizatori[2], "Invitatie turneu", "Va invitam la turneul de azi de Titled TUesday!");

        Partida[] partide = new Partida[3];
        partide[0] = new Partida(utilizatori[0], utilizatori[1],
                """
                1.e4 e5 2.Nf3 Nc6 3.Bc4 Bc5 4.b4 Bxb4 5.c3 Ba5 6.d4 exd4 7.O-O
                d3 8.Qb3 Qf6 9.e5 Qg6 10.Re1 Nge7 11.Ba3 b5 12.Qxb5 Rb8 13.Qa4
                Bb6 14.Nbd2 Bb7 15.Ne4 Qf5 16.Bxd3 Qh5 17.Nf6+ gxf6 18.exf6
                Rg8 19.Rad1 Qxf3 20.Rxe7+ Nxe7 21.Qxd7+ Kxd7 22.Bf5+ Ke8
                23.Bd7+ Kf8 24.Bxe7# 1-0)
                """);
        partide[1] = new Partida(utilizatori[0], utilizatori[2],
                """
                1. e4 e6 2. d4 d5 3. Nc3 c5 4. Nf3 Nc6 5. exd5 exd5 6. Be2 Nf6 7. O-O Be7 8. Bg5
                O-O 9. dxc5 Be6 10. Nd4 Bxc5 11. Nxe6 fxe6 12. Bg4 Qd6 13. Bh3 Rae8 14. Qd2 Bb4
                15. Bxf6 Rxf6 16. Rad1 Qc5 17. Qe2 Bxc3 18. bxc3 Qxc3 19. Rxd5 Nd4 20. Qh5 Ref8
                21. Re5 Rh6 22. Qg5 Rxh3 23. Rc5 Qg3 24. hxg3 Ne2# 0-1
                """);
        partide[2] = new Partida(utilizatori[2], utilizatori[3],
                """
                1.e4 e5 2.Nf3 d6 3.d4 Bg4 4.dxe5 Bxf3 5.Qxf3 dxe5 6.Bc4 Nf6 7.Qb3 Qe7 8.Nc3
                c6 9.Bg5 b5 10.Nxb5 cxb5 11.Bxb5+ Nbd7 12.O-O-O Rd8 13.Rxd7 Rxd7 14.Rd1 Qe6
                15.Bxd7+ Nxd7 16.Qb8+ Nxb8 17.Rd8# 1-0
                """);

        Plata[] plati = new Plata[4];
        plati[0] = new Plata(utilizatori[0], 51, "23.03.2024");
        plati[1] = new Plata(utilizatori[0], 51, "24.03.2024");
        plati[2] = new Plata(utilizatori[1], 51, "24.02.2024");
        plati[3] = new Plata(utilizatori[2], 25, "24.02.2024");

        Prietenie[] prietenii = new Prietenie[4];
        prietenii[0] = new Prietenie(utilizatori[0], utilizatori[1], "09.02.2023");
        prietenii[1] = new Prietenie(utilizatori[0], utilizatori[2], "09.02.2022");
        prietenii[2] = new Prietenie(utilizatori[1], utilizatori[2], "09.02.2024");
        prietenii[3] = new Prietenie(utilizatori[2], utilizatori[3], "09.03.2024");

        Rating[] rating = new Rating[5];
        rating[0] = new Rating(utilizatori[0], 2000, 2200, 1850);
        rating[1] = new Rating(utilizatori[1], 1000, 1500, 1650);
        rating[2] = new Rating(utilizatori[2], 3000, 3380, 3300);
        rating[3] = new Rating(utilizatori[3], 3100, 3370, 3250);
        rating[4] = new Rating(utilizatori[4], 3000, 3000, 3000);

        Turneu[] turnee = new Turneu[3];
        Utilizator[] utilizatoriTurneu0 = {utilizatori[0], utilizatori[1], utilizatori[2]};
        turnee[0] = new Turneu(3, "13.04.2024", "1h", utilizatoriTurneu0);

        Utilizator[] utilizatoriTurneu1 = {utilizatori[0], utilizatori[3], utilizatori[4]};
        turnee[1] = new Turneu(3, "14.04.2024", "3h", utilizatoriTurneu1);

        Utilizator[] utilizatoriTurneu2 = {utilizatori[0], utilizatori[1]};
        turnee[2] = new Turneu(2, "15.04.2024", "30min", utilizatoriTurneu2);

        //Etapa 1

        ServiceConversatie serviceConversatie = new ServiceConversatie();
        ServicePrietenie servicePrietenie = new ServicePrietenie();
        ServiceTurneu serviceTurneu = new ServiceTurneu();
        ServiceRating serviceRating = new ServiceRating();
        ServicePlata servicePlata = new ServicePlata();
        ServiceMesajAplicatie serviceMesajAplicatie = new ServiceMesajAplicatie();
        ServicePartida servicePartida = new ServicePartida();



        Conversatie nouaConversatie = new Conversatie(utilizatori[4], utilizatori[2], "02.03.2024");
        conversatii = serviceConversatie.adaugaConversatie(conversatii, nouaConversatie);

        Prietenie nouaPrietenie = new Prietenie(utilizatori[4], utilizatori[1], "04.13.2024");
        prietenii = servicePrietenie.adaugaPrietenie(prietenii, nouaPrietenie);

        System.out.println("Utilizatori cu cel putin doua turnee:");
        serviceTurneu.afiseazaUtilizatoriCuDouaTurnee(utilizatori, turnee);

        System.out.println("\nUtilizatori ordonati dupa rating-ul de blitz:\n");
        LinkedList<Utilizator> utilizatoriDupaRatingBlitz = serviceRating.ordoneazaUtilizatoriDupaRatingBlitz(utilizatori, rating);
        for (Utilizator utilizator : utilizatoriDupaRatingBlitz) {
            System.out.println(utilizator.getUsername());
        }

        System.out.println("\n");
        serviceRating.afiseazaUtilizatorCuCelMaiMareRating(rating);

        System.out.println("\nCategorii de membri:");
        servicePlata.afiseazaCategoriiMembru(plati, utilizatori);

        System.out.println("\nUtilizatori cu conversatii:");
        serviceConversatie.afiseazaUtilizatoriCuConversatii(conversatii);

        System.out.println("\nUtilizatori cu invitatii la turneu:");
        serviceMesajAplicatie.afiseazaUtilizatoriCuInvitatiiLaTurneu(mesaje);

        System.out.println("\nPrieteniile facute dupa 2023:");
        servicePrietenie.afiseazaPrieteniiDupa2023(prietenii);

        System.out.println("\nPartidele cu cel putin 20 de mutari:");
        servicePartida.afiseazaPartideleCuCelPutin20Mutari(partide);



        // Etapa 2


        //Clasa 1, Utilizator

        UtilizatorController controller = new UtilizatorController();

        controller.createUtilizator("ionut", "ionut@gmail.com");
        controller.getUtilizatorByUsername("ionut");
        controller.getUtilizatorByUsername("ionutt");
        controller.getAllUtilizatori();

        controller.updateUtilizator("ionut", "ionutCelMaiTare", "ionut@gmail.com");
        controller.deleteUtilizator("ionutCelMaiTare");

        System.out.println("-----------------------------------------");
        System.out.println("-----------------------------------------");
        System.out.println("-----------------------------------------");



        //Clasa 2, plata

        PlataController plataController = new PlataController();

        plataController.createPlata("ionut", 51, "23.03.2024");
        plataController.getPlata("ionut", 51, "23.03.2024");

        plataController.getAllPlati();
        plataController.updatePlata("ionut", 51, "23.03.2024", 100, "25.03.2024");
        plataController.deletePlata("ionut", 100, "25.03.2024");


        System.out.println("-----------------------------------------");
        System.out.println("-----------------------------------------");
        System.out.println("-----------------------------------------");


        //Clasa 3, MesajAplicatie

        MesajAplicatieController mesajAplicatieController = new MesajAplicatieController();


        mesajAplicatieController.createMesajAplicatie("ionut", "Turneu", "Echipa chess.com te invita la turneu!");
        mesajAplicatieController.getMesajAplicatie("ionut", "Turneu", "Echipa chess.com te invita la turneu!");

        mesajAplicatieController.getAllMesajeAplicatie();
        mesajAplicatieController.updateMesajAplicatie("ionut", "Turenu", "Echipa chess.com te invita la turneu!", "Prietenie creata", "Felicitari! Ai creat o prietenie cu Hikaru!");
        mesajAplicatieController.deleteMesajAplicatie("ionut", "Prietenie creata", "Felicitari! Ai creat o prietenie cu Hikaru!");


        System.out.println("-----------------------------------------");
        System.out.println("-----------------------------------------");
        System.out.println("-----------------------------------------");

        //Clasa 4, Rating

        RatingController ratingController = new RatingController();

        ratingController.createRating("ionut", 2400, 2600, 2300);
        ratingController.getRating("ionut", 2400, 2600, 2300);

        ratingController.getAllRating();
        ratingController.updateRating("ionut", 2400, 2600, 2300, 2500, 2500 ,2500);
        ratingController.deleteRating("ionut", 2500, 2500, 2500);
    }
}