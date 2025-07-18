<%-- 
    Document   : insertadoPedidos
    Created on : 12 jul 2025, 19:30:03
    Author     : User
--%>
<%@page import="java.util.*"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<%
    String[] nombresPlatos = request.getParameterValues("nombresPlatos");
    String[] cantidades = request.getParameterValues("cantidades");
    String[] subprecios = request.getParameterValues("subprecios");
    String totalPedido = request.getParameter("total_pedido");

    List<Map<String, String>> carritoPedidos = new ArrayList<>();

    if (nombresPlatos != null && cantidades != null && subprecios != null &&
    nombresPlatos.length > 0 && cantidades.length > 0 && subprecios.length > 0)  {
        for (int i = 0; i < nombresPlatos.length; i++) {
            Map<String, String> item = new HashMap<>();
            item.put("nombre", nombresPlatos[i]);
            item.put("cantidad", cantidades[i]);
            item.put("subprecio", subprecios[i]);
            carritoPedidos.add(item);
        }

        //Es el guardado del carrito
        session.setAttribute("carritoPedidos", carritoPedidos);
        session.setAttribute("totalPedido", totalPedido);
    } else {
        out.println("<h3>No se recibieron productos. Por favor, vuelve a la carta.</h3>");
        return;
    }

    response.sendRedirect("registroGeneral.html");
%>
