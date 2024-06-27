package domain;

public class Prietenie extends Conexiune {
    private String dataInceput;

    public Prietenie(Utilizator utilizator1, Utilizator utilizator2, String data_inceput) {
        super(utilizator1, utilizator2);
        this.dataInceput = data_inceput;
    }

    public String getData_inceput() {
        return dataInceput;
    }

    public void setData_inceput(String data_inceput) {
        this.dataInceput = data_inceput;
    }

    @Override
    public String toString() {
        return "Prietenie{" +
                "data_inceput='" + dataInceput + '\'' +
                ", utilizator1=" + getUtilizator1() +
                ", utilizator2=" + getUtilizator2() +
                '}';
    }
}
