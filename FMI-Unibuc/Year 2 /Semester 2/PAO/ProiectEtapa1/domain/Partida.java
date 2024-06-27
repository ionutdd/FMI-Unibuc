package domain;

public class Partida extends Conexiune {
    protected String pgnPartida;

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
                ", utilizator1=" + utilizator1 +
                ", utilizator2=" + utilizator2 +
                '}';
    }
}
