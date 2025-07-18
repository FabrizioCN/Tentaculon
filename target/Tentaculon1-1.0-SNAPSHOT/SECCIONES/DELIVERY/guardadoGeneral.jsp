<%-- 
    Document   : guardadoGeneral
    Created on : 13 jul 2025, 11:22:59
    Author     : User
--%>

<%@page import="java.sql.*"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ include file="../../CONEX/conexion.jsp" %>

<%
   
    String nombre = request.getParameter("nombre");
    String apellidos = request.getParameter("apellidos");
    String calle = request.getParameter("calle");
    String referencia = request.getParameter("Referencia");
    String celular = request.getParameter("celular");
    String email = request.getParameter("email");
    String fecha_pedido = request.getParameter("fecha_pedido");
    String tipo_boleta = request.getParameter("tipo_boleta");
    String dni = request.getParameter("dni");
    String ruc = request.getParameter("ruc");
    int distrito_id = Integer.parseInt(request.getParameter("distrito_id"));
    int metodo_pago_id = Integer.parseInt(request.getParameter("metodo_pago"));

    //Insert de cliente
    PreparedStatement psCliente = cn.prepareStatement(
        "INSERT INTO CLIENTES (nombre, apellidos, calle, referencia, celular, email, dni, ruc, DISTRITO_idDISTRITO) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?)",
        Statement.RETURN_GENERATED_KEYS
    );

    psCliente.setString(1, nombre);
    psCliente.setString(2, apellidos);
    psCliente.setString(3, calle);
    psCliente.setString(4, referencia);
    psCliente.setString(5, celular);
    psCliente.setString(6, email);

    if ("boleta_dni".equals(tipo_boleta)) {
        psCliente.setString(7, dni);
        psCliente.setNull(8, Types.VARCHAR);
    } else if ("factura".equals(tipo_boleta)) {
        psCliente.setNull(7, Types.VARCHAR);
        psCliente.setString(8, ruc);
    } else {
        psCliente.setNull(7, Types.VARCHAR);
        psCliente.setNull(8, Types.VARCHAR);
    }

    psCliente.setInt(9, distrito_id);
    psCliente.executeUpdate();

    ResultSet rsCliente = psCliente.getGeneratedKeys();
    rsCliente.next();
    int idCliente = rsCliente.getInt(1);
    rsCliente.close();
    psCliente.close();

    //El pedido por cada plato
    String[] nombres = request.getParameterValues("nombresPlatos");
    String[] cantidades = request.getParameterValues("cantidades");
    String[] subprecios = request.getParameterValues("subprecios");

    if (nombres == null || cantidades == null || subprecios == null) {
        out.println("<p>Error: no se recibieron datos del pedido.</p>");
        return;
    }

    int idPedido = 0; //para guardar el ultimo idPEDIDO válido

    for (int i = 0; i < nombres.length; i++) {
        String nombrePlato = nombres[i];
        int cantidad = Integer.parseInt(cantidades[i]);
        double precioTotal = Double.parseDouble(subprecios[i]);

        //Obtener ID del plato
        PreparedStatement buscarPlato = cn.prepareStatement("SELECT idPLATOS FROM PLATOS WHERE nombre_plato = ?");
        buscarPlato.setString(1, nombrePlato);
        ResultSet rsPlato = buscarPlato.executeQuery();

        int idPlato = 0;
        if (rsPlato.next()) {
            idPlato = rsPlato.getInt("idPLATOS");
        } else {
            out.println("<p>Error: No se encontró el plato: " + nombrePlato + "</p>");
            return;
        }
        rsPlato.close();
        buscarPlato.close();

        //Insert de pedido de cada plato
        PreparedStatement psDetalle = cn.prepareStatement(
            "INSERT INTO pedido (METODOS_PAGO_id_metodo, PLATOS_idPLATOS, CLIENTES_idCLIENTES, tipo_boleta, cantidad, precio_total, fecha_pedido) VALUES (?, ?, ?, ?, ?, ?, ?)",
            Statement.RETURN_GENERATED_KEYS
        );
        psDetalle.setInt(1, metodo_pago_id);
        psDetalle.setInt(2, idPlato);
        psDetalle.setInt(3, idCliente);
        psDetalle.setString(4, tipo_boleta);
        psDetalle.setInt(5, cantidad);
        psDetalle.setDouble(6, precioTotal);
        psDetalle.setString(7, fecha_pedido);
        psDetalle.executeUpdate();

        ResultSet rsPedido = psDetalle.getGeneratedKeys();
        if (rsPedido.next()) {
            idPedido = rsPedido.getInt(1); // guarda el ultimo ID insertado
        }
        rsPedido.close();
        psDetalle.close();
    }

    response.sendRedirect("mostrarBoleta.jsp?id=" + idPedido);
%>
