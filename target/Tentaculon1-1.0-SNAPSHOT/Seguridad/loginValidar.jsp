<%-- 
    Document   : loginValidar
    Created on : 12 jul 2025, 14:32:20
    Author     : User
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ include file="../CONEX/conexion.jsp" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
        <link rel="stylesheet" type="text/css" href="CSS/estiloLogin.css">
        <link rel="icon" href="../imagenes/logotenta.png">
    </head>
    <body>
        <div class="Bienvenido">
            <%    String nombre = request.getParameter("nombreu");
                String clave = request.getParameter("clave");

                String sql = "SELECT * FROM usuario WHERE nombreu = '" + nombre + "' AND clave = '" + clave + "'";
                ResultSet rs = st.executeQuery(sql);

                if (rs.next()) {
                    out.println("<h2>¡Bienvenido, " + nombre + "!</h2>");
                    out.println("<h3>Ahora puede seleccionar el boton continuar para dirigirse a la carta del delivery para hacer su pedido.</h3>");
                    out.println("<a href='../SECCIONES/DELIVERY/DELIVERY.html'>Continuar</a>");
                } else {
                    out.println("<h2>Usuario o clave incorrectos</h2>");
                    out.println("<h3>Por favor intente de nuevo seleccionado el siguiente boton e ingrese de nuevo...</h3>");
                    out.println("<a href='login.html'>Intentar de nuevo</a>");
                }

                rs.close();
                st.close();
                cn.close();
            %>
        </div>
    </body>
</html>
