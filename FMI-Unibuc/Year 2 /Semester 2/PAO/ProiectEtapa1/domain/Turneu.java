package domain;

import java.util.Arrays;

public class Turneu {
    protected int nr_utilizatori;
    protected String data_Start;
    protected String durata;

    protected Utilizator[] utilizatori;

    public Turneu(int nr_utilizatori, String data_Start, String durata, Utilizator[] utilizatori) {
        this.nr_utilizatori = nr_utilizatori;
        this.data_Start = data_Start;
        this.durata = durata;
        this.utilizatori = utilizatori;
    }

    public int getNr_utilizatori() {
        return nr_utilizatori;
    }

    public void setNr_utilizatori(int nr_utilizatori) {
        this.nr_utilizatori = nr_utilizatori;
    }

    public String getData_Start() {
        return data_Start;
    }

    public void setData_Start(String data_Start) {
        this.data_Start = data_Start;
    }

    public String getDurata() {
        return durata;
    }

    public void setDurata(String durata) {
        this.durata = durata;
    }

    public Utilizator[] getUtilizatori() {
        return utilizatori;
    }

    public void setUtilizatori(Utilizator[] utilizatori) {
        this.utilizatori = utilizatori;
    }

    @Override
    public String toString() {
        return "Turneu{" +
                "nr_utilizatori=" + nr_utilizatori +
                ", data_Start='" + data_Start + '\'' +
                ", durata='" + durata + '\'' +
                ", utilizatori=" + Arrays.toString(utilizatori) +
                '}';
    }
}
