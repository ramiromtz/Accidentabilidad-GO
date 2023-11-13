package Modelo;


import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.text.ParseException;


public class DAOACCIDENTES {
    public void guardarAccidente(Accidente acc) throws ParseException, SQLException {
        Conexion conn;
        PreparedStatement ps = null;
        ResultSet rs = null;
        String sql = "INSERT INTO registroaccidente(usuarioregistro, usuario, ruta, fecha, hora, lugar, descripcion, detalleaccidente, aviso) values(?,?,?,?,?,?,?,?,?)";        
        conn = new Conexion();
        
        int usuarioregistro = Integer.parseInt(acc.getUsuarioregistro());
        int usuario = Integer.parseInt(acc.getUsuario());
        int ruta = Integer.parseInt(acc.getRuta());
        int descripcion = Integer.parseInt(acc.getDescripcion());

        
        try {
            ps = conn.conectar().prepareStatement(sql);
            ps.setInt(1, usuarioregistro);
            ps.setInt(2, usuario);
            ps.setInt(3, ruta);
            ps.setString(4, acc.getFecha());
            ps.setString(5, acc.getHora());
            ps.setString(6, acc.getLugar());
            ps.setInt(7, descripcion);
            ps.setString(8, acc.getDetalleaccidente());
            ps.setString(9, acc.getAviso());
            
            rs = ps.executeQuery();
                             
        } catch (SQLException e) {
            System.out.println("Error: " + e.getMessage());
        }
    }
}
