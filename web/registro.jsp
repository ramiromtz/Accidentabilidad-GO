<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.sql.*" %>
<%@page import="Modelo.Conexion" %>

<% 
    String usuario = request.getParameter("usuario");
    String accidente = request.getParameter("accidente");
    PreparedStatement ps;
    Statement pss;
    ResultSet rt = null; 
    Conexion conn = new Conexion();
    int idUsuario = 0;
%>
<%
	if(session.getAttribute("investigador") != null) {	
%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <meta http-equiv="Expires" content="0">
        <meta http-equiv="Last-Modified" content="0">
        <meta http-equiv="Cache-Control" content="no-cache, mustrevalidate">
        <meta http-equiv="Pragma" content="no-cache">
        <title>Registro | investigacion</title>
        <link rel="stylesheet" href="style.css" />
        <!--<link rel="stylesheet" href="styles.css"/>-->
        <!-- UNICONS -->
        <link rel="stylesheet" href="https://unicons.iconscout.com/release/v4.0.0/css/line.css">
    </head>
    <body>
        <nav class="navbar">
		<h1><img src="./images/gas-logowbg.png" /></h1>
		<div class="navbar__links">
			<a href="homeL.jsp?pagina=1">REPORTES</a>
			<a href="graficas.jsp">ESTADISTICAS</a>
			<a href="historial.jsp">HISTORIAL</a>
			<i class="uil uil-moon change-theme" id="theme-button"></i>
                        <a href="login?accion=cerrar">CERRAR SESIÓN</a>
		</div>
	</nav>
	 ${msje}
	<div class="registro__formulario">
               
		<h3>INVESTIGACIÓN</h3>
		<p>Para realizar un acta de investigación, por favor rellena el formulario</p>
                <form id="invForm" action="login?accion=investigacion" method="post" autocomplete="off">
                    <input name="txtinvestigador" value="${investigador.idUsuario}" hidden/>
                    <input name="txtIdAccidente" value='<%= accidente %>' hidden/>
                    <!-- Progress Bar -->
                    <div class="progress-bar">
                        <div class="progress" style="width: 0;"></div>
                    </div>
                    <div class="steps">
                        <p>Paso: <span></span>/5</p>
                    </div>
                        <!-- Contenedor de pasos -->
                        <div class="form-steps">
                            <fieldset class="step">
				<legend>I. Datos del trabajador</legend>
				<select id="txtnombre" name="txtusuario">
                                            <% 
                                                
                                                String sql = "SELECT usuario, nombre FROM usuario WHERE nombre = ?";
                                                try {
                                                    ps = conn.conectar().prepareStatement(sql);
                                                    ps.setString(1, usuario);
                                                    rt = ps.executeQuery();
                                                    
                                                    while(rt.next()) {
                                                        out.println("<option selected value="+rt.getInt(1)+">"+rt.getString(2)+"</option>");
                                                        idUsuario = rt.getInt(1);
                                                }
                                                    
                                                    
                                                } catch(SQLException e) {
                                                    System.out.println(e.getMessage());
                                                }
                                                
                                                
                                            %>
                                </select>
                                <legend>II. Información del accidente</legend>
                                <select id="txtaccidente" name="txtaccidente">
                                    <option selected disabled value="">Selecciona una opcion</option>
                                    <%  
                                        String sql2 = "SELECT * FROM registroaccidente WHERE usuario = ?";
                                        try {
                                            ps = conn.conectar().prepareStatement(sql2);
                                            ps.setInt(1, idUsuario);
                                            rt = ps.executeQuery();
                                            while(rt.next()) {
                                                out.println("<option value="+rt.getInt(10)+">"+rt.getString(8)+"</option>");
                                            }
                                        } catch(SQLException e) {
                                            System.out.println(e.getMessage());
                                        }
                                        
                                    %>
                                </select>
                                <legend>III. Declaración del trabajador</legend>
				<textarea id="txtdeclaracion" rows="10" cols="10" placeholder="Declaración del trabajador" name="txtdeclaracion"></textarea>
                            </fieldset>
                            <!-- <fieldset class="step">
				<legend>II. Información del accidente</legend>
                                <select id="nombre" name="txtaccidente">
                                    <option selected disabled>Selecciona una opcion</option>
                                    
                                </select>
                            </fieldset> -->
<!--                            <fieldset class="step">
				<legend>III. Declaración del trabajador</legend>
				<textarea rows="10" cols="10" placeholder="Declaración del trabajador" name="txtdeclaracion"></textarea>
                            </fieldset>-->
                            <fieldset class="step">
				<legend>IV. EPP que usaba en ese momento</legend>
				<div class="radios">
					<label>Uniforme</label>
                                        <input type="radio" name="epp" value="uniforme">
					<label>Lentes de seguridad</label>
                                        <input type="radio" name="epp" value="Lentes de seguridad">
					<label>Guantes</label>
                                        <input type="radio" name="epp" value="Guantes">
					<label>Faja</label>
                                        <input type="radio" name="epp" value="Faja">
					<label>Zapatos de seguridad</label>
					<input type="radio" name="epp" value="Zapatos de seguridad">
					<label>Casco</label>
                                        <input type="radio" name="epp" value="Casco">
				</div>
                                <legend>V. Declaración del personal de la empresa que tomó conocimiento del suceso</legend>
                                <select id="txtsupervisor" name="txtsupervisor">
                                    <option selected disabled value="">Seleccione un usuario</option>
                                    <%
                                        String sql3 = "SELECT usuario, nombre FROM usuario WHERE tipousuario = 2 AND estado = 1";
                                        try {
                                            pss = conn.conectar().createStatement();
                                            rt = pss.executeQuery(sql3);
                                            while(rt.next()) {
                                                out.println("<option value="+rt.getInt(1)+">"+rt.getString(2)+"</option>");
                                            }
                                        } catch(SQLException e) {
                                            System.out.println(e.getMessage());
                                        }
                                    %>
                                </select>
                                <textarea id="txtdeclaracionsupervisor" rows="10" cols="10" name="txtdeclaracionsupervisor" placeholder="Declaracion del supervisor"></textarea>
                            </fieldset>
<!--                            <fieldset class="step">
				<legend>V. Declaración del personal de la empresa que tomó conocimiento del suceso</legend>
                                <select name="txtsupervisor">
                                    <option selected disabled>Seleccione un usuario</option>
                                    <%
                                        /* String sql3 = "SELECT usuario, nombre FROM usuario WHERE tipousuario = 2 AND estado = 1";
                                        try {
                                            pss = conn.conectar().createStatement();
                                            rt = pss.executeQuery(sql3);
                                            while(rt.next()) {
                                                out.println("<option value="+rt.getInt(1)+">"+rt.getString(2)+"</option>");
                                            }
                                        } catch(SQLException e) {
                                            System.out.println(e.getMessage());
                                        } */
                                    %>
                                </select>
                                <textarea rows="10" cols="10" name="txtdeclaracionsupervisor" placeholder="Declaracion del supervisor"></textarea>
                            </fieldset>-->
                            <fieldset class="step">
				<legend>VI. Declaración del testigo</legend>
				<input id="txtnombretestigo" type="text" placeholder="Nombre completo" name="txtnombretestigo"/>
				<textarea id="txtdeclaraciontestigo" name="txtdeclaraciontestigo" rows="10" cols="10" placeholder="Redactar lo que sabe acerca del accidente"></textarea>
                                <legend>VII. Dictamen técnico del mecanismo del accidente</legend>
                                <input id="txtdictamen" type="text" placeholder="Dictamen tecnico" name="txtdictamen"/>
                                <legend>VIII. Informe del integrante de la Comisión de Seguridad e Higuiene de la empresa</legend>
                                <input id="txtconclusiones" name="txtconclusiones" type="text" placeholder="Conclusiones de la investigación"/>
                            </fieldset>
<!--                            <fieldset class="step">
				<legend>VII. Dictamen técnico del mecanismo del accidente</legend>
                                <input type="text" placeholder="Dictamen tecnico" name="txtdictamen"/>
                            </fieldset>-->
<!--                            <fieldset class="step">
				<legend>VIII. Informe del integrante de la Comisión de Seguridad e Higuiene de la empresa</legend>
				<input name="txtconclusiones" type="text" placeholder="Conclusiones de la investigación"/>
                            </fieldset>-->
                            <fieldset class="step">
				<legend>IX. Causa del suceso | Acto seguro | Concición segura</legend>
				<div class="radio__flex">
					<div class="radio__left">
						<div class="radio__left--group">
                                                    <input class="chkgolpe" type="radio" name="txtgolpe" value="Golpe con llaves"/>
							<label>Golpe contra o golpeado por objetos</label>	
						</div>	
						<div class="radio__left--group">
							<input class="chkgolpe" type="radio" name="txtgolpe" value="Golpe con llaves"/>
							<label>Golpe contra o golpeado por objetos</label>	
						</div>	
						<div class="radio__left--group">
							<input class="chkgolpe" type="radio" name="txtgolpe" value="Golpe con llaves"/>
							<label>Golpe contra o golpeado por objetos</label>	
						</div>						
					</div>
					<div class="radio__right">
						<div class="radio__right--group">
							<input class="chkgolpe" type="radio" name="txtgolpe" value="Golpe con llaves"/>
							<label>Golpe contra o golpeado por objetos</label>	
						</div>	
						<div class="radio__right--group">
							<input class="chkgolpe" type="radio" name="txtgolpe" value="Golpe con llaves"/>
							<label>Golpe contra o golpeado por objetos</label>	
						</div>	
						<div class="radio__right--group">
							<input class="chkgolpe" type="radio" name="txtgolpe" value="Golpe con llaves"/>
							<label>Golpe contra o golpeado por objetos</label>	
						</div>		
					</div>
				</div>
                            </fieldset>
                            <fieldset class="step">
				<legend>X. Medida correctiva</legend>
				 <!--<button type="button" id="addCat">Agregar Medida <i class="uil uil-plus" style="font-size: 1rem;"></i> </button>--> 
                                 <input id="txtmedidas" type="text" name="txtmedidas" placeholder="Medidas"/>
                                <legend>XI. Anexos</legend>
				<div class="radio__flex">
					<div class="radio__left">
						<div class="radio__left--group">
							<input class="chkanexos" value="croquis" type="radio" name="chkanexos"/>
							<label>Croquis de ubicacion</label>	
						</div>	
						<div class="radio__left--group">
                                                    <input class="chkanexos" value="video" type="radio" name="chkanexos"/>
							<label>Video de respaldo para entradas y salidas</label>	
						</div>					
					</div>
					<div class="radio__right">
						<div class="radio__right--group">
							<input class="chkanexos" value="ticket de compra" type="radio" name="chkanexos"/>
							<label>Ticket de compra del cliente</label>	
						</div>	
						<div class="radio__right--group">
							<input class="chkanexos" name="solicitud de servicio" type="radio" name="chkanexos"/>
							<label>Solicitud de servicio del cliente</label>	
						</div>	
		
					</div>
				</div>
                            </fieldset>
<!--                            <fieldset class="step">
				<legend>XI. Anexos</legend>
				<div class="radio__flex">
					<div class="radio__left">
						<div class="radio__left--group">
							<input value="croquis" type="radio" name="chkanexos"/>
							<label>Croquis de ubicacion</label>	
						</div>	
						<div class="radio__left--group">
                                                    <input value="video" type="radio" name="chkanexos"/>
							<label>Video de respaldo para entradas y salidas</label>	
						</div>					
					</div>
					<div class="radio__right">
						<div class="radio__right--group">
							<input value="ticket de compra" type="radio" name="chkanexos"/>
							<label>Ticket de compra del cliente</label>	
						</div>	
						<div class="radio__right--group">
							<input name="solicitud de servicio" type="radio" name="chkanexos"/>
							<label>Solicitud de servicio del cliente</label>	
						</div>	
		
					</div>
				</div>
                            </fieldset>-->
                        </div>
			<!-- Botones de navegación -->
                        <div class="btn">
                            <button type="button" class="prev-btn">Anterior</button>
                            <button type="button" class="next-btn">Siguiente</button>
                            <button type="submit" name="guardarInv" class="submit-btn">Guardar</button>
                        </div>
		</form>
	</div>
	
        <script src="script.js"></script>
	<script type="text/javascript" src="app.js"></script>
        <script type="text/javascript">
		let errorMsg = document.getElementById('msg-error');
		setTimeout(() => {
                    if (errorMsg) {
			errorMsg.style.display = "none";
                    }
		},2000);
                
                document.addEventListener('DOMContentLoaded', () => {
                document.querySelectorAll('input[type=text]').forEach( node => node.addEventListener('keypress', e => {
                  if(e.keyCode == 13) {
                    e.preventDefault();
                  }
                }));
                document.querySelectorAll('input[type=radio]').forEach( node => node.addEventListener('keypress', e => {
                  if(e.keyCode == 13) {
                    e.preventDefault();
                  }
                }));
              });
	</script>
    </body>
</html>
<% 
	}else {
		response.sendRedirect("index.jsp");
	}
%>
