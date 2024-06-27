package domain;

import java.util.Arrays;

public class Turneu {
    private int nrUtilizatori;
    private String dataStart;
    private String durata;

    private Utilizator[] utilizatori;

    public Turneu(int nr_utilizatori, String data_Start, String durata, Utilizator[] utilizatori) {
        this.nrUtilizatori = nr_utilizatori;
        this.dataStart = data_Start;
        this.durata = durata;
        this.utilizatori = utilizatori;
    }

    public int getNr_utilizatori() {
        return nrUtilizatori;
    }

    public void setNr_utilizatori(int nr_utilizatori) {
        this.nrUtilizatori = nr_utilizatori;
    }

    public String getData_Start() {
        return dataStart;
    }

    public void setData_Start(String data_Start) {
        this.dataStart = data_Start;
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
                "nr_utilizatori=" + nrUtilizatori +
                ", data_Start='" + dataStart + '\'' +
                ", durata='" + durata + '\'' +
                ", utilizatori=" + Arrays.toString(utilizatori) +
                '}';
    }
}
