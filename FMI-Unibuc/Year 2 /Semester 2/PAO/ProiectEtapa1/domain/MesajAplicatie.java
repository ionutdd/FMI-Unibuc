package domain;

public class MesajAplicatie {
    protected Utilizator utilizator;
    protected String titlu;
    protected String text;

    public MesajAplicatie(Utilizator utilizator, String titlu, String text) {
        this.utilizator = utilizator;
        this.titlu = titlu;
        this.text = text;
    }

    public Utilizator getUtilizator() {
        return utilizator;
    }

    public void setUtilizator(Utilizator utilizator) {
        this.utilizator = utilizator;
    }

    public String getTitlu() {
        return titlu;
    }

    public void setTitlu(String titlu) {
        this.titlu = titlu;
    }

    public String getText() {
        return text;
    }

    public void setText(String text) {
        this.text = text;
    }

    @Override
    public String toString() {
        return "MesajAplicatie{" +
                "utilizator=" + utilizator +
                ", titlu='" + titlu + '\'' +
                ", text='" + text + '\'' +
                '}';
    }
}
