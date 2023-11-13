<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.sql.*" %>
<%@page import="Modelo.Conexion" %>
<% 
    Conexion conn = new Conexion();
    Statement ps;
    ResultSet rt; 
    PreparedStatement pss;
    String sentencia = "SELECT * FROM registroaccidente WHERE estado = 'no investigado'";
    int total = 0;
    try {
        ps = conn.conectar().createStatement();
        rt = ps.executeQuery(sentencia);
        while(rt.next()) {
        total++;
    }
    } catch(Exception e) {
    
    }
    int articulos_x_pagina = 8;
    double paginas = Math.ceil((double)total / articulos_x_pagina);
%>
<%
	if(session.getAttribute("investigador") != null) {	
%> 
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Inicio</title>
        <link rel="stylesheet" href="style.css" />
        <!-- UNICONS -->
        <link rel="stylesheet" href="https://unicons.iconscout.com/release/v4.0.0/css/line.css">
    </head>
    <body>
        
        <nav class="navbar">
		<h1><img src="./images/gas-logowbg.png" /> </h1>
		<div class="navbar__links">
			<a class="active" href="homeL.jsp?pagina=1">REPORTES</a>
			<a href="graficas.jsp">ESTADISTICAS</a>
			<a href="historial.jsp">HISTORIAL</a>
			<i class="uil uil-moon change-theme" id="theme-button"></i>
			<a href="login?accion=cerrar">CERRAR SESIÓN</a>
		</div>
	</nav>
        
        <div class="searchBox">
            <input onkeyup="search()" type="text" id="txtSearch" placeholder="Buscar por nombre de usuario" />
        </div>
	
	<div class="table__container">
            <table id="datos">
			<thead>
				<tr>
					<th>Nombre completo</th>
					<th>Puesto</th>
					<th>Fecha del suceso</th>
					<th>Fecha Reportada</th>
					<th>Ruta</th>
					<th>Hora</th>
					<th>Lugar exacto</th>
                                        <th>Operaciones</th>
				</tr>
			</thead>
                        <tbody>
                            <% 
                                                int pages = Integer.parseInt(request.getParameter("pagina"));
                                                int inicio = (pages - 1)*articulos_x_pagina;
                                                String sql = "SELECT re.accidente, u.nombre, t.descripcion, re.fecha, r.descripcion, re.hora, re.lugar FROM registroaccidente re INNER JOIN tipousuario t on t.tipousuario = 1 INNER JOIN usuario u on re.usuario = u.usuario INNER JOIN ruta r on r.ruta = re.ruta WHERE re.estado = 'no investigado' ORDER BY re.accidente ASC OFFSET ? LIMIT ?";
                                                try {
                                                    pss = conn.conectar().prepareStatement(sql);
                                                    pss.setInt(1, inicio);
                                                    pss.setInt(2, articulos_x_pagina);
                                                    rt = pss.executeQuery();
                                                    while(rt.next()) {
                                                        out.println(
                                                        "<tr>"+
                                                        "<td>"+rt.getString(2)+"</td>" +
                                                        "<td>"+rt.getString(3)+"</td>"+
                                                        "<td>"+rt.getString(4)+"</td>"+
                                                        "<td>"+rt.getString(4)+"</td>"+
                                                        "<td>"+rt.getString(5)+"</td>"+
                                                        "<td>"+rt.getString(6)+"</td>"+
                                                        "<td>"+rt.getString(7)+"</td>"+
                                                        "<td><a class='optionLink' href='registro.jsp?usuario="+rt.getString(2)+"&accidente="+rt.getInt(1)+"'>Investigar</a></td>"+
                                                        "</tr>"
                                                        );
                                                    }
                                                } catch(SQLException e) {
                                                    System.out.println(e.getMessage());
                                                }
                            %>
                            <tr class='noSearch hide'>
                                <td colspan="8"></td>
                            </tr>
			</tbody>
		</table>
	</div>
        
	<div class="pagination">
		<ul>
                    <!-- obtenemos la página actual en la que nos encontramos -->
                    <% int currentPage = Integer.parseInt(request.getParameter("pagina"));%>
                    <li><a class="<%= currentPage - 1 <= 0 ? "disabled" : "" %>" href="homeL.jsp?pagina=<%= currentPage - 1%>">Anterior</a></li>
                    <% for(int i = 0; i < paginas; i++) { %>
                    <li><a class="<%= currentPage == i+1 ? "active" : "" %>" href="homeL.jsp?pagina=<%= i+1%>"><%= i+1 %></a></li>
                    <% } %>
                    <li><a class="<%= currentPage + 1 > paginas ? "disabled" : "" %>" href="homeL.jsp?pagina=<%= currentPage + 1 %>">Siguiente</a></li>
		</ul>
                <%
                    if(currentPage > paginas || currentPage <= 0) {
                        response.sendRedirect("homeL.jsp?pagina=1");
                    }
                %>
	</div> 
	<script type="text/javascript" src="app.js"></script>
        <script>
            function search() {
                const tableReg = document.getElementById('datos');
                const searchText = document.getElementById('txtSearch').value.toLowerCase();
                let total = 0;
                
                // Recorriendo todas las filas con contenido de la tabla
                for(let i = 1; i < tableReg.rows.length; i++) {
                    if(tableReg.rows[i].classList.contains("noSearch")) {
                        continue;
                    }
                    
                    let found = false;
                    const cellsOfRow = tableReg.rows[i].getElementsByTagName('td');
                    
                    for(let j = 0; j < cellsOfRow.length && !found; j++) {
                        const compareWith = cellsOfRow[j].innerHTML.toLowerCase();
                        if(searchText.length === 0 || compareWith.indexOf(searchText) !== -1) {
                            found = true;
                            total++;
                        }
                    }
                    if(found) {
                        tableReg.rows[i].style.display = '';
                    } else {
                        tableReg.rows[i].style.display = 'none';
                    }
                }
                
                const lastTr = tableReg.rows[tableReg.rows.length - 1];
                const td = lastTr.querySelector("td");
                lastTr.classList.remove("hide", "red");
                if(searchText === ""){
                    lastTr.classList.add("hide");
                } else if(total) {
                    td.innerHTML = "¡Se ha encontrado" + " " + total + " " + "coincidencia" + (total > 1 ? "s!" : "!");
                } else {
                    lastTr.classList.add("red");
                    td.innerText = "No se han encontrado coincidencias";
                }
            }
        </script>
    </body>
</html>
<% 
	}else {
		response.sendRedirect("index.jsp");
	}
%>