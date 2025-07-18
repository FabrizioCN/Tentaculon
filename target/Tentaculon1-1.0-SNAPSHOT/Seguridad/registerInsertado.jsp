<%-- 
    Document   : registerInsertado
    Created on : 12 jul 2025, 8:45:57
    Author     : User
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ include file="../CONEX/conexion.jsp" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
        <link rel="stylesheet" type="text/css" href="CSS/estiloRegister.css">
    </head>
    <body>
        <div class="registroU">
        <%
        String nombre = request.getParameter("nombreu");
    String clave = request.getParameter("clave");

    String sql = "INSERT INTO usuario (nombreu, clave) VALUES ('" + nombre + "', '" + clave + "')";
    
    int filas = st.executeUpdate(sql);

    if (filas > 0) {
        out.println("<h2>¡Registro exitoso!</h2>");
    } else {
        out.println("<h2>Error al registrar.</h2>");
    }
    %>
    
        <%
   out.println("<h3>Bien! se registro correctamente ahora puedes iniciar sesión </h3>");
        %>
        <a href="login.html">¿Inicar sesion?</a>
        </div>
    </body>
</html>
