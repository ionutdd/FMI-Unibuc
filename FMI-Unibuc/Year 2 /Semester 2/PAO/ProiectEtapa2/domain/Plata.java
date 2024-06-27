package domain;

public class Plata {
    private Utilizator utilizator;
    private int suma;
    private String dataTranzactie;

    public Plata(Utilizator utilizator, int suma, String data_tranzactie) {
        this.utilizator = utilizator;
        this.suma = suma;
        this.dataTranzactie = data_tranzactie;
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
        return dataTranzactie;
    }

    public void setData_tranzactie(String data_tranzactie) {
        this.dataTranzactie = data_tranzactie;
    }

    @Override
    public String toString() {
        return "Plata{" +
                "utilizator=" + utilizator +
                ", suma=" + suma +
                ", data_tranzactie='" + dataTranzactie + '\'' +
                '}';
    }
}
