package utils;

import java.io.FileWriter;
import java.io.IOException;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;

public class Logger {
    private static final String LOG_FILE_PATH = "C:\\Users\\ionut\\Desktop\\PAO\\LABS\\ProiectEtapa2\\Etapa2\\src\\log.csv";
    private static final DateTimeFormatter DATE_TIME_FORMATTER = DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss");

    public static void log(String action) {
        String timestamp = LocalDateTime.now().format(DATE_TIME_FORMATTER);
        String logEntry = action + "," + timestamp;

        try (FileWriter writer = new FileWriter(LOG_FILE_PATH, true)) {
            writer.write(logEntry + System.lineSeparator());
            System.out.println("Log entry added: " + logEntry);
        } catch (IOException e) {
            System.err.println("Failed to write log: " + e.getMessage());
        }
    }
}
