<%-- 
    Document   : socios
    Created on : 16-jun-2022, 10:11:14
    Author     : milto
--%>

<%@page import="java.text.SimpleDateFormat"%>
<%@page import="Clases.TipoSocio"%>
<%@page import="java.util.List"%>
<%@page import="Clases.Socio"%>
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
                <br>
                <h1 style="text-align: center; color: white; background-color: rgb(181,31,36);" >SOCIOS </h1>
                <div class="input-group rounded" style="margin-bottom: .5rem">
                    <input type="search" class="form-control rounded" placeholder="Buscar..." aria-label="Search" aria-describedby="search-addon" id="search" name="search" onkeyup="filtrar()" autocomplete="off"/>
                    <span class="input-group-text border-0" id="search-addon">
                        <i class="fas fa-search"></i>
                    </span>
                </div>
                <div class="row">
                    <div class="col-12">
                        <% List<Socio> socios = (List<Socio>) request.getAttribute("socios");%>
                        <div style="overflow: auto; max-height: 70vh !important;">
                            <table class="table table-light table-striped table-hover">
                                <thead>
                                    <tr>
                                        <th scope="col">Cédula</th>
                                        <th scope="col">Nombre completo</th>
                                        <th scope="col">Teléfono</th>
                                        <th scope="col">Dirección</th>
                                    </tr>
                                </thead>
                                <tbody id="tablaUsers">
                                    <%SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd");%>
                                    <%if (socios != null){
                                        for (Socio s : socios) {%>
                                            <tr data-bs-toggle="modal" data-bs-target="#detallesSocio" 
                                                onclick="$('#detallesSocioLsbel').text('<%="Socio " + s.getNombre() + " " + s.getApellido()%>'); 
                                                        $('#nombre').val('<%=s.getNombre()%>');
                                                        $('#apellido').val('<%=s.getApellido()%>');
                                                        $('#direccion').val('<%=s.getDireccion()%>');
                                                        $('#telefono').val('<%=s.getTelefono()%>');
                                                        $('#cedula').val('<%=s.getCi()%>');
                                                        $('#formEliminar input.cedula').attr('value', '<%=s.getCi()%>' );
                                                        $('#unico h5.eliminarSocioLabel').text('¿Seguro que quiere eliminar a <%=s.getNombre()%>?');
                                                        $('#CISocio').val('<%=s.getCi()%>');
                                                        $('#fechaIngreso').val('<%=format.format(s.getFechaIngreso()) %>');
                                                        $('#fechaNacimiento').val('<%=format.format(s.getFechaNac()) %>');

                                                        const text = '<%=s.getTipo()%>';
                                                        const $select = document.querySelector('#tipo');
                                                        const $options = Array.from($select.options);
                                                        const optionToSelect = $options.find(item => item.text === text);
                                                        $select.value = optionToSelect.value;
                                                ">
                                                <td><%=s.getCi()%></td>
                                                <td><%=s.getNombre() + " " + s.getApellido()%></td>
                                                <td><%=s.getTelefono()%></td>
                                                <td><%=s.getDireccion()%></td>
                                            </tr>
                                        <%}%>
                                    <%}%>
                                </tbody>
                            </table>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <!-- Modal -->
        <div class="modal fade" id="detallesSocio" tabindex="-1" aria-labelledby="detallesSocio" aria-hidden="true">
            <div class="modal-dialog modal-dialog-centered modal-lg">
                <div class="modal-content ">
                    <div class="modal-header">
                        <h5 class="modal-title" id="detallesSocioLsbel" ></h5>
                        <form action="/TouringBBC/Socios" method="post">
                            <input style="display: none;" type="text" name="CISocio" id="CISocio" class="form-control" required>
                            <input style="display: none;" type="text" name="accion" id="accion" value="detallesSocio" required>
                            <input type="submit" class="btn" data-bs-dismiss="modal" value="Detalles...">
                        </form>
                        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                    </div>
                    <form action="/TouringBBC/Socios" method="post" class="form2" id="form2">
                        <div class="modal-body">
                            <div class="row">
                                <div class="col-1">
                                    <label for="nombre" style="vertical-align: middle; line-height: 38px; margin-left: -3px;"> Nombre: </label>
                                </div>
                                <div class="col-11">
                                    <input style="margin-left: 5px;" autocomplete="off" type="text" name="nombre" id="nombre" class="form-control" placeholder="Nombre..." required>
                                </div>
                            </div>
                            <div class="row" style="margin-top: 5px;">
                                <div class="col-1" >
                                    <label for="apellido" style="vertical-align: middle; line-height: 38px; margin-left: -3px;"> Apellido: </label>
                                </div>
                                <div class="col-11">
                                    <input style="margin-left: 5px;" autocomplete="off" type="text" name="apellido" id="apellido" class="form-control" placeholder="Apellido..." required>
                                </div>
                            </div>
                            <div class="row"  style="margin-top: 5px;">
                                <div class="col-1">
                                    <label for="direccion" style="vertical-align: middle; line-height: 38px; margin-left: -3px;"> Dirección: </label>
                                </div>
                                <div class="col-11">
                                    <input style="margin-left: 5px;" autocomplete="off" type="text" name="direccion" id="direccion" class="form-control" placeholder="Dirección..." required>
                                </div>
                            </div>
                            <div class="row" style="margin-top: 5px;">
                                <div class="col-1">
                                    <label for="telefono" style="vertical-align: middle; line-height: 38px; margin-left: -3px;"> Teléfono: </label>
                                </div>
                                <div class="col-11">
                                    <input style="margin-left: 5px;" autocomplete="off" type="text" name="telefono" id="telefono" class="form-control" placeholder="Teléfono..." required>
                                </div>
                            </div>
                            <div class="row" style="margin-top: 5px;">
                                <div class="col-1">
                                    <label for="cedula" style="vertical-align: middle; line-height: 38px; margin-left: -3px;"> Cédula: </label>
                                </div>
                                <div class="col-11">
                                    <input style="margin-left: 5px;" autocomplete="off" type="text" name="cedula" id="cedula" class="form-control" placeholder="Cédula..." readonly="readonly"  required>
                                </div>
                            </div>
                            <div class="row" style="margin-top: 5px;">
                                <div class="col-2">
                                    <label for="fechaIngreso" style="vertical-align: middle; line-height: 38px; margin-left: -3px;"> Fecha ingreso: </label>
                                </div>
                                <div class="col-10">
                                    <input style="margin-left: 5px;" autocomplete="off" type="date" name="fechaIngreso" id="fechaIngreso" class="form-control" placeholder="dd/MM/aaaa..." required>
                                </div>
                            </div>
                            <div class="row" style="margin-top: 5px;">
                                <div class="col-2">
                                    <label for="fechaNacimiento" style="vertical-align: middle; line-height: 38px; margin-left: -3px;"> Fecha nacim: </label>
                                </div>
                                <div class="col-10">
                                    <input style="margin-left: 5px;" autocomplete="off" type="date" name="fechaNacimiento" id="fechaNacimiento" class="form-control" placeholder="dd/MM/aaaa..." required>
                                </div>
                            </div>
                            <div class="row" style="margin-top: 5px;">
                                <div class="col-1">
                                    <label for="tipo" style="vertical-align: middle; line-height: 38px; margin-left: -3px;"> Tipo: </label>
                                </div>
                                <div class="col-11">
                                    <select style="margin-left: 5px;" name="tipo" id="tipo" class="form-control" required>
                                        <% List<TipoSocio> tipos = (List<TipoSocio>) request.getAttribute("tipoSocios");
                                        if (tipos != null){
                                            for (TipoSocio t : tipos) {%>
                                                <option > <%= t.getNombre() %></option>
                                            <%}%>
                                        <%}%>
                                    </select>
                                </div>
                            </div>
                            <input style="display: none;" type="text" name="accion" id="accion" value="actualizarSocio" required>
                            <input style="display: none;" type="text" name="paginaSocios" id="paginaSocios" value="paginaSocios" required> <!-- EVALUAR GET --> 
                        </div>
                        <div class="modal-footer">
                            <input type="submit" class="btn btn-primary" value="Actualizar" onclick="
                                   $('#form2').find('input[id=accion]').attr('value', 'actualizarSocio');
                                    console.log($('#form2').find('input[id=accion]').val());
                                   "/>
                            <input type="button" class="btn btn-primary" id="eliminarSoc" onclick="" value="Eliminar" data-bs-toggle="modal" data-bs-target="#eliminarSocio" />
                        </div>
                    </form>
                </div>
            </div>
        </div>
    <!-- Modal Eliminar-->
        <div class="modal fade " id="eliminarSocio" tabindex="-1" aria-labelledby="eliminarSocioLabel" aria-hidden="true">
            <div class="modal-dialog modal-dialog-centered modal-md">
                <div class="modal-content">
                    <div class="modal-header" id="unico">
                        <h5 class="eliminarSocioLabel modal-title" id="eliminarSocioLabel">¿Seguro que quiere eliimnar a ? </h5>
                        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                    </div>
                    <div class="modal-body" style="text-align: center">
                        <form action="/TouringBBC/Socios" method="post" id="formEliminar">
                            <input type="text" style="display: none;" name="accion" id="accion" value="eliminarSocio"  required/>
                            <input type="text" style="display: none;" name="cedula" id="cedula" value="" class="cedula" required/>
                            <input type="submit" class="btn btn-primary" value="Aceptar"/>
                            <input type="button" class="btn btn-secondary" data-bs-dismiss="modal" value="Cancelar"/>
                        </form>
                    </div>
                </div>
            </div>
        </div>
    <script type="text/javascript"> 
        function filtrar(){
            var input, filter, table, tr, td, i, j, visible;
            input = document.getElementById("search");
            filter = input.value.toUpperCase();
            table = document.getElementById("tablaUsers");
            tr = table.getElementsByTagName("tr");
            for (i = 0; i < tr.length; i++) {
                visible = false;
                /* Obtenemos todas las celdas de la fila, no sólo la primera */
                td = tr[i].getElementsByTagName("td");
                for (j = 0; j < td.length; j++) {
                    if (td[j] && td[j].innerHTML.toUpperCase().indexOf(filter) > -1) {
                        visible = true;
                    }
                }
                if (visible === true) {
                    tr[i].style.display = "";
                } else {
                    tr[i].style.display = "none";
                }
            }
        }
    </script>
    </body>
</html>

