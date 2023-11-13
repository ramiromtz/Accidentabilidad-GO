package Modelo;

import java.util.List;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;

public class DAOUSUARIOSV {
    public List<Usuario> listarUsuarios() throws Exception {
		List<Usuario> usuarios = null;
		Usuario user;
		Conexion con;
		ResultSet rs;
		Statement st;
		String sql = "SELECT nombre FROM usuario WHERE tipousuario = 1";
		con = new Conexion();
		
		try {
                    st = con.conectar().createStatement();
                    rs = st.executeQuery(sql);
                    usuarios = new ArrayList<>();

                    while(rs.next() == true) {
                        user = new Usuario();
                        user.setUsuario(rs.getString("nombre"));
                        usuarios.add(user);
                    }
		} catch (SQLException e) {
			System.out.println("Error" + e.getMessage());
		} 
		return usuarios;	
        }   
}
