package domain;

public class Partida extends Conexiune {
    private String pgnPartida;

    public Partida(Utilizator utilizator1, Utilizator utilizator2, String pgnPartida) {
        super(utilizator1, utilizator2);
        this.pgnPartida = pgnPartida;
    }

    public String getPgnPartida() {
        return pgnPartida;
    }

    public void setPgnPartida(String pgnPartida) {
        this.pgnPartida = pgnPartida;
    }

    @Override
    public String toString() {
        return "Partida{" +
                "pgnPartida='" + pgnPartida + '\'' +
                ", utilizator1=" + getUtilizator1() +
                ", utilizator2=" + getUtilizator2() +
                '}';
    }
}
