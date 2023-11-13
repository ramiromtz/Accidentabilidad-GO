package Modelo;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

public class DAOINVESTIGACION {
    public void guardarInvestigacion(Investigacion inv)throws Exception {
        Conexion conn;
        PreparedStatement ps;
        ResultSet rs;
        String sql = "INSERT INTO investigacion(usuarioinvestigacion, accidente, declaracionvendedor, declaracionsupervisor, declaraciontestigo, dictamenmecanismo, epp, causadeaccidente, medidascorrectivas, anexos, supervisor, nombretestigo, usuario, conclusiones) VALUES(?,?,?,?,?,?,?,?,?,?,?,?,?,?)";
        
        conn = new Conexion();
        
        int idInvestigador = Integer.parseInt(inv.getUsuarioinv());
        int accidente = Integer.parseInt(inv.getAccidente());
        int supervisor = Integer.parseInt(inv.getSupervisor());
        int usuario = Integer.parseInt(inv.getUsuario());
        
        try {
            ps = conn.conectar().prepareStatement(sql);
            ps.setInt(1, idInvestigador);
            ps.setInt(2, accidente);
            ps.setString(3, inv.getDeclaracionVend());
            ps.setString(4, inv.getDeclaracionSup());
            ps.setString(5, inv.getDeclaracionTest());
            ps.setString(6, inv.getDictamen());
            ps.setString(7, inv.getEpp());
            ps.setString(8, inv.getCausaAcc());
            ps.setString(9, inv.getMedidas());
            ps.setString(10, inv.getAnexos());
            ps.setInt(11, supervisor);
            ps.setString(12, inv.getUsuario());
            ps.setInt(13, usuario);
            ps.setString(14, inv.getInformecsh());
            
            rs = ps.executeQuery();
    
        } catch (SQLException e) {
            System.out.println("Error: " + e.getMessage());
        }
    }
    
   public void actualizarEstadoAccidente(int accidenteId, String nuevoStatus) throws Exception {
        Conexion conn;
        PreparedStatement ps;
        String sql = "UPDATE registroaccidente SET estado = ? WHERE accidente = ?";

        conn = new Conexion();

        try {
            ps = conn.conectar().prepareStatement(sql);
            ps.setString(1, nuevoStatus);
            ps.setInt(2, accidenteId);


            ps.executeUpdate();

        } catch (SQLException e) {
            System.out.println("Error: " + e.getMessage());
        }
    }


}
