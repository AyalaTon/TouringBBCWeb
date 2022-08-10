<%-- 
    Document   : detallesSocio
    Created on : 27-jun-2022, 16:17:08
    Author     : milto
--%>

<%@page import="Clases.PagoBBC"%>
<%@page import="Clases.Cuota"%>
<%@page import="Clases.SocioActividad"%>
<%@page import="Clases.Jugador"%>
<%@page import="Clases.Categoria"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.List"%>
<%@page import="Clases.TipoSocio"%>
<%@page import="Clases.Socio"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <jsp:include page="../components/css-js.html"/>
        <title>TouringBBC</title>
    </head>
        <% List<Categoria> categoriasTest = (List<Categoria>) request.getAttribute("categorias");%>
        <%SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd");%>
        <% Socio socio = (Socio) request.getAttribute("socio");%>
        <% Jugador j = null;
            if(request.getAttribute("jugador") != null){     
                j = (Jugador) request.getAttribute("jugador");
           } 
        %>
    <body onload="
            cargarTipo(); 
            cargarCategoria(); 
            <%if(j!= null){%>
                cargarCarnet(); 
            <%}%>
        ">
        <div style="display: none;" class="ejemploCategorias">
            <%=request.getAttribute("jsonCat")%>
        </div>
        <input id="error" name="error" type="button" data-bs-toggle="modal" data-bs-target="#errorcategoria" style="display: none;">
        <jsp:include page="header.jsp"/>
        <div class="bg-image" style="background-image: url('https://imgur.com/SvgFMB2.jpg'); background-position: center center; background-size:cover ; height: 120vh;">
            <div class="container">
                <br>
                <h1 style="text-align: center; color: white; background-color: rgb(181,31,36);" >Socio <%= socio.getNombre()  + " " + socio.getApellido()%></h1>
                <div class="row">
                    <div class="col-4">
                        <form action="/TouringBBC/Socios" method="post">
                            <div class="row">
                                <div class="col-2">
                                    <label for="nombre" style="vertical-align: middle; line-height: 38px; margin-left: -3px;"> Nombre: </label>
                                </div>
                                <div class="col-10">
                                    <input style="margin-left: 5px;" autocomplete="off" type="text" name="nombre" id="nombre" class="form-control" placeholder="Nombre..." required value="<%=socio.getNombre()%>">
                                </div>
                            </div>
                            <div class="row" style="margin-top: 5px;">
                                <div class="col-2" >
                                    <label for="apellido" style="vertical-align: middle; line-height: 38px; margin-left: -3px;"> Apellido: </label>
                                </div>
                                <div class="col-10">
                                    <input style="margin-left: 5px;" autocomplete="off" type="text" name="apellido" id="apellido" class="form-control" placeholder="Apellido..." required value="<%=socio.getApellido()%>">
                                </div>
                            </div>
                            <div class="row"  style="margin-top: 5px;">
                                <div class="col-2">
                                    <label for="direccion" style="vertical-align: middle; line-height: 38px; margin-left: -3px;"> Dirección: </label>
                                </div>
                                <div class="col-10">
                                    <input style="margin-left: 5px;" autocomplete="off" type="text" name="direccion" id="direccion" class="form-control" placeholder="Dirección..." required value="<%=socio.getDireccion()%>">
                                </div>
                            </div>
                            <div class="row" style="margin-top: 5px;">
                                <div class="col-2">
                                    <label for="telefono" style="vertical-align: middle; line-height: 38px; margin-left: -3px;"> Teléfono: </label>
                                </div>
                                <div class="col-10">
                                    <input style="margin-left: 5px;" autocomplete="off" type="text" name="telefono" id="telefono" class="form-control" placeholder="Teléfono..." required value="<%=socio.getTelefono()%>">
                                </div>
                            </div>
                            <div class="row" style="margin-top: 5px;">
                                <div class="col-2">
                                    <label for="cedula" style="vertical-align: middle; line-height: 38px; margin-left: -3px;"> Cédula: </label>
                                </div>
                                <div class="col-10">
                                    <input style="margin-left: 5px;" autocomplete="off" type="text" name="cedula" id="cedula" class="form-control" placeholder="Cédula..." readonly="readonly"  required value="<%=socio.getCi()%>"> 
                                </div>
                            </div>
                            <div class="row" style="margin-top: 5px;">
                                <div class="col-3">
                                    <label for="fechaIngreso" style="vertical-align: middle; line-height: 38px; margin-left: -3px;"> Ingreso:</label>
                                </div>
                                <div class="col-9">
                                    <input style="margin-left: 5px;" autocomplete="off" type="date" name="fechaIngreso" id="fechaIngreso" class="form-control" placeholder="dd/MM/aaaa..." required value="<%= format.format(socio.getFechaIngreso())%>">
                                </div>
                            </div>
                            <div class="row" style="margin-top: 5px;">
                                <div class="col-3">
                                    <label for="fechaNacimiento" style="vertical-align: middle; line-height: 38px; margin-left: -3px;"> Nacimiento: </label>
                                </div>
                                <div class="col-9">
                                    <% if(j == null){ %>  
                                        <input style="margin-left: 5px;" autocomplete="off" type="date" name="fechaNacimiento" id="fechaNacimiento" class="form-control" placeholder="dd/MM/aaaa..." required value="<%= format.format(socio.getFechaNac())%>"/>
                                    <%
                                    } else {
                                    %>
                                    <input style="display: none;" type="date" name="fechaNacimientoAnterior" id="fechaNacimientoAnterior"/>
                                    <input style="margin-left: 5px;" autocomplete="off" type="date" name="fechaNacimiento" id="fechaNacimiento" class="form-control" placeholder="dd/MM/aaaa..." required value="<%= format.format(socio.getFechaNac())%>" 
                                           onclick="
                                               $('#fechaNacimientoAnterior').val($('#fechaNacimiento').val());
                                           "
                                           onchange="
                                                var fechaNueva = $('#fechaNacimiento').val();
                                                var fechaNuevaDate = new Date(fechaNueva);
                                                var hoy = new Date();
                                                var date = hoy.getFullYear()+'-'+(hoy.getMonth()+1)+'-'+hoy.getDate();
                                                var dif = hoy.getFullYear() - fechaNuevaDate.getFullYear();
                                                let ejemplo = document.querySelector('.ejemploCategorias');
                                                var array = JSON.parse(ejemplo.innerHTML);
                                                var indiceCategoriaCorrespondiente = -1;
                                                array.forEach(myFunction);
                                                if(indiceCategoriaCorrespondiente == -1){
                                                    errorCategoria();
                                                    $('#fechaNacimiento').val($('#fechaNacimientoAnterior').val());
                                                } else {
                                                    $('#categoriasCombo').prop('selectedIndex', indiceCategoriaCorrespondiente);
                                                }
                                                function myFunction(item, index, arr) {
                                                    if(item['edad-min'] <= dif && item['edad-max'] >= dif){
                                                        indiceCategoriaCorrespondiente = index;
                                                    }
                                                }
                                                function errorCategoria(){
                                                    $( '#error' ).click();
                                                }
                                            " />
                                    <%
                                    }
                                    %>
                                </div>
                            </div>
                            <div class="row" style="margin-top: 5px;">
                                <div class="col-2">
                                    <label for="tipo" style="vertical-align: middle; line-height: 38px; margin-left: -3px;"> Tipo: </label>
                                </div>
                                <div class="col-10">
                                    <select style="margin-left: 5px;" name="tipo" id="tipo" class="form-control" required>
                                        <% if(request.getAttribute("tipoSocios") != null) {%>
                                            <% List<TipoSocio> tipos = (List<TipoSocio>) request.getAttribute("tipoSocios");
                                            if (tipos != null) {
                                                for (TipoSocio t : tipos) {%>
                                                    <option > <%= t.getNombre()%></option>
                                                <%}%>
                                            <%}%>
                                        <%}%> 
                                    </select>
                                </div>
                            </div>
                            <input style="display: none;" type="text" name="accion" id="accion" value="actualizarSocio" onclick="
                                   $('#accion').val('actualizarSocio');
                                   " required>
                            <input style="display: none;" type="text" name="categoriaJugador" id="categoriaJugador" >
                            <div style="text-align: right; margin-top: 5px;">
                                <!--<button type="button" onclick="console.log();"> asdasdasd</button>-->
                                <input type="submit" class="btn btn-primary" value="Actualizar" onclick="
                                        $('#categoriaJugador').val($('#categoriasCombo option:selected').text());
                                    " />
                                <input type="button" class="btn btn-secondary" id="eliminarSoc" onclick="" data-bs-toggle="modal" data-bs-target="#eliminarSocio" value="Eliminar"/>
                            </div>
                        </form>
                    </div>
                    <div class="col-8">
                        <ul class="nav nav-tabs" id="myTab" role="tablist">
                            <li class="nav-item" role="presentation">
                                <button class="nav-link active" id="infoJugador-tab" data-bs-toggle="tab" data-bs-target="#infoJugador" type="button" role="tab" aria-controls="infoJugador" aria-selected="true">Informacion de jugador</button>
                            </li>
                            <li class="nav-item" role="presentation">
                                <button class="nav-link" id="actividades-tab" data-bs-toggle="tab" data-bs-target="#actividades" type="button" role="tab" aria-controls="actividades" aria-selected="false">Actividades</button>
                            </li>
                            <li class="nav-item" role="presentation">
                                <button class="nav-link" id="familia-tab" data-bs-toggle="tab" data-bs-target="#familia" type="button" role="tab" aria-controls="familia" aria-selected="false">Familia</button>
                            </li>
                            <li class="nav-item" role="presentation">
                                <button class="nav-link" id="cuotas-tab" data-bs-toggle="tab" data-bs-target="#cuotas" type="button" role="tab" aria-controls="cuotas" aria-selected="false">Cuotas</button>
                            </li>
                            <li class="nav-item" role="presentation">
                                <button class="nav-link" id="pagos-tab" data-bs-toggle="tab" data-bs-target="#pagos" type="button" role="tab" aria-controls="pagos" aria-selected="false">Pagos</button>
                            </li>
                        </ul>
                        <div class="tab-content" id="myTabContent">
                            <div class="tab-pane fade show active" id="infoJugador" role="tabpanel" aria-labelledby="infoJugador-tab">
                                <form action="/TouringBBC/Socios" method="post" id="pasarAJugadorForm">
                                    
                                    <input type="text" style="display: none;" name="vencimientoCedulaFormJugador" id="vencimientoCedulaFormJugador" value=""  required/>
                                    <input type="text" style="display: none;" name="vencimientoCarnetFormJugador" id="vencimientoCarnetFormJugador" value=""  required/>
                                    <input type="text" style="display: none;" name="carnetIndexFormJugador" id="carnetIndexFormJugador" value=""  required/>
                                    <input type="text" style="display: none;" name="categoriaFormJugador" id="categoriaFormJugador" value=""  required/>
                                    <input type="text" style="display: none;" name="CIFormJugador" id="CIFormJugador" value="<%=socio.getCi()%>"  required/>
                                    <input type="text" style="display: none;" name="informacionFormJugador" id="informacionFormJugador" value=""  required/>
                                    
                                    <input type="text" style="display: none;" name="accion" id="accion" value="pasarAJugador"  required/>
                                    
                                </form>
                                <form action="/TouringBBC/Socios" method="post">
                                    <div class="row" style="margin-top: 5px;">
                                        <div class="col-2">
                                            <label for="categorias" style="vertical-align: middle; line-height: 38px;"> Categoria: </label>
                                        </div>
                                        <div class="col-4">
                                            <%if(j != null) {%>
                                                <select style="" name="categoriasCombo" id="categoriasCombo" class="form-control" required>
                                                    <% if(request.getAttribute("categorias") != null) {%>
                                                        <% List<Categoria> categorias = (List<Categoria>) request.getAttribute("categorias");
                                                        if (categorias != null) {
                                                            for (Categoria c : categorias) {%>
                                                                <option > <%= c.getNombre()%></option>
                                                            <%}%>
                                                        <%}%>
                                                    <%}%>
                                                </select>
                                            <%} else {%>
                                                <select style="" name="categoriasCombo" id="categoriasCombo" class="form-control" required readonly="readonly">
                                                    <% if(request.getAttribute("categorias") != null) {%>
                                                        <% List<Categoria> categorias = (List<Categoria>) request.getAttribute("categorias");
                                                        if (categorias != null) {
                                                            for (Categoria c : categorias) {%>
                                                                <option > <%= c.getNombre()%></option>
                                                            <%}%>
                                                        <%}%>
                                                    <%}%>
                                                </select>
                                            <%}%>
                                        </div>
                                        <div class="col-2">
                                            <label for="carnet" style="vertical-align: middle; line-height: 38px;"> Carnet: </label>
                                        </div>
                                        <div class="col-4">
                                            <%if(j != null) {%>
                                                <select style="" name="carnet" id="carnet" class="form-control" required>
                                                    <option> Salud</option>
                                                    <option> Adolescente</option>
                                                    <option> Niño</option>
                                                </select>
                                            <%} else {%>
                                                <select style="" name="carnet" id="carnet" class="form-control" required readonly="readonly">
                                                    <option> Salud</option>
                                                    <option> Adolescente</option>
                                                    <option> Niño</option>
                                                </select>
                                            <%}%>
                                        </div>
                                    </div>
                                    <div class="row" style="margin-top: 5px;">
                                    </div>
                                    <div class="row" style="margin-top: 5px;">
                                        <div class="col-3">
                                            <label for="vencimientoCarnet" style="vertical-align: middle; line-height: 38px;"> Vencimiento de carnet: </label>
                                        </div>
                                        <div class="col-9">
                                            <% if(j!= null ) {%>
                                                <input style="" autocomplete="off" type="date" name="vencimientoCarnet" id="vencimientoCarnet" class="form-control" placeholder="dd/MM/aaaa..." required value="<%=format.format(j.getCarnetHabilitante())%>">
                                            <%} else {%>
                                                <input style="" autocomplete="off" type="date" name="vencimientoCarnet" id="vencimientoCarnet" class="form-control" placeholder="dd/MM/aaaa..." readonly="readonly" >
                                            <%}%>
                                        </div>
                                    </div>
                                    <div class="row" style="margin-top: 5px;">
                                        <div class="col-3">
                                            <label for="vencimientoCedula" style="vertical-align: middle; line-height: 38px;"> Vencimiento de cédula: </label>
                                        </div>
                                        <div class="col-9">
                                            <% if(j!= null ) {%>
                                                <input style="" autocomplete="off" type="date" name="vencimientoCedula" id="vencimientoCedula" class="form-control" placeholder="dd/MM/aaaa..." required value="<%=format.format(j.getVenCi())%>">
                                            <%} else {%>
                                                <input style="" autocomplete="off" type="date" name="vencimientoCedula" id="vencimientoCedula" class="form-control" placeholder="dd/MM/aaaa..." readonly="readonly">
                                            <%}%>
                                        </div>
                                    </div>
                                    <div style="margin-top: 5px;">
                                        <label for="informacion" class="form-label">Información:</label>
                                        <% if(j!= null ) {%>
                                            <textarea class="form-control" name="informacion" id="informacion" rows="4" ><%=j.getDetalles()%> </textarea>
                                        <%} else {%>
                                            <textarea class="form-control" name="informacion" id="informacion" rows="4" readonly="readonly"></textarea>
                                        <%}%>
                                    
                                    </div>
                                    <div style="text-align: right; margin-top: 5px;">
                                        <% if(j!= null ) {%>
                                            <input type="submit" class="btn btn-primary" value="Actualizar" name="actJugador" id="actJugador" onclick="
                                                    var text = $('#carnet option:selected').index();
                                                    $('#carnetIndex').val(text);
                                                    $('#fechaNacimientoNueva').attr('value', $('#fechaNacimiento').val());
                                                    " />
                                        <%} else {%>
                                            <input type="button" class="btn btn-primary" value="Pasar a jugar" name="pasarAJugador" id="pasarAJugador" onclick="
                                                    let haycategoriaDisp = false;
                                                    var fechaNueva = $('#fechaNacimiento').val();
                                                    var fechaNuevaDate = new Date(fechaNueva);
                                                    var hoy = new Date();
                                                    var dif = hoy.getFullYear() - fechaNuevaDate.getFullYear();
                                                    let ejemplo = document.querySelector('.ejemploCategorias');
                                                    var array = JSON.parse(ejemplo.innerHTML);
                                                    var indiceCategoriaCorrespondiente = -1;
                                                    array.forEach(myFunction);
                                                    if(indiceCategoriaCorrespondiente == -1){
                                                        errorCategoria();
                                                    } else {
                                                        $('#categoriasCombo').prop('selectedIndex', indiceCategoriaCorrespondiente);
                                                        haycategoriaDisp = true;
                                                    }
                                                    function myFunction(item, index, arr) {
                                                        if(item['edad-min'] <= dif && item['edad-max'] >= dif){
                                                            indiceCategoriaCorrespondiente = index;
                                                        }
                                                    }
                                                    function errorCategoria(){
                                                        $( '#error' ).click();
                                                    }
                                                    if(haycategoriaDisp){
                                                        if($('#pasarAJugador').val() === 'Confirmar'){
                                                            $('#pasarAJugador').attr('form', 'pasarAJugadorForm');
                                                            $('#vencimientoCedulaFormJugador').attr('value', $('#vencimientoCedula').val());
                                                            $('#vencimientoCarnetFormJugador').attr('value', $('#vencimientoCarnet').val());
                                                            $('#carnetIndexFormJugador').attr('value', $('#carnet option:selected').index());
                                                            $('#categoriaFormJugador').attr('value', $('#categoriasCombo option:selected').text());
                                                            $('#informacionFormJugador').attr('value', $('#informacion').val());
                                                            $('#pasarAJugador').removeAttr('type').attr('type', 'submit');
                                                        } else {
                                                            $('#informacion').removeAttr('readonly');
                                                            $('#vencimientoCedula').removeAttr('readonly');
                                                            $('#vencimientoCarnet').removeAttr('readonly');
                                                            $('#carnet').removeAttr('readonly');
                                                            $('#categoriasCombo').removeAttr('readonly');
                                                            $('#pasarAJugador').attr('value', 'Confirmar');
                                                        }
                                                    }
                                                   "/>
                                            <input type="button" class="btn btn-secondary" value="Actualizar" name="actJugador" id="actJugador" readonly="readonly"/>
                                        <%}%>
                                        <input type="text" style="display: none;" name="fechaNacimientoNueva" id="fechaNacimientoNueva" value=""  required/>
                                        <input type="text" style="display: none;" name="accion" id="accion" value="actualizarJugador"  required/>
                                        <input type="text" style="display: none;" name="carnetIndex" id="carnetIndex" value=""  required/>
                                        <input type="text" style="display: none;" name="CIJugador" id="CIJugador" value="<%=socio.getCi()%>"  required/>
                                    </div>
                                </form>
                            </div>
                            <div class="tab-pane fade" id="actividades" role="tabpanel" aria-labelledby="actividades-tab">
                                <table class="table table-light table-striped table-hover">
                                    <thead>
                                        <tr>
                                            <th scope="col">Nombre</th>
                                            <th scope="col">Dias(hora)</th>
                                            <th scope="col">Monto</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <%if (socio.getActividades() != null) {
                                            List<SocioActividad> actividades = socio.getActividades();
                                            for (SocioActividad sa : actividades) {%>
                                                <tr data-bs-toggle="modal" data-bs-target="#accionesActividad" onclick="
                                                    $('#idAct').attr('value', '<%=sa.getId()%>');
                                                    $('#accionesActividadLabel').text('<%= "Actividad " + sa.getActividades()%>');
                                                    $('#actividadAsociada').attr('value', '<%=sa.getActividades()%>');
                                                    $('#idSocioAct').attr('value', '<%=sa.getId()%>');
                                                    $('#modificarAsociacion').attr('value', '<%=sa.toString2()%>');
                                                    $('#tablaModal > tbody'). empty();
                                                    let diasHorarios = $('#modificarAsociacion').val();
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
                                                    <td ><%=sa.getActividades()%></td>
                                                    <td><%=sa.toString2()%></td>
                                                    <td><%=sa.getCuota().getMonto()%></td>
                                                </tr>
                                            <%}%>
                                        <%}%>
                                    </tbody>
                                </table>
                                <form action="/TouringBBC/Socios" method="post">
                                    <div style="text-align: right; margin-top: 5px;">
                                        <input type="text" style="display: none;" name="accion" id="accion" value="asociarActividad"  required/>
                                        <input type="text" style="display: none;" name="CIJugador" id="CIJugador" value="<%=socio.getCi()%>"  required/>
                                            <%int cantActividades = 0;
                                            if(request.getAttribute("cantActividades") != null) {
                                                cantActividades = (int) request.getAttribute("cantActividades");
                                            }
                                            if(cantActividades > 0){%>
                                                <input type="submit" class="btn btn-primary" value="Nueva..." onclick=""/>
                                            <%} else { %>
                                                <input type="button" class="btn btn-primary" value="Nueva..." data-bs-toggle="modal" data-bs-target="#crearActividadNueva"/>
                                            <%}%>
                                    </div>
                                </form>
                            </div>
                            <div class="tab-pane fade" id="familia" role="tabpanel" aria-labelledby="familia-tab">
                                <table class="table table-light table-striped table-hover">
                                    <thead>
                                        <tr>
                                            <th scope="col">Nombre</th>
                                            <th scope="col">Apellido</th>
                                            <th scope="col">Nacimiento</th>
                                            <th scope="col">Rol</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <% List<Socio> familia = (List<Socio>) request.getAttribute("familia");%>
                                        <%SimpleDateFormat format2 = new SimpleDateFormat("dd/MM/yyyy");%>
                                            <%for (Socio f : familia) {%>
                                                <tr onclick="">
                                                    <td ><%=f.getNombre()%></td>
                                                    <td><%=f.getApellido() %></td>
                                                    <td><%=format2.format(f.getFechaNac())%></td>
                                                    <td><input style="text-align: center;" type="checkbox" onclick='return false;'
                                                               <%if(f.getRol()) {%>
                                                                    checked
                                                               <%}%>
                                                            >
                                                    </td>
                                                </tr>
                                            <%}%>
                                    </tbody>
                                </table>
                                <div style="text-align: right; margin-top: 5px;">
                                    <input type="button" class="btn btn-primary" data-bs-toggle="modal" data-bs-target="#accionesFamilia" value="Agregar..." 
                                           <%if(familia.size()>= 4){%>
                                           disabled="on"
                                           <%}%>
                                           />
                                </div>
                            
                            </div>
                            <div class="tab-pane fade" id="cuotas" role="tabpanel" aria-labelledby="cuotas-tab">
                                <table class="table table-light table-striped table-hover">
                                    <thead>
                                        <tr>
                                            <th scope="col">Fecha</th>
                                            <th scope="col">nombre</th>
                                            <th scope="col">Descripción</th>
                                            <th scope="col">Monto</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <% List<Cuota> cuotas = (List<Cuota>) request.getAttribute("cuotas");%>
                                        <% if(cuotas.size() > 0){%>
                                            <%for (Cuota f : cuotas) {%>
                                                <tr onclick="">
                                                    <td ><%=format2.format(f.getFecha())%></td>
                                                    <td><%=f.getNombre()%></td>
                                                    <td><%=f.getDescripcion()%></td>
                                                    <td><%=f.getMonto()%></td>
                                                </tr>
                                            <%}%>
                                        <%}%>
                                    </tbody>
                                </table>
                                <div style="text-align: right; margin-top: 5px;">
                                    <input type="button" class="btn btn-primary" data-bs-toggle="modal" data-bs-target="#accionesCuota" value="Agregar..." /> 
                                </div>
                            </div>
                            <div class="tab-pane fade" id="pagos" role="tabpanel" aria-labelledby="pagos-tab">
                                <div class="row" style="">
                                    <div style="overflow: auto; max-height: 50vh !important;">
                                        <table class="table table-light table-striped table-hover">
                                            <thead>
                                                <tr>
                                                    <th scope="col">Fecha</th>
                                                    <th scope="col">Monto</th>
                                                </tr>
                                            </thead>
                                            <tbody>
                                                <% List<PagoBBC> pagos = (List<PagoBBC>) request.getAttribute("pagos");%>
                                                <% if(pagos.size() > 0){%>
                                                    <%for (PagoBBC f : pagos) {%>
                                                        <tr onclick="">
                                                            <td ><%=format2.format(f.getFecha())%></td>
                                                            <td><%=f.getMonto()%></td>
                                                        </tr>
                                                    <%}%>
                                                <%}%>
                                            </tbody>
                                        </table>
                                    </div>
                                        <form action="/TouringBBC/Socios" method="post">
                                            <div class="row" style="text-align: right;">
                                                <div class="col-3">
                                                </div>
                                                <div class="col-2">
                                                    <label for="monto" style="vertical-align: middle; line-height: 38px;"> Monto: </label>
                                                </div>
                                                <div class="col-5">
                                                    <input style="" autocomplete="off" type="number" name="monto" id="monto" min="1" class="form-control"  required>
                                                </div>
                                                <div class="col-2" style="text-align: right;">
                                                    <input type="submit" class="btn btn-primary" value="Agregar" /> 
                                                </div>
                                            </div>
                                            <input type="text" style="display: none;" name="accion" id="accion" value="nuevoPago"  required/>
                                            <input type="text" style="display: none;" name="Yo" id="Yo" value="<%=socio.getCi()%>"  required/>
                                        </form>
                                </div>
                                

                            </div>
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
                        <form action="/TouringBBC/Socios" method="post">
                            <input type="text" style="display: none;" name="socio" id="socio" value="<%=socio.getCi()%>" required />
                            <input type="text" style="display: none;" name="actividadAsociada" id="actividadAsociada" value="" required />
                            <input type="text" style="display: none;" name="idSocioAct" id="idSocioAct" value="" required />
                            <input type="text" style="display: none;" name="modificarAsociacion" id="modificarAsociacion" value="" required />
                            <input type="text" style="display: none;" name="accion" id="accion" value="asociarActividad"  required/>
                            <button class="btn btn-primary" data-bs-dismiss="modal" onclick="">Modificar</button>
                            <button type="button" class="btn btn-secondary" data-bs-toggle="modal" data-bs-target="#eliminarActividad" onclick="
                                    ">Eliminar</button>
                        </form>
                    </div>
                </div>
            </div>
        </div>
        <!-- Modal Opciones de familiares -->
        <div class="modal fade " id="accionesFamilia" tabindex="-1" aria-labelledby="accionesFamiliaLabel" aria-hidden="true">
            <div class="modal-dialog modal-dialog-centered modal-md">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title" id="accionesFamiliaLabel">Agregar familiar</h5>
                        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                    </div>
                    <div class="modal-body">
                                <% List<Socio> sociosVigentes = (List<Socio>) request.getAttribute("sociosVigentes");%>
                                <%for (Socio s : sociosVigentes) {%>
                                    <% if(s.getCi() != socio.getCi()){ %>
                                        <% if(s.getFamilia() != socio.getFamilia()){ %>
                                            <div class="dropdown">
                                                <button class="list-group-item list-group-item-action" type="button" id="dropdown1" data-bs-toggle="dropdown">
                                                    <%=s.getNombre() + " " + s.getApellido() + " CI: " + s.getCi() %>
                                                </button>
                                                <div class="dropdown-menu">
                                                    <form action="/TouringBBC/Socios" method="post">
                                                        <button class="dropdown-item" > Añadir </button>
                                                        <input style="display: none;" type="text" name="socio" id="socio" value="<%=socio.getCi()%>" required>
                                                        <input style="display: none;" type="text" name="socioAAgregar" id="socioAAgregar" value="<%=s.getCi()%>" required>
                                                        <input style="display: none;" type="text" name="accion" id="accion" value="agregarFamiliar" required>
                                                    </form>
                                                </div>
                                            </div>
                                        <%}%>
                                    <%}%>
                                <%}%>
                    </div>
                    <div class="modal-footer">
                        <button class="btn btn-primary" data-bs-dismiss="modal" onclick="
                                    $(location).prop('href', '/TouringBBC/Socios?accion=altaSocio');
                                " >Agregar nuevo...</button>
                    </div>
                </div>
            </div>
        </div>
        <!-- Modal Opciones de Cuotas agregar -->
        <div class="modal fade " id="accionesCuota" tabindex="-1" aria-labelledby="accionesCuotaLabel" aria-hidden="true">
            <div class="modal-dialog modal-dialog-centered modal-md">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title" id="accionesCuotaLabel">Agregar Cuota</h5>
                        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                    </div>
                    <div class="modal-body">
                        <% List<Cuota> cuotasRestantes = (List<Cuota>) request.getAttribute("cuotasRestantes");%>
                        <%for (Cuota s : cuotasRestantes) {%>
                            <div class="dropdown">
                                <button class="list-group-item list-group-item-action" type="button" id="dropdown1" data-bs-toggle="dropdown">
                                    <%=s.getNombre() + " Monto: $" + s.getMonto()%>
                                </button>
                                <div class="dropdown-menu">
                                    <form action="/TouringBBC/Socios" method="post">
                                        <button class="dropdown-item" > Añadir </button>
                                        <input style="display: none;" type="text" name="cuotaAAgregar" id="cuotaAAgregar" value="<%=s.getNombre()%>" required>
                                        <input style="display: none;" type="text" name="socio" id="socio" value="<%=socio.getCi()%>" required>
                                        <input style="display: none;" type="text" name="accion" id="accion" value="agregarCuota" required>
                                    </form>
                                </div>
                            </div>
                        <%}%>
                    </div>
                    <div class="modal-footer">
                        <button class="btn btn-primary" data-bs-dismiss="modal" onclick="
                                    $(location).prop('href', '/TouringBBC/Cuotas?accion=cuotas');
                                " >Agregar nueva...</button>
                    </div>
                </div>
            </div>
        </div>
        <!-- Modal Error categoria no existe para esa edad-->
        <div class="modal fade " id="errorcategoria" tabindex="-1" aria-labelledby="errorcategoriaLabel" aria-hidden="true">
            <div class="modal-dialog modal-dialog-centered modal-md">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title" id="errorcategoriaLabel">Error, no existe una categoria para esa edad</h5>
                        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                    </div>
                    <form action="/TouringBBC/Categorias" method="get">
                        <div class="modal-body" style="text-align: center">
                            <input type="text" style="display: none;" name="accion" id="accion" value="categorias"  required/>
                            <input type="submit" class="btn btn-primary" value="Agregar Nueva"/>
                            <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cancelar</button>
                        </div>
                    </form>
                </div>
            </div>
        </div>
        <!-- Modal Eliminar socio -->
        <div class="modal fade " id="eliminarSocio" tabindex="-1" aria-labelledby="eliminarSocioLabel" aria-hidden="true">
            <div class="modal-dialog modal-dialog-centered modal-md">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title" id="eliminarSocioLabel">¿Seguro que quiere eliimnar a <%=socio.getNombre()%> ?</h5>
                        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                    </div>
                    <form action="/TouringBBC/Socios" method="post">
                        <div class="modal-body" style="text-align: center">
                            <input type="text" style="display: none;" name="accion" id="accion" value="eliminarSocio"  required/>
                            <input type="text" style="display: none;" name="cedula" id="cedula" value="<%=socio.getCi()%>"  required/>
                            <input type="submit" class="btn btn-primary" value="Aceptar"/>
                            <input type="button" class="btn btn-secondary" data-bs-dismiss="modal" value="Cancelar"/>
                        </div>
                    </form>
                </div>
            </div>
        </div>
        <!-- Modal Crear actividad nueva, poruqe no existe ninguna-->
        <div class="modal fade " id="crearActividadNueva" tabindex="-1" aria-labelledby="crearActividadNuevaLabel" aria-hidden="true">
            <div class="modal-dialog modal-dialog-centered modal-md">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title" id="crearActividadNuevaLabel">Ninguna actividad registrada, ¿crear nueva?</h5>
                        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                    </div>
                    <form action="/TouringBBC/Actividades" method="get">
                        <div class="modal-body" style="text-align: center">
                            <input type="text" style="display: none;" name="accion" id="accion" value="altaActividad"  required/>
                            <input type="submit" class="btn btn-primary" value="Aceptar"/>
                            <input type="button" class="btn btn-secondary" data-bs-dismiss="modal" value="Cancelar"/>
                        </div>
                    </form>
                </div>
            </div>
        </div>
        <!-- Modal Eliminar Actividad -->
        <div class="modal fade " id="eliminarActividad" tabindex="-1" aria-labelledby="eliminarActividadLabel" aria-hidden="true">
            <div class="modal-dialog modal-dialog-centered modal-md">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title" id="eliminarActividadLabel">¿Seguro que quiere eliimnar la actividad?</h5>
                        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                    </div>
                    <form action="/TouringBBC/Socios" method="post">
                        <div class="modal-body" style="text-align: center">
                            <input type="text" style="display: none;" name="accion" id="accion" value="eliminarActividad"  required/>
                            <input type="text" style="display: none;" name="cedulaSocio" id="cedulaSocio" value="<%=socio.getCi()%>"  required/>
                            <input type="text" style="display: none;" name="idAct" id="idAct" value=""  required/>
                            <input type="submit" class="btn btn-primary" value="Aceptar"/>
                            <input type="button" class="btn btn-secondary" data-bs-dismiss="modal" value="Cancelar"/>
                        </div>
                    </form>
                </div>
            </div>
        </div>
        <script type="text/javascript">
            $(function(){ // cada vez que se cambia la opcion de la categoria se evalua si es correcta y si no lo es se corrige
                $('#categoriasCombo').change(function(){
                    var fechaNueva = new Date($('#fechaNacimiento').val());
                    var today = new Date();
                    var diferencia = today.getFullYear() - fechaNueva.getFullYear();
                    let example = document.querySelector('.ejemploCategorias');
                    var array2 = JSON.parse(example.innerHTML);
                    var index = $('#categoriasCombo option:selected').index();
                    if(array2[index]['edad-min'] <= diferencia && array2[index]['edad-max'] >= diferencia){
                        $('#categoriasCombo').prop('selectedIndex', index);
                    } else {
                        array2.forEach(function callback(item, index, array) {
                            if(item['edad-min'] <= diferencia && item['edad-max'] >= diferencia){
                                $('#categoriasCombo').prop('selectedIndex', index);
                            }
                        });
                    }
                });
            });
            function cargarTipo(){ // los tipos ya estan cargados en el select en este punto. ahora setteo el index correspondiente a el tipo del Socio
                const text = '<%=socio.getTipo()%>';
                const $select = document.querySelector('#tipo');
                const $options = Array.from($select.options);
                const optionToSelect = $options.find(item => item.text === text);
                $select.value = optionToSelect.value;
            }
            function cargarCategoria(){ // recorro las categorias y selecciono la que esta dentro del rango de fecha de nacimiento
                var fechaNueva = new Date($('#fechaNacimiento').val());
                var today = new Date();
                var diferencia = today.getFullYear() - fechaNueva.getFullYear();
                let example = document.querySelector('.ejemploCategorias');
                var array2 = JSON.parse(example.innerHTML);
                array2.forEach(function callback(item, index, array) {
                    if(item['edad-min'] <= diferencia && item['edad-max'] >= diferencia){
                        $('#categoriasCombo').prop('selectedIndex', index);
                    }
                });
            }
            <%if(j!= null) {%>
                function cargarCarnet(){ // obtengo el tipoCarnet del Jugador y setteo el index del select
                    var text = '<%= j.getTipoCarnet() %>';
                    if(text === '0'){
                        text = 'Salud';
                    } else if(text === '1'){
                        text = 'Adolescente';
                    } else {
                        text = 'Niño';
                    }
                    const $select = document.querySelector('#carnet');
                    const $options = Array.from($select.options);
                    const optionToSelect = $options.find(item => item.text === text);
                    $select.value = optionToSelect.value;
                }
            <%}%>

        </script>
    </body>
</html>
