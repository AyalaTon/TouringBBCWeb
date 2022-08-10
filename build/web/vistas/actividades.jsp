<%-- 
    Document   : actividades
    Created on : 28-jul-2022, 23:34:56
    Author     : milto
--%>

<%@page import="Clases.Actividad"%>
<%@page import="java.util.List"%>
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
                <h1 style="text-align: center; color: white; background-color: rgb(181,31,36);" >ACTIVIDADES </h1>
                <div class="input-group rounded" style="margin-bottom: .5rem">
                   <input type="search" class="form-control rounded" placeholder="Buscar..." aria-label="Search" aria-describedby="search-addon" id="search" name="search" onkeyup="filtrar()" autocomplete="off"/>
                    <span class="input-group-text border-0" id="search-addon">
                        <i class="fas fa-search"></i>
                    </span>
                </div>
                <div class="row" >
                    <div class="col-12"> <!-- "style="border-color: red; border-style: solid; border-width: 3px; -->
                        <% List<Actividad> actividades = (List<Actividad>) request.getAttribute("actividades");%>
                        <div style="overflow: auto; max-height: 70vh !important;">
                            <table class="table table-light table-striped table-hover" >
                                <thead>
                                    <tr>
                                        <th scope="col">Nombre</th>
                                        <th scope="col">Cupos</th>
                                        <th scope="col">Horarios</th>
                                    </tr>
                                </thead>
                                <tbody id="tablaActividades">
                                    <%if (actividades != null){
                                        for (Actividad s : actividades) {%>
                                            <tr data-bs-toggle="modal" data-bs-target="#accionesActividad" 
                                                onclick="
                                                    $('#nombre').attr('value', '<%=s.getNombre()%>');
                                                    $('#eliminarActividadLabel').text('¿Eliminar la actividad <%=s.getNombre()%> ?');
                                                    $('#accionesActividadLabel').text('<%= "Actividad " + s.getNombre()%>');
                                                    $('#modificarActividad').attr('value', '<%=s.showHorarios2()%>');
                                                    $('#tablaModal > tbody'). empty();
                                                    let diasHorarios = $('#modificarActividad').val();
                                                    const myArray = diasHorarios.split(', ');
                                                    $.each( myArray, function( index, value ){
                                                        const dia = value.split('(');
                                                        const horario = dia[1].split(')');
                                                        horario[0] += 'Hrs';
                                                        $('#tablaModal').find('tbody')
                                                        .append($('<tr style=text-align:left;>')
                                                            .append($('<td>')
                                                                .append(dia[0] + ' ' + horario[0])
                                                            )
                                                        );
                                                    });
                                                ">
                                                <td><%=s.getNombre()%></td>
                                                <td><%=s.getCupos()%></td>
                                                <td><%=s.showHorarios2()%></td>
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
        <!-- Modal Opciones de actividad clickeada -->
        <div class="modal fade " id="accionesActividad" tabindex="-1" aria-labelledby="accionesActividadLabel" aria-hidden="true">
            <div class="modal-dialog modal-dialog-centered modal-md">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title" id="accionesActividadLabel">Actividad</h5>
                        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                    </div>
                    <div class="modal-body" style="text-align: center">
                        
                        <table id="tablaModal" class="table table-light table-striped table-hover">
                            <thead>
                                <tr>
                                    <th scope="col">Dias y horarios</th>
                                </tr>
                            </thead>
                            <tbody>
                                
                            </tbody>
                        </table>
                        <form action="/TouringBBC/Actividades" method="post">
                            <input type="text" style="display: none;" name="modificarActividad" id="modificarActividad" value="" required />
                            <input type="text" style="display: none;" name="nombre" id="nombre" value="" required />
                            <button type="button" class="btn btn-primary" data-bs-dismiss="modal" disabled="on" onclick="">Modificar</button>
                            <button type="button" class="btn btn-secondary" data-bs-toggle="modal" data-bs-target="#eliminarActividad" disabled="on" onclick="">Eliminar</button>
                        </form>
                    </div>
                </div>
            </div>
        </div>
    <!-- Modal Eliminar-->
        <div class="modal fade " id="eliminarActividad" tabindex="-1" aria-labelledby="eliminarActividadLabel" aria-hidden="true">
            <div class="modal-dialog modal-dialog-centered modal-md">
                <div class="modal-content">
                    <div class="modal-header" id="unico">
                        <h5 class="modal-title" id="eliminarActividadLabel">¿Seguro que quiere eliimnar a ? </h5>
                        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                    </div>
                    <div class="modal-body" style="text-align: center">
                        <form action="/TouringBBC/Actividades" method="post" id="formEliminar">
                            <input type="text" style="display: none;" name="accion" id="accion" value="eliminarActividad"  required/>
                            <input type="text" style="display: none;" name="nombreAct" id="nombreAct" value="" class="nombreAct" required/>
                            <input type="button" class="btn btn-primary" value="Aceptar"/>
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
            table = document.getElementById("tablaActividades");
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