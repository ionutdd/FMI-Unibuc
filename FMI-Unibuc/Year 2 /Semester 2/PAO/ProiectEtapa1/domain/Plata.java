package domain;

public class Plata {
    protected Utilizator utilizator;
    protected int suma;
    protected String data_tranzactie;

    public Plata(Utilizator utilizator, int suma, String data_tranzactie) {
        this.utilizator = utilizator;
        this.suma = suma;
        this.data_tranzactie = data_tranzactie;
    }

    public Utilizator getUtilizator() {
        return utilizator;
    }

    public void setUtilizator(Utilizator utilizator) {
        this.utilizator = utilizator;
    }

    public int getSuma() {
        return suma;
    }

    public void setSuma(int suma) {
        this.suma = suma;
    }

    public String getData_tranzactie() {
        return data_tranzactie;
    }

    public void setData_tranzactie(String data_tranzactie) {
        this.data_tranzactie = data_tranzactie;
    }

    @Override
    public String toString() {
        return "Plata{" +
                "utilizator=" + utilizator +
                ", suma=" + suma +
                ", data_tranzactie='" + data_tranzactie + '\'' +
                '}';
    }
}
