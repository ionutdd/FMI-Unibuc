package domain;

public class Conversatie extends Conexiune {
    private String dataPrimulMesaj;

    public Conversatie(Utilizator utilizator1, Utilizator utilizator2, String dataPrimulMesaj) {
        super(utilizator1, utilizator2);
        this.dataPrimulMesaj = dataPrimulMesaj;
    }

    public String getDataPrimulMesaj() {
        return dataPrimulMesaj;
    }

    public void setDataPrimulMesaj(String dataPrimulMesaj) {
        this.dataPrimulMesaj = dataPrimulMesaj;
    }

    @Override
    public String toString() {
        return "Conversatie{" +
                "dataPrimulMesaj='" + dataPrimulMesaj + '\'' +
                ", utilizator1=" + getUtilizator1() +
                ", utilizator2=" + getUtilizator2() +
                '}';
    }
}
