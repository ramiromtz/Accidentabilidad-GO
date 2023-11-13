<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.sql.*" %>
<%@page import="Modelo.Conexion" %>

<%
	if(session.getAttribute("supervisor") != null) {
   
%> 
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Inicio</title>
        <!-- CSS FILE -->
        <link rel="stylesheet" href="style.css" />
        <!-- UNICONS -->
        <link rel="stylesheet" href="https://unicons.iconscout.com/release/v4.0.0/css/line.css">
    </head>
    <body>
        
        <nav class="navbar">
		<h1><img src="./images/gas-logowbg.png" /></h1>
		<div class="navbar__links">
			<a class="active" href="#">INICIAR REPORTE</a>
			<i class="uil uil-moon change-theme" id="theme-button"></i>
			<a href="login?accion=cerrar">CERRAR SESIÓN</a>
		</div>
	</nav>
	<div class="form__section">
            <form action="login?accion=registroaccidente" method="post" autocomplete="off">
			<p>Rellene el formulario para poder levantar un reporte de accidente</p>
			<p class="info">Datos del trabajador</p>
			<div class="grid1">
                            <input name="txtidusuario" type="hidden" value="${supervisor.idUsuario}"/>
				<div class="grid__form-group">
					<label for="nombre">Nombre del vendedor:</label>
					<select id="nombre" name="txtusuario">
                                            <option disabled selected>Seleccione el nombre vendedor</option>
                                            <% 
                                                Statement ps;
                                                ResultSet rt; 
                                                Conexion conn = new Conexion();
                                                String sql = "SELECT usuario, nombre FROM usuario WHERE tipousuario = 1 AND estado = 1";
                                                try {
                                                    ps = conn.conectar().createStatement();
                                                    rt = ps.executeQuery(sql);
                                                    while(rt.next()) {
                                                        out.println("<option value="+rt.getInt(1)+">"+rt.getString(2)+"</option>");
                                                    }
                                                } catch(SQLException e) {
                                                    System.out.println(e.getMessage());
                                                }
                                            %>
					</select>
				</div>
				<div class="grid__form-group">
					<label for="ruta">Ruta del vendedor:</label>
					<select id="ruta" name="txtruta">
						<option disabled selected>Seleccione una ruta</option>
						<% 
                                                String sql2 = "SELECT ruta, descripcion FROM ruta";
                                                try {
                                                    ps = conn.conectar().createStatement();
                                                    rt = ps.executeQuery(sql2);
                                                    while(rt.next()) {
                                                        out.println("<option value="+rt.getInt(1)+">"+rt.getString(2)+"</option>");
                                                    }
                                                } catch(SQLException e) {
                                                    System.out.println(e.getMessage());
                                                }
                                            %>
					</select>
				</div>
				<div class="checkboxes">
					<label>Avisó:</label>
                                        <input type="radio" name="chkaviso" value="True"/>
					<span>Sí</span>
                                        <input type="radio" name="chkaviso" value="False"/>
					<span>No</span>
				</div>
			</div>
			
			<p class="info">Información del accidente</p>
			
			<div class="grid2">
				<div class="grid__form-group">
					<label for="fecha">Fecha del suceso:</label>
					<input id="fecha" type="date" name="txtfecha" />
				</div>
				<div class="grid__form-group">
					<label for="hora">Hora del suceso:</label>
					<input id="hora" type="time" name="txthora"/>
				</div>
				<div class="grid__form-group">
					<label for="lugar">Lugar exacto del suceso:</label>
					<input id="lugar" type="text" name="txtlugar"/>
				</div>
				<div class="grid__form-group">
					<label for="accidente">Accidente:</label>
                                        <select name="txtaccidente">
                                            <option selected="" disabled="true">Selecciona un accidente</option>
                                            <% 
                                                String sql3 = "SELECT accidente, descripcion FROM accidente";
                                                try {
                                                    ps = conn.conectar().createStatement();
                                                    rt = ps.executeQuery(sql3);
                                                    while(rt.next()) {
                                                        out.println("<option value="+rt.getInt(1)+">"+rt.getString(2)+"</option>");
                                                    }
                                                } catch(SQLException e) {
                                                    System.out.println(e.getMessage());
                                                }
                                            %>
                                        </select>
				</div>
                                <div class="grid__form-group">
                                    <label for="detalles">Detalles del accidente:</label>
                                    <input id="detalles" type="text" name="txtdetalles"/>
				</div>
			</div>
			<div class="btn">
                            <button type="submit" name="guardar">Guardar</button>
			</div>
                        ${msje}
		</form>
	</div>
	
	<script type="text/javascript" src="app.js"></script>
        <script type="text/javascript">
		let errorMsg = document.getElementById('msg-error');
		setTimeout(() => {
			errorMsg.style.display = "none";
		},2000);
	</script>
    </body>
</html>
<% 
	}else {
		response.sendRedirect("index.jsp");
	}
%>