<%-- 
    Document   : cuotas
    Created on : 29-jul-2022, 8:49:00
    Author     : milto
--%>

<%@page import="Clases.Actividad"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="Clases.Cuota"%>
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
        <div style="display: none;" class="ejemploCuotas">
            <%=request.getAttribute("jsonCuo")%>
        </div>
        <div class="bg-image" style="background-image: url('https://imgur.com/SvgFMB2.jpg'); background-position: center center; background-size:cover ; height: 120vh;">
            <div class="container">
                <br>
                <h1 style="text-align: center; color: white; background-color: rgb(181,31,36);">CUOTAS </h1>
                <div class="row">
                    <div class="col-4" ><!-- "style="border-color: red; border-style: solid; border-width: 3px; -->
                        <label for="nombre" style="text-align: center; width: 100%;"><h2>Nueva</h2></label>
                        <form action="/TouringBBC/Cuotas" method="post">
                            <input style="display: none;" type="text" name="accion" id="accion" value="altaCuota" required>
                            <div class="row">
                                <div class="col-3">
                                    <label for="nombreForm" style="vertical-align: middle; line-height: 38px; margin-left: -3px;"> Nombre: </label>
                                </div>
                                <div class="col-9">
                                    <input autocomplete="off" type="text" name="nombreForm" id="nombreForm" class="form-control" placeholder="Nombre..." required>
                                </div>
                            </div>
                            <div class="row" style="margin-top: 5px;">
                                <div class="col-3">
                                    <label for="descripcionForm" style="vertical-align: middle; line-height: 38px; margin-left: -3px;"> Descripción: </label>
                                </div>
                                <div class="col-9">
                                    <textarea class="form-control" name="descripcionForm" id="descripcionForm" rows="4"> </textarea>
                                </div>
                            </div>
                            <div class="row" style="margin-top: 5px;">
                                <div class="col-3">
                                    <label for="fechaForm" style="vertical-align: middle; line-height: 38px; margin-left: -3px;"> Fecha: </label>
                                </div>
                                <div class="col-9">
                                    <input style="" type="date" name="fechaForm" id="fechaForm" class="form-control" required>
                                </div>
                            </div>
                            <div class="row" style="margin-top: 5px;">
                                <div class="col-3">
                                    <label for="montoForm" style="vertical-align: middle; line-height: 38px; margin-left: -3px;">  Monto: </label>
                                </div>
                                <div class="col-9">
                                    <input style="" type="number" min="1" name="montoForm" id="montoForm" class="form-control" required>
                                </div>
                            </div>
                            <div class="row" style="margin-top: 5px;">
                                <div class="col-3">
                                    <label for="frecuenciaForm" style="vertical-align: middle; line-height: 38px; margin-left: -3px;"> Frecuencia: </label>
                                </div>
                                <div class="col-9">
                                    <select name="frecuenciaForm" id="frecuenciaForm" class="form-control" required>
                                        <option> Mensual </option>
                                        <option> Anual </option>
                                    </select>
                                </div>
                            </div>
                            <div class="row" style="margin-top: 5px;">
                                <div class="col-3">
                                    <label for="actividadForm" style="vertical-align: middle; line-height: 38px; margin-left: -3px;"> Actividad: </label>
                                </div>
                                <div class="col-9">
                                    <% List<Actividad> actividades2 = (List<Actividad>) request.getAttribute("actividades");%>
                                    <select name="actividadForm" id="actividadForm" class="form-control" required>
                                        <option> Ninguna </option>
                                        <%if (actividades2 != null){
                                            for (Actividad s : actividades2) {%>
                                                <option> <%= s.getNombre() %> </option>
                                            <%}%>
                                        <%}%>
                                    </select>
                                </div>
                            </div>
                            <div style="text-align: right; margin-top: 5px;">
                                <input type="submit" name="guardar" id="guardar" class="btn btn-primary" value="Ingresar" onclick="
                                        if($('#nombreForm').val().trim() === ''){
                                            $('#nombreForm')[0].setCustomValidity('Completa este campo');
                                            return;
                                        } else {
                                            $('#nombreForm')[0].setCustomValidity('');
                                        }
                                        let array = document.querySelector('.ejemploCuotas');
                                        var arrayCuotas = JSON.parse(array.innerHTML);
                                        let invalido = false;
                                        console.log(arrayCuotas);
                                        arrayCuotas.forEach(function (item) {
                                            console.log(item);
                                            console.log($('#nombreForm').val());
                                            if(item['nombre'].toUpperCase() === $('#nombreForm').val().trim().toUpperCase()){
                                                invalido = true;
                                            }
                                        });
                                        if(invalido === true)
                                            $('#nombreForm')[0].setCustomValidity('Ya existe otra Cuota con ese nombre');
                                        else
                                            $('#nombreForm')[0].setCustomValidity('');
                                       ">
                                <input type="button" name="cancelar" id="cancelar" class="btn btn-secondary" value="Cancelar" onclick="limpiarCampos();">
                            </div>
                        </form>
                        
                    </div>
                    <div class="col-8"> <!-- "style="border-color: red; border-style: solid; border-width: 3px; -->
                        <label style="text-align: center; width: 100%;" ><h2>Lista</h2></label>
                        <div class="input-group rounded" style="margin-bottom: .5rem">
                            <input type="search" class="form-control rounded" placeholder="Buscar..." aria-label="Search" aria-describedby="search-addon" id="search" name="search" onkeyup="filtrar()" autocomplete="off"/>
                            <span class="input-group-text border-0" id="search-addon">
                                <i class="fas fa-search"></i>
                            </span>
                         </div>
                        <!--<h1 style="text-align: center;">Tipos de socios</h1>-->
                        <div class="list-group">
                            <!--<button style="display: none;" data-bs-toggle="modal" data-bs-target="#exampleModal" id="testeo"> </button>-->
                            <div style="overflow: auto; max-height: 70vh !important;">
                                <table class="table table-light table-striped table-hover">
                                    <thead>
                                        <tr>
                                            <th scope="col">Fecha</th>
                                            <th scope="col">Nombre</th>
                                            <th scope="col">Monto</th>
                                            <th scope="col">Descripcion</th>
                                            <th scope="col">Frecuencia</th>
                                        </tr>
                                    </thead>
                                    <tbody id="tablaCuotas">
                                    <% List<Cuota> cuotas = (List<Cuota>) request.getAttribute("cuotas");
                                    SimpleDateFormat format = new SimpleDateFormat("dd/MM/yyyy");
                                    if (cuotas != null){
                                        for (Cuota t : cuotas) {%>
                                        <tr data-bs-toggle="modal" data-bs-target="#accionesCuota"  onclick="
//                                                $('#testeo').click();
                                                $('#nombreNuevo').val('<%=t.getNombre()%>'); 
                                                $('#nombreViejo').val('<%=t.getNombre()%>');
                                                $('#accionesCuotaLabel').text('Cuota <%=t.getNombre()%>');
                                                $('#fechaNueva').val('<%=t.getFecha()%>');
                                                console.log('<%=t.getFecha()%>');
                                                $('#descripcionNueva').val('<%=t.getDescripcion()%>'); // textArea asi que estara mal
                                                $('#montoNuevo').val('<%=t.getMonto()%>');
                                                
                                                let actividad = '<%=t.getActividad()%>';
                                                console.log(actividad);
                                                if(actividad === null || actividad === 'null'){
                                                        $('#actividadNueva').prop('selectedIndex', 0);                                                    
                                                } else {
                                                    $('#actividadNueva > option').each(function(index, item) {
                                                        if(actividad === item.innerHTML.trim()){
                                                            $('#actividadNueva').prop('selectedIndex', index);
                                                        }
                                                        console.log(item.innerHTML.trim());
                                                    });
                                                }
                                                
                                                let frecuencia = '<%=t.getFrecuencia()%>';
                                                //console.log(frecuencia.toString());
                                                console.log( frecuencia);
                                                console.log(frecuencia.trim() === 'Mensual');
                                                if(frecuencia.trim() === 'Mensual'){
                                                    $('#frecuenciaNueva').prop('selectedIndex', 0);
                                                } else {
                                                    $('#frecuenciaNueva').prop('selectedIndex', 1);
                                                }
                                                ">
                                            <td ><%=format.format(t.getFecha())%></td>
                                            <td ><%=t.getNombre()%></td>
                                            <td><%=t.getMonto()%></td>
                                            <td><%=t.getDescripcion()%></td>
                                            <td><%=t.getFrecuencia()%></td>
                                        </tr>
                                        <%}%>
                                    <%}%>
                                    </tbody>
                                </table>
                            </div>
                                
                        <!--<ul class="list-group">-->
                            
                        </div>
                        <!--</ul>-->
                    </div>
                </div>
            </div>
        </div>
        <!-- Modal -->
        <div class="modal fade " id="accionesCuota" tabindex="-1" aria-labelledby="accionesCuotaLabel" aria-hidden="true">
            <div class="modal-dialog modal-dialog-centered">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title" id="accionesCuotaLabel">Editar Categoria</h5>
                        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                    </div>
                    <form action="/TouringBBC/Cuotas" method="post">
                        <input style="display: none;" type="text" name="accion" id="accion" value="modificarCuota" required>
                        <div class="modal-body">
                            <input style="display: none" type="text" name="nombreViejo" id="nombreViejo" required>
                            <div class="row" style="margin-top: 5px;">
                                <div class="col-3">
                                    <label for="nombreNuevo" style="vertical-align: middle; line-height: 38px; margin-left: -3px;"> Nombre: </label>
                                </div>
                                <div class="col-9">
                                    <input autocomplete="off" type="text" name="nombreNuevo" id="nombreNuevo" class="form-control" placeholder="Nombre..." required>
                                </div>
                            </div>
                            <div class="row" style="margin-top: 5px;">
                                <div class="col-3">
                                    <label for="descripcionNueva" style="vertical-align: middle; line-height: 38px; margin-left: -3px;"> Descripción: </label>
                                </div>
                                <div class="col-9">
                                    <textarea class="form-control" name="descripcionNueva" id="descripcionNueva" rows="4"> </textarea>
                                </div>
                            </div>
                            <div class="row" style="margin-top: 5px;">
                                <div class="col-2">
                                    <label for="fechaNueva" style="vertical-align: middle; line-height: 38px; margin-left: -3px;"> Fecha: </label>
                                </div>
                                <div class="col-4">
                                    <input style="" type="date" name="fechaNueva" id="fechaNueva" class="form-control" required>
                                </div>
                                <div class="col-2">
                                    <label for="montoNuevo" style="vertical-align: middle; line-height: 38px; margin-left: -3px;">  Monto: </label>
                                </div>
                                <div class="col-4">
                                    <input style="" type="number" min="1" name="montoNuevo" id="montoNuevo" class="form-control" required>
                                </div>
                            </div>
                            <div class="row" style="margin-top: 5px;">
                                <div class="col-2">
                                    <label for="frecuenciaNueva" style="vertical-align: middle; line-height: 38px; margin-left: -3px;"> Frecuencia: </label>
                                </div>
                                <div class="col-4">
                                    <select name="frecuenciaNueva" id="frecuenciaNueva" class="form-control" required>
                                        <option> Mensual </option>
                                        <option> Anual </option>
                                    </select>
                                </div>
                                <div class="col-2">
                                    <label for="actividadNueva" style="vertical-align: middle; line-height: 38px; margin-left: -3px;"> Actividad: </label>
                                </div>
                                <div class="col-4">
                                    <% List<Actividad> actividades = (List<Actividad>) request.getAttribute("actividades");%>
                                    <select name="actividadNueva" id="actividadNueva" class="form-control" required>
                                        <option> Ninguna </option>
                                        <%if (actividades != null){
                                            for (Actividad s : actividades) {%>
                                                <option> <%= s.getNombre() %> </option>
                                            <%}%>
                                        <%}%>
                                    </select>
                                </div>
                            </div>
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
                                let array = document.querySelector('.ejemploCuotas');
                                var arrayCuotas = JSON.parse(array.innerHTML);
                                let invalido = false;
                                console.log(arrayCuotas);
                                arrayCuotas.forEach(function (item) {
                                    if(item['nombre'] !== $('#nombreViejo').val()){
                                        console.log(item);
                                        console.log($('#nombreNuevo').val());
                                        if(item['nombre'].toUpperCase() === $('#nombreNuevo').val().trim().toUpperCase()){
                                            invalido = true;
                                        }
                                    }

                                });
                                if(invalido === true)
                                    $('#nombreNuevo')[0].setCustomValidity('Ya existe otra cuota con ese nombre');
                                else
                                    $('#nombreNuevo')[0].setCustomValidity('');
                            "/>
                        </div>
                    </form>
                </div>
            </div>
        </div>
        <script type="text/javascript">
            function filtrar(){
                var input, filter, table, tr, td, i, j, visible;
                input = document.getElementById("search");
                filter = input.value.toUpperCase();
                table = document.getElementById("tablaCuotas");
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
            function limpiarCampos(){
//                $('#carnet option:selected').index();
//                $('#categoriasCombo option:selected').text();
//                $('#vencimientoCedula').val("");
//                $('#nombre').val("");
//                $('#tipo').prop('selectedIndex', 0);
                
                $('#nombreForm').val(""); //attr('value', '');
//                $('#nombreFrom').attr('value', '');
                $('#fechaForm').val("");
//                $('#fechaForm').attr('value', '');
                $('#descripcionForm').val("");
                $('#montoForm').val("");
                $('#actividadForm').prop('selectedIndex', 0);                                                    
                $('#frecuenciaForm').prop('selectedIndex', 0);   
            }
        </script>   
    </body>
</html>
