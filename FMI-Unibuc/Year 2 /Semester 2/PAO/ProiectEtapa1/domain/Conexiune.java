package domain;

public class Conexiune {
    protected Utilizator utilizator1;
    protected Utilizator utilizator2;

    public Conexiune(Utilizator utilizator1, Utilizator utilizator2) {
        this.utilizator1 = utilizator1;
        this.utilizator2 = utilizator2;
    }

    public Utilizator getUtilizator1() {
        return utilizator1;
    }

    public void setUtilizator1(Utilizator utilizator1) {
        this.utilizator1 = utilizator1;
    }

    public Utilizator getUtilizator2() {
        return utilizator2;
    }

    public void setUtilizator2(Utilizator utilizator2) {
        this.utilizator2 = utilizator2;
    }

    @Override
    public String toString() {
        return "Conexiune{" +
                "utilizator1=" + utilizator1 +
                ", utilizator2=" + utilizator2 +
                '}';
    }
}
