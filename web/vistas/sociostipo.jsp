<%-- 
    Document   : sociostipo
    Created on : 03-jun-2022, 19:47:39
    Author     : milto
--%>
<%@page import="java.util.List"%>
<%@page import="Clases.TipoSocio"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <jsp:include page="../components/css-js.html"/>
        <title>TouringBBC</title>
    </head>
    <body>
        <jsp:include page="header.jsp"/>
        <div class="bg-image" style="background-image: url('https://imgur.com/SvgFMB2.jpg'); background-position: center center; background-size:cover ; height: 120vh;">
            <div class="container">
        <% String message = (String) request.getAttribute("message");
        if (message != null){%>
            <div> <p><%=message%></p> </div>
        <%}%>
                <h1 style="text-align: center; color: white; background-color: rgb(181,31,36);">TIPOS DE SOCIOS </h1>
                <div class="row">
                    <div class="col-6" >
                        <div class="row">
                            <form action="/TouringBBC/Socios" method="post">
                                <div> 
                                    <label for="nombre" style="text-align: center; width: 100%;"><h2>Nuevo</h2></label>
                                    <div class="row">
                                        <div class="col-10">
                                            <input autocomplete="off" type="text" name="nombre" id="nombre" class="form-control" autofocus required>
                                        </div>
                                        <div class="col-2">
                                            <input type="submit" name="guardar" id="guardar" class="btn btn-primary" value="guardar" onclick="
                                                   if($('#nombre').val().trim() === ''){
                                                        $('#nombre')[0].setCustomValidity('Completa este campo');
                                                        return;
                                                    } else {
                                                        $('#nombre')[0].setCustomValidity('');
                                                    }
                                                   ">
                                        </div>
                                    </div>
                                    <input style="display: none;" type="text" name="accion" id="accion" value="nuevoTipoSocios" required>
                                </div>
                            </form>
                        </div>
                    </div>
                    <div class="col-6">
                        <label style="text-align: center; width: 100%;" ><h2>Lista</h2></label>
                        <div class="list-group">
                            <% List<TipoSocio> tipos = (List<TipoSocio>) request.getAttribute("tipos");
                            if (tipos != null){
                                for (TipoSocio t : tipos) {%>
                                    <div class="dropdown">
                                        <button class="list-group-item list-group-item-action" type="button" id="dropdown1" data-bs-toggle="dropdown">
                                            <%=t%>
                                        </button>
                                        <div class="dropdown-menu">
                                            <button class="dropdown-item" data-bs-toggle="modal" data-bs-target="#exampleModal" onclick="$('#nombreNuevo').val('<%=t%>');$('#nombreViejo').val('<%=t%>');"> Editar </button>
                                            <form action="/TouringBBC/Socios" method="post">
                                                <button class="dropdown-item" > Eliminar </button>
                                                <input style="display: none;" type="text" name="nombreTipoSocio" id="nombreTipoSocio" value="<%=t%>" required>
                                                <input style="display: none;" type="text" name="accion" id="accion" value="eliminarTipoSocio" required>
                                            </form>
                                        </div>
                                    </div>
                                <%}%>
                            <%}%>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <!-- Modal -->
        <div class="modal fade " id="exampleModal" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
            <div class="modal-dialog modal-dialog-centered">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title" id="exampleModalLabel">Editar tipo de Socio</h5>
                        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                    </div>
                    <form action="/TouringBBC/Socios" method="post">
                        <div class="modal-body">
                            <input autocomplete="off" type="text" name="nombreNuevo" id="nombreNuevo" class="form-control" placeholder="Nombre..." required>
                            <input style="display: none;" type="text" name="nombreViejo" id="nombreViejo" required>
                            <input style="display: none;" type="text" name="accion" id="accion" value="modificarTipoSocio" required>
                        </div>
                        <div class="modal-footer">
                            <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cerrar</button>
                            <input type="submit" class="btn btn-primary" value="Guardar cambios" onclick="
                                        if($('#nombreNuevo').val().trim() === ''){
                                             $('#nombreNuevo')[0].setCustomValidity('Completa este campo');
                                             return;
                                         } else {
                                             $('#nombreNuevo')[0].setCustomValidity('');
                                         }
                                   "/>
                        </div>
                    </form>
                </div>
            </div>
        </div>     
        <script type="text/javascript" src="js/sociostipo.js"></script>
    </body>
</html>
