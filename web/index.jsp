<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Login</title>
         <link rel="icon" href="./images/gas-logowbg.png">
        <!-- CSS FILE -->
        <link rel="stylesheet" href="style.css" />
    </head>
    <body>
        <div class="login__container">
		<div class="left__side">
			<img src="./images/gas-logo.png" />
		</div>
		<div class="right__side">
			<h1>Iniciar Sesión</h1>
			<form action="login?accion=login" method="post">
				<div class="form__group">
					<input id="usuario" type="text" name="txtusername" placeholder=" "/>
					<label for="usuario" >Usuario</label>
				</div>
				<div class="form__group">
					<input id="password" type="password" name="txtpassword" placeholder=" "/>
					<label for="password" >Contraseña</label>
				</div>
				${msje}
				<div class="btn">
					<button type="submit" name="login">INGRESAR</button>
				</div>
				
			</form>
		</div>
	</div>
	
	<script type="text/javascript">
		let errorMsg = document.getElementById('msg-error');
		setTimeout(() => {
                    if(errorMsg) {
			errorMsg.style.display = "none";
                    }
		},2000);
	</script>
    </body>
</html>
