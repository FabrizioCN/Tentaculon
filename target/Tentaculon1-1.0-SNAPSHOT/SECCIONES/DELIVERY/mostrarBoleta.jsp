<%-- 
    Document   : mostrarBoleta
    Created on : 13 jul 2025, 12:10:11
    Author     : User
--%>

<%@page import="java.sql.*"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ include file="../../CONEX/conexion.jsp" %>

<%    String idPedidoStr = request.getParameter("id");
    int idPedido = Integer.parseInt(idPedidoStr);

    PreparedStatement ps = cn.prepareStatement(
            "SELECT p.nombre_plato, pe.cantidad, pe.precio_total, "
            + "c.nombre, c.apellidos, pe.tipo_boleta, pe.fecha_pedido, m.nombre_metodo "
            + "FROM pedido pe "
            + "JOIN PLATOS p ON pe.PLATOS_idPLATOS = p.idPLATOS "
            + "JOIN CLIENTES c ON pe.CLIENTES_idCLIENTES = c.idCLIENTES "
            + "JOIN METODOS_PAGO m ON pe.METODOS_PAGO_id_metodo = m.id_metodo "
            + "WHERE pe.idPEDIDO = ? OR pe.CLIENTES_idCLIENTES = (SELECT CLIENTES_idCLIENTES FROM pedido WHERE idPEDIDO = ?)");

    ps.setInt(1, idPedido);
    ps.setInt(2, idPedido);
    ResultSet rs = ps.executeQuery();

    double total = 0;
    String clienteNombre = "";
    String tipoBoleta = "";
    String fecha = "";
    String metodoPago = "";

    boolean hayResultados = false;
%>

<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <title>Boleta - El Tentaculón</title>
        <link rel="stylesheet" type="text/css" href="CSS/estiloBoletaP.css">
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
                <div class="sidebar-item">INICIO</div>
                <div class="sidebar-item">NOSOTROS</div>
                <div class="sidebar-item">CARTA</div>
                <div class="sidebar-item">HORARIO DE ATENCIÓN</div>
                <div class="sidebar-item">EVENTOS</div>
                <div class="sidebar-item">NUESTRAS SEDES</div>
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
        <div class="conteBoletaPago">
            <center>
            <h1>BOLETA DE PEDIDO</h1>

            <p><strong>Cliente:</strong> 
                <%
                    if (rs.next()) {
                        hayResultados = true;

                        clienteNombre = rs.getString("nombre") + " " + rs.getString("apellidos");
                        tipoBoleta = rs.getString("tipo_boleta");
                        fecha = rs.getString("fecha_pedido");
                        metodoPago = rs.getString("nombre_metodo");

                        out.print(clienteNombre);
                %>
            </p>
            <p><strong>Fecha:</strong> <%= fecha%></p>
            <p><strong>Tipo de Boleta:</strong> <%= tipoBoleta%></p>
            <p><strong>Método de Pago:</strong> <%= metodoPago%></p>
            <div class="tablaPedido">
            <table  cellpadding="8" cellspacing="0">
                <tr>
                    <th>Plato</th>
                    <th>Subtotal</th>
                </tr>
                <tr>
                    <td><%= rs.getString("nombre_plato")%> x <%= rs.getInt("cantidad")%></td>
                    <td>S/ <%= rs.getDouble("precio_total")%></td>
                </tr>

                <%
                    total += rs.getDouble("precio_total");
                    while (rs.next()) {
                %>
                <tr>
                    <td><%= rs.getString("nombre_plato")%> x <%= rs.getInt("cantidad")%></td>
                    <td>S/ <%= rs.getDouble("precio_total")%></td>
                </tr>
                <%
                        total += rs.getDouble("precio_total");
                    }
                %>
                <tr>
                    <td><strong>TOTAL</strong></td>
                    <td><strong>S/ <%= total%></strong></td>
                </tr>
            </table>
                </div>

            <h2>Realizar pago</h2>
            <form action="pagoFinalizado.jsp" method="post">
                <input type="hidden" name="idPedido" value="<%= idPedido%>">
                <input type="hidden" name="total" value="<%= total%>">


                <%
                    if (metodoPago.equals("Yape/Plin")) {
                %>
                <p>Escanea el siguiente QR con tu app de <%= metodoPago%> para realizar el pago.</p>
                <p><img src="imagenes/yapeqr.png"><p>
                <%
                } else if (metodoPago.equals("Efectivo")) {
                %>
                <p>Se realizará el pago al momento de la entrega.</p>
                <%
                } else if (metodoPago.equals("Tarjeta")) {
                %>
                <p>Ingresa los datos de tu tarjeta:</p>

                <strong>Número de tarjeta:</strong><p>
                <input type="text" name="numero_tarjeta" maxlength="19" placeholder=" 1234-5678-9012-3456 "  required><br><br>
                
                <strong>Fecha de vencimiento:</strong><p>    
                <input type="text" name="fecha_vencimiento" maxlength="5"  placeholder=" MM/AA " required><br><br>

                <strong>CVV:</strong><p>
                <input type="text" name="cvv" maxlength="3" required><br><br>
                <%
                } else {
                %>
                <p>Confirma el pago con el método: <%= metodoPago%></p>
                <%
                    }
                %>


                <br>
                <button type="submit">Finalizar compra</button>
            </form>
            </center>
        </div>
        <%
        } else {
        %>
        <p>No se encontró información del pedido.</p>
        <%
            }
            rs.close();
            ps.close();
        %>


    </body>
</html>
