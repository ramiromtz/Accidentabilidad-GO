<%@page import="java.util.ArrayList"%>
<%@page import="java.util.List"%>
<%@page import="java.time.LocalDate, java.text.SimpleDateFormat" %>
<%@page import="java.sql.*" %>
<%@page import="Modelo.Conexion" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.Map" %>
<%@ page import="java.util.HashMap" %>

<% 
    PreparedStatement ps;
    Statement pss;
    ResultSet rt = null; 
    Conexion conn = new Conexion();
    // Obtener el primer día del año actual
    LocalDate primerDiaDelAnio = LocalDate.now().withDayOfYear(1);
     List<Map<String, Object>> resultados = new ArrayList<>();

    // Obtener el último día del año actual
    LocalDate ultimoDiaDelAnio = LocalDate.now().withMonth(12).withDayOfMonth(31);

    // Formatear las fechas en el formato 'yyyy-MM-dd'
    SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
    String fechaInicio = sdf.format(java.sql.Date.valueOf(primerDiaDelAnio));
    String fechaFin = sdf.format(java.sql.Date.valueOf(ultimoDiaDelAnio));
    
    String sql = "SELECT * FROM registroaccidente ra INNER JOIN accidente a ON ra.descripcion = a.accidente WHERE CAST (fecha AS DATE) BETWEEN '" + fechaInicio + "' AND '" + fechaFin + "'";
    
    try {
        ps = conn.conectar().prepareStatement(sql);
        rt = ps.executeQuery();
        while(rt.next()) {
            Map<String, Object> fila = new HashMap<>();
            
            // Obtener todas las columnas de la fila
            for (int i = 1; i <= rt.getMetaData().getColumnCount(); i++) {
                String nombreColumna = rt.getMetaData().getColumnName(i);
                Object valorColumna = rt.getObject(i);
                fila.put(nombreColumna, valorColumna);
            }

            resultados.add(fila);
        }
        
    } catch(SQLException e) {
        System.out.println(e.getMessage());
    }
    
    StringBuilder resultadosJson = new StringBuilder("[");
    for (Map<String, Object> fila : resultados) {
        resultadosJson.append("{");

        boolean primeraColumna = true;
        for (Map.Entry<String, Object> entry : fila.entrySet()) {
            if (!primeraColumna) {
                resultadosJson.append(", ");
            }
            resultadosJson.append("\"").append(entry.getKey()).append("\": ").append("\"").append(entry.getValue()).append("\"");
            primeraColumna = false;
        }

        resultadosJson.append("}, ");
    }
    if (!resultados.isEmpty()) {
        resultadosJson.setLength(resultadosJson.length() - 2); // Eliminar la coma adicional al final
    }
    resultadosJson.append("]");
%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Chart.js Example</title>
        <link rel="stylesheet" href="style.css"/>
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

        <p style="color: var(--link-color); padding: 3rem; margin-bottom: 2.4rem; text-align: center;">
            En esta sección, se presenta una visión general de las estadísticas relacionadas con los incidentes más recurrentes en el 
            ámbito de operaciones de Gas de Oaxaca. Este análisis brinda una perspectiva detallada sobre los tipos de accidentes que se registran con mayor frecuencia 
            en las actividades operativas de la empresa. La información recopilada busca proporcionar una comprensión más profunda de los eventos críticos que pueden impactar 
            la seguridad y la gestión de riesgos en el contexto específico de Gas de Oaxaca.
        </p>
        
        <div style="width: 1200px; margin: auto;"><canvas id="graph"></canvas></div>
       

        <script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/Chart.js/3.8.0/chart.min.js"></script>
        <!-- Agrega esto en la sección script de tu HTML -->
<script>
    // Convertir la cadena JSON de Java a un array JavaScript
    var datosAccidentes = <%= resultadosJson %>;
    var meses = [
        "Enero", "Febrero", "Marzo", "Abril", "Mayo", "Junio",
        "Julio", "Agosto", "Septiembre", "Octubre", "Noviembre", "Diciembre"
    ];

    // Crear una estructura para almacenar la cuenta de accidentes por mes y detalle
    var conteoAccidentes = {};

    // Procesar los datos y contar la cantidad de accidentes por mes y detalle
    datosAccidentes.forEach(function(accidente) {
        var fecha = new Date(accidente.fecha);
        var mes = fecha.getMonth() + 1; // Los meses en JavaScript son 0-indexados

        // Crear la estructura si no existe
        if (!conteoAccidentes[mes]) {
            conteoAccidentes[mes] = {};
        }

        // Contar el detalle del accidente
        var detalle = accidente.descripcion;
        if (!conteoAccidentes[mes][detalle]) {
            conteoAccidentes[mes][detalle] = 1;
        } else {
            conteoAccidentes[mes][detalle]++;
        }
    });

    console.log(conteoAccidentes);

    // Obtén las etiquetas (nombres de los meses) y datos (conteo de accidentes) para el gráfico
    var etiquetas = meses;
    var datos = [];

    // Obtén todos los tipos únicos de accidentes
    var tiposAccidentes = new Set();
    for (var mes in conteoAccidentes) {
        var detalleAccidentes = conteoAccidentes[mes];
        tiposAccidentes = new Set([...tiposAccidentes, ...Object.keys(detalleAccidentes)]);
    }

    // Inicializa un objeto para almacenar los datos por tipo de accidente
    var datosPorTipo = {};
    tiposAccidentes.forEach(function(tipo) {
        datosPorTipo[tipo] = [];
    });

    // Procesa los datos y organiza por tipo de accidente
    for (var mes in conteoAccidentes) {
        var detalleAccidentes = conteoAccidentes[mes];

        tiposAccidentes.forEach(function(tipo) {
            var valor = detalleAccidentes[tipo] || 0;
            datosPorTipo[tipo].push(valor);
        });
    }

    // Crea el gráfico de barras agrupadas
    var ctx = document.getElementById('graph').getContext('2d');
    var datasets = [];

    tiposAccidentes.forEach(function(tipo) {
        datasets.push({
            label: tipo,
            data: datosPorTipo[tipo],
            backgroundColor: getRandomColor(),
            borderWidth: 1
        });
    });

    var myChart = new Chart(ctx, {
        type: 'bar',
        data: {
            labels: etiquetas,
            datasets: datasets
        },
        options: {
            scales: {
                y: {
                    beginAtZero: true
                }
            }
        }
    });

    // Función para obtener colores aleatorios
    function getRandomColor() {
        var letters = '0123456789ABCDEF';
        var color = '#';
        for (var i = 0; i < 6; i++) {
            color += letters[Math.floor(Math.random() * 16)];
        }
        return color;
    }
</script>


    <script type="text/javascript" src="app.js"></script>
    </body>
</html>
