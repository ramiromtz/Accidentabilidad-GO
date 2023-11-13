package Modelo;

import java.sql.*;
import java.sql.Connection;
import java.sql.DriverManager;

public class Conexion {
    public static Statement ps;
    public static ResultSet rt; 
    private final String bdName = "accidentabilidad_go";
    private final String servidor = "jdbc:postgresql://localhost/" + bdName;
    private final String usuario = "postgres";
    private final String clave = "root";

    public Connection conectar() {
            Connection conn = null;

            try {
                    Class.forName("org.postgresql.Driver");
                    conn = DriverManager.getConnection(servidor, usuario, clave);
            } catch (ClassNotFoundException | SQLException e) {
                    System.out.println("Error al conectar" + e.getMessage());
            }

            return conn;
    }
}
