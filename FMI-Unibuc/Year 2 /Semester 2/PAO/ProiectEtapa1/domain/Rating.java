package domain;

public class Rating {
    protected Utilizator utilizator;
    protected int rapid;
    protected int blitz;
    protected int bullet;

    public Rating(Utilizator utilizator, int rapid, int blitz, int bullet) {
        this.utilizator = utilizator;
        this.rapid = rapid;
        this.blitz = blitz;
        this.bullet = bullet;
    }

    public Utilizator getUtilizator() {
        return utilizator;
    }

    public void setUtilizator(Utilizator utilizator) {
        this.utilizator = utilizator;
    }

    public int getRapid() {
        return rapid;
    }

    public void setRapid(int rapid) {
        this.rapid = rapid;
    }

    public int getBlitz() {
        return blitz;
    }

    public void setBlitz(int blitz) {
        this.blitz = blitz;
    }

    public int getBullet() {
        return bullet;
    }

    public void setBullet(int bullet) {
        this.bullet = bullet;
    }

    @Override
    public String toString() {
        return "Rating{" +
                "utilizator=" + utilizator +
                ", rapid=" + rapid +
                ", blitz=" + blitz +
                ", bullet=" + bullet +
                '}';
    }
}
