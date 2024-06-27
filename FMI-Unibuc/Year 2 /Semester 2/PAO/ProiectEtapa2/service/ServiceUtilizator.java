package service;

import domain.Utilizator;
import repository.UtilizatorRepository;

import java.sql.SQLException;
import java.util.List;

public class ServiceUtilizator {
    private UtilizatorRepository utilizatorRepository;

    public ServiceUtilizator() {
        this.utilizatorRepository = new UtilizatorRepository();
    }

    public void createUtilizator(Utilizator utilizator) throws SQLException {
        utilizatorRepository.create(utilizator);
    }

    public Utilizator getUtilizatorByUsername(String username) throws SQLException {
        return utilizatorRepository.read(username);
    }

    public List<Utilizator> getAllUtilizatori() throws SQLException {
        return utilizatorRepository.readAll();
    }

    public void updateUtilizator(Utilizator utilizator, String oldUsername) throws SQLException {
        utilizatorRepository.update(utilizator, oldUsername);
    }

    public void deleteUtilizator(String username) throws SQLException {
        utilizatorRepository.delete(username);
    }
}
