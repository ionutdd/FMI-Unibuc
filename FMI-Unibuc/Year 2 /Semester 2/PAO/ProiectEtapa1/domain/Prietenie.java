package domain;

public class Prietenie extends Conexiune {
    protected String data_inceput;

    public Prietenie(Utilizator utilizator1, Utilizator utilizator2, String data_inceput) {
        super(utilizator1, utilizator2);
        this.data_inceput = data_inceput;
    }

    public String getData_inceput() {
        return data_inceput;
    }

    public void setData_inceput(String data_inceput) {
        this.data_inceput = data_inceput;
    }

    @Override
    public String toString() {
        return "Prietenie{" +
                "data_inceput='" + data_inceput + '\'' +
                ", utilizator1=" + utilizator1 +
                ", utilizator2=" + utilizator2 +
                '}';
    }
}
