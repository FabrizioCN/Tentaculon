<%-- 
    Document   : pagoFinalizado
    Created on : 13 jul 2025, 13:37:44
    Author     : User
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
        <link rel="stylesheet" type="text/css" href="CSS/estiloPagoFinalizado.css">
        <link rel="icon" href="imagenes/logotenta.png">
    </head>
    <body>
        <!-- Barra superior -->
        <div class="franja-superior">
            <div class="franja-textos">Inicio / Nosotros / Carta / Sedes</div>
            <div class="menu-icon" id="menu-icon">&#9776;</div>
        </div>

        <!-- Barra lateral -->
        <nav class="navbar">
            <div id="sidebar" class="sidebar">
            <div class="sidebar-item"><a href="../../index.html">INICIO</a></div>
            <div class="sidebar-item"><a href="../NOSOTROS/nosotres.html">NOSOTROS</a></div>
            <div class="sidebar-item"><a href="../CARTA/carta1.html">CARTA</a></div>
            <div class="sidebar-item"><a href="DELIVERY.html">DELIVERY</a></div>
            <div class="sidebar-item"><a href="../HORARIO ATENCION/horarios.html">HORARIO DE ATENCIÓN</a></div>
            <div class="sidebar-item"><a href="../NUESTRAS SEDES/sedes.html">NUESTRAS SEDES</a></div>
        </div>
        </nav>

        <!-- Funcionalidad del menú -->
        <script>
            document.addEventListener("DOMContentLoaded", () => {
                const menuIcon = document.getElementById("menu-icon");
                const sidebar = document.getElementById("sidebar");
                let sidebarOpen = false;

                menuIcon.addEventListener("click", () => {
                    sidebar.style.width = sidebarOpen ? "0" : "270px";
                    sidebarOpen = !sidebarOpen;
                });
            });
        </script>
        <div class="contenedorMensaje">
            <center>
                <h2>¡Pago realizado exitosamente!</h2>
                <p>Gracias por tu compra en <strong>El Tentaculón</strong>.<br>Hemos recibido tu pedido y ya está siendo procesado por nuestro equipo.<br>
                    En breve recibirás una confirmación al número y correo que registraste.<br>
                    Nuestro repartidor llegará lo más pronto posible. ¡Prepárate para disfrutar tu pedido!
                </p>
                
                <img src="imagenes/tentafit.png"><p>
                
                <form action="../../index.html" method="get">
                    <input type="submit" value="Volver al inicio">
                </form>
            </center>
        </div>
    </body>
</html>
