package Modelo;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

public class DAOUSUARIO {
    public Usuario identificar(Usuario user) throws Exception {
		Usuario usu = null;
		Conexion con;
		Connection cn = null;
		PreparedStatement ps = null;
		ResultSet rs = null;
		String sql = "SELECT * FROM usuario WHERE nombre = ? AND clave = ? and estado = 1";
		
		con = new Conexion();
		
		try {
			ps = con.conectar().prepareStatement(sql);
			ps.setString(1, user.getUsuario());
			ps.setString(2, user.getClave());

			rs = ps.executeQuery();
			
			if (rs.next() == true) {
				usu = new Usuario();
                                usu.setIdUsuario(rs.getInt("usuario"));
				usu.setUsuario(user.getUsuario());
				usu.setClave(user.getClave());
				usu.setCargo(new Cargo());
				usu.getCargo().setTipou(rs.getInt("tipousuario"));
				
				usu.setEstado(1);
			}
		} catch (SQLException e) {
			System.out.println("Error" + e.getMessage());
		} finally {
			if(rs != null && rs.isClosed() == false) {
				rs.close();
			}
			
			if (ps != null && ps.isClosed() == false) {
				ps.close();
			}
			
			if (cn != null && cn.isClosed() == false) {
				cn.close();
			}
			
		}
		return usu;	
	}
}
