<%-- 
    Document   : altaSocio
    Created on : 22-jul-2022, 17:56:55
    Author     : milto
--%>
<%@page import="Clases.Categoria"%>
<%@page import="Clases.Cuota"%>
<%@page import="java.util.List"%>
<%@page import="Clases.TipoSocio"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <jsp:include page="../components/css-js.html"/>
        <title>TouringBBC</title>
    </head>
     <%SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd");%>
     <body onload="$('#divFamiliares > h3').css('background-color', 'rgb(178,146,146)'); $('#divJugador > h3').css('background-color', 'rgb(178,146,146)');">
        <jsp:include page="header.jsp"/>
        <div style="display: none;" class="cedulas">
            <%=request.getAttribute("cedulasJson")%>
        </div>
        <div style="display: none;" class="ejemploCategorias">
            <%=request.getAttribute("jsonCat")%>
        </div>
        <input id="errorCedula" name="errorCedula" type="button" data-bs-toggle="modal" data-bs-target="#errorCedulaInvalida" style="display: none;">
        <input id="errorSocio" name="errorSocio" type="button" data-bs-toggle="modal" data-bs-target="#errorSocioExiste" style="display: none;">
        <input id="errorCat" name="errorCat" type="button" data-bs-toggle="modal" data-bs-target="#errorcategoria" style="display: none;">
        <input id="errorRol" name="errorRol" type="button" data-bs-toggle="modal" data-bs-target="#errorRolFamilia" style="display: none;">
        <input id="tipoSocioError" name="tipoSocioError" type="button" data-bs-toggle="modal" data-bs-target="#tipoSocioErrorNotExist" style="display: none;">
        <input id="eliminarFamilia" name="eliminarFamilia" type="button" data-bs-toggle="modal" data-bs-target="#eliminarFamiliaCreada" style="display: none;">
        <div class="bg-image" style="background-image: url('https://imgur.com/SvgFMB2.jpg'); background-position: center center; background-size:cover ; height: 120vh;">
            <div class="container">
                <br>
                <h1 style="text-align: center; color: white; background-color: rgb(181,31,36);">ALTA SOCIO </h1>
                <div class="row">
                    <div class="col-4" style=""><!--style="border: solid; border-color: black;"-->
                        <form action="/TouringBBC/Socios" method="post" class="submitForm" id="submitForm"> <!-- onsubmit="return validate_ci($('#cedula').val());" -->
                            <div class="row">
                                <div class="col-2">
                                    <label for="nombre" style="vertical-align: middle; line-height: 38px; margin-left: -3px;"> Nombre: </label>
                                </div>
                                <div class="col-10">
                                    <input style="margin-left: 5px;" autocomplete="off" type="text" name="nombre" id="nombre" class="form-control"  required value="">
                                </div>
                            </div>
                            <div class="row" style="margin-top: 5px;">
                                <div class="col-2" >
                                    <label for="apellido" style="vertical-align: middle; line-height: 38px; margin-left: -3px;"> Apellido: </label>
                                </div>
                                <div class="col-10">
                                    <input style="margin-left: 5px;" autocomplete="off" type="text" name="apellido" id="apellido" class="form-control"  required value="">
                                </div>
                            </div>
                            <div class="row"  style="margin-top: 5px;">
                                <div class="col-2">
                                    <label for="direccion" style="vertical-align: middle; line-height: 38px; margin-left: -3px;"> Dirección: </label>
                                </div>
                                <div class="col-10">
                                    <input style="margin-left: 5px;" autocomplete="off" type="text" name="direccion" id="direccion" class="form-control"  required value="">
                                </div>
                            </div>
                            <div class="row" style="margin-top: 5px;">
                                <div class="col-2">
                                    <label for="telefono" style="vertical-align: middle; line-height: 38px; margin-left: -3px;"> Teléfono: </label>
                                </div>
                                <div class="col-10">
                                    <input style="margin-left: 5px;" autocomplete="off" type="text" name="telefono" id="telefono" class="form-control"  required value="">
                                </div>
                            </div>
                            <div class="row" style="margin-top: 5px;">
                                <div class="col-2">
                                    <label for="cedula" style="vertical-align: middle; line-height: 38px; margin-left: -3px;"> Cédula: </label>
                                </div>
                                <div class="col-10">
                                    <input style="margin-left: 5px;" autocomplete="off" type="text" name="cedula" id="cedula" class="form-control" title="Cédula sin puntos ni guiones" pattern="^[1-9][0-9]{7}" required> 
                                </div>
                            </div>
                            <div class="row" style="margin-top: 5px;">
                                <div class="col-3">
                                    <label for="fechaIngreso" style="vertical-align: middle; line-height: 38px; margin-left: -3px;"> Ingreso:</label>
                                </div>
                                <div class="col-9">
                                    <input style="margin-left: 5px;" autocomplete="off" type="date" name="fechaIngreso" id="fechaIngreso" class="form-control" placeholder="dd/MM/aaaa..." required value="">
                                </div>
                            </div>
                            <div class="row" style="margin-top: 5px;">
                                <div class="col-3">
                                    <label for="fechaNacimiento" style="vertical-align: middle; line-height: 38px; margin-left: -3px;"> Nacimiento: </label>
                                </div>
                                <div class="col-9">
                                    <input style="display: none;" type="date" name="fechaNacimientoAnterior" id="fechaNacimientoAnterior"/>
                                    
                                    <input style="margin-left: 5px;" autocomplete="off" type="date" name="fechaNacimiento" id="fechaNacimiento" class="form-control" placeholder="dd/MM/aaaa..." required value="" 
                                           onclick="
                                               $('#fechaNacimientoAnterior').val($('#fechaNacimiento').val());
                                           "
                                           onchange="
                                               var jugador = $('#jugador');
                                               if(jugador.prop('checked') == true){
                                                    var fechaNueva = $('#fechaNacimiento').val();
                                                    var fechaNuevaDate = new Date(fechaNueva);
                                                    var hoy = new Date();
                                                    var date = hoy.getFullYear()+'-'+(hoy.getMonth()+1)+'-'+hoy.getDate();
                                                    var dif = hoy.getFullYear() - fechaNuevaDate.getFullYear();
                                                    let ejemplo = document.querySelector('.ejemploCategorias');
                                                    var array = JSON.parse(ejemplo.innerHTML);
                                                    console.log(array);
                                                    var indiceCategoriaCorrespondiente = -1;
                                                    array.forEach(myFunction);
                                                    if(indiceCategoriaCorrespondiente == -1){
                //                                                    console.log(indiceCategoriaCorrespondiente);
                                                        errorCategoria();
                                                        $('#fechaNacimiento').val($('#fechaNacimientoAnterior').val());
                                                    } else {
                //                                                    console.log(indiceCategoriaCorrespondiente);
                //                                                    $('#categoriasCombo option:selected').val(indiceCategoriaCorrespondiente);
                                                        $('#categoriasCombo').prop('selectedIndex', indiceCategoriaCorrespondiente);
                                                    }
                                                    function myFunction(item, index, arr) {
                                                        if(item['edad-min'] <= dif && item['edad-max'] >= dif){
                                                            indiceCategoriaCorrespondiente = index;
                                                        }
                                                    }
                                                    function errorCategoria(){
                                                        $( '#errorCat' ).click();
                                                    }
                                                }
                                            " />
                                </div>
                            </div>
                            <div class="row" style="margin-top: 5px;">
                                <div class="col-2">
                                    <label for="tipo" style="vertical-align: middle; line-height: 38px; margin-left: -3px;"> Tipo: </label>
                                </div>
                                <div class="col-10">
                                    <select style="margin-left: 5px;" name="tipo" id="tipo" class="form-control" required>
                                        <% if(request.getAttribute("tipoSocios") != null) {%>
                                            <% List<TipoSocio> tipos = (List<TipoSocio>) request.getAttribute("tipoSocios"); %>
                                            <% if(tipos.size() > 0) {
                                                if (tipos != null) {
                                                    for (TipoSocio t : tipos) {%>
                                                        <option > <%= t.getNombre()%></option>
                                                    <%}%>
                                                <%}%>
                                            <%} else {%> 
                                                <option > Ninguno </option>
                                            <%}%>
                                        <%}%>
                                    </select>
                                </div>
                            </div>
                            <div class="row" style="margin-top: 5px;">
                                <div class="col-2">
                                    <label for="cuota" style="vertical-align: middle; line-height: 38px; margin-left: -3px;"> Cuota: </label>
                                </div>
                                <div class="col-10">
                                    <select style="margin-left: 5px;" name="cuota" id="cuota" class="form-control" required>
                                        <option > Ninguna </option>
                                        <% if(request.getAttribute("cuotas") != null) {%>
                                            <% List<Cuota> cuotas = (List<Cuota>) request.getAttribute("cuotas");
                                            if (cuotas != null) {
                                                for (Cuota c : cuotas) {%>
                                                    <option > <%= c.getNombre()%></option>
                                                <%}%>
                                            <%}%>
                                        <%}%> 
                                    </select>
                                </div>
                            </div>
                            <div class="row" style="margin-top: 5px;">
                                <div class="col-2">
                                    <label for="jugador" style="vertical-align: middle; line-height: 38px; margin-left: -3px;"> Jugador: </label>
                                </div>
                                <div class="col-10" style="">
                                    <input type="checkbox" name="jugador" id="jugador" style="margin-left: 5px; vertical-align: middle; height: 38px; ">
                                </div>
                            </div>
                            <div class="row" style="margin-top: 5px;">
                                <div class="col-2">
                                    <label for="familiar" style="vertical-align: middle; line-height: 38px; margin-left: -3px;"> Familiar: </label>
                                </div>
                                <div class="col-10" style="">
                                    <input type="checkbox" name="familiar" id="familiar" style="margin-left: 5px; vertical-align: middle; height: 38px; ">
                                </div>
                            </div>
                                <input style="display: none;" type="text" name="accion" id="accion" value="altaSocio" required>
                                
                                <input style="display: none;" type="text" name="carnetForm" id="carnetForm" value="" >
                                <input style="display: none;" type="text" name="categoriaForm" id="categoriaForm" value="" >
                                <input style="display: none;" type="date" name="vencimientoCarnetForm" id="vencimientoCarnetForm" value="" >
                                <input style="display: none;" type="date" name="vencimientoCiForm" id="vencimientoCiForm" value="" >
                                
                                <input style="display: none;" type="text" name="crearJugador" id="crearJugador" value="no" required>
                                
                            <div style="text-align: right; margin-top: 5px;">
                                <input type="submit" class="btn btn-primary" value="Agregar" id="agregarSocio" onclick="
                                        //No hay tipo socios en el sistema
                                        if($('#tipo option:selected').text().trim() === 'Ninguno'){
                                            $('#agregarSocio').removeAttr('type').attr('type', 'button');
                                            $('#tipoSocioError').click();
                                        } else {
                                            $('#agregarSocio').removeAttr('type').attr('type', 'submit');
                                        }
                                        $('#categoriaForm').val($('#categoriasCombo option:selected').text());
                                        $('#carnetForm').val($('#carnet option:selected').index()); // 0 = salud, 1 = adolescente. 2 = niño
                                        $('#vencimientoCarnetForm').val($('#vencimientoCarnet').val());
                                        $('#vencimientoCiForm').val($('#vencimientoCedula').val());
                                        
                                        if($('#jugador').prop('checked') === true){
                                            $('#vencimientoCarnet').attr('form', 'submitForm');
                                            $('#vencimientoCedula').attr('form', 'submitForm');
                                            $('#crearJugador').attr('value', 'si');
                                        } else {
                                            $('#crearJugador').attr('value', 'no');
                                            try{
                                                $('#vencimientoCarnet').removeAttr('form');
                                                $('#vencimientoCedula').removeAttr('form');
                                            } catch(e){
                                                console.log(e);
                                            }
                                        }
                                    " />
                                <input type="button" class="btn btn-secondary" onclick="
                                    limpiarCampos(); 
                                    $('#jugador').prop('checked', false); 
                                    $('#divJugador > h3').css('background-color', 'rgb(178,146,146)');
                                        " value="Cancelar"/> <!-- Al cancelar que limpie los campos no?-->
                            </div>
                        </form>
                    </div>
                    <div class="col-8" style=""><!--style="border: solid; border-color: black;"-->
                        <div style="" id="divJugador">
                            <br>
                            <h3 style="text-align: center; color: white"  >JUGADOR </h3>
                            <div class="row" style="margin-top: 5px;">
                                <div class="col-2">
                                    <label for="carnet" style="vertical-align: middle; line-height: 38px;"> Carnet: </label>
                                </div>
                                <div class="col-3">
                                    <select style="" name="carnet" id="carnet" class="form-control" required>
                                        <option> Salud</option>
                                        <option> Adolescente</option>
                                        <option> Niño</option>
                                    </select>
                                </div>
                                <div class="col-3">
                                    <label for="vencimientoCarnet" style="vertical-align: middle; line-height: 38px;"> Vencimiento: </label>
                                </div>
                                <div class="col-3">
                                    <input style="" autocomplete="off" type="date" name="vencimientoCarnet" id="vencimientoCarnet" class="form-control" placeholder="dd/MM/aaaa..." required >
                                </div>
                            </div>
                            <div class="row" style="margin-top: 5px;">
                                <div class="col-2">
                                    <label for="categorias" style="vertical-align: middle; line-height: 38px;"> Categoria: </label>
                                </div>
                                <div class="col-3">
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
                                </div>
                                <div class="col-3">
                                    <label for="vencimientoCedula" style="vertical-align: middle; line-height: 38px;"> Vencimiento de cédula: </label>
                                </div>
                                <div class="col-3">
                                    <input style="" autocomplete="off" type="date" name="vencimientoCedula" id="vencimientoCedula" class="form-control" placeholder="dd/MM/aaaa..." required >
                                </div>
                            </div>
                        </div>
                        <div style="" id="divFamiliares">
                            <br>
                            <h3 style="text-align: center; color: white" >FAMILIARES </h3>
                            <table class="table table-light table-striped table-hover" id="tablaFamilia">
                                <thead>
                                    <tr style="">
                                        <th scope="col">Nombre</th>
                                        <th scope="col">Apellido</th>
                                        <th scope="col">Cédula</th>
                                        <th scope="col">Nacimiento</th>
                                        <th scope="col">Principal</th>
                                    </tr>
                                </thead>
                                <tbody>
                                </tbody>
                            </table>
                            <form action="/TouringBBC/Socios" method="post" style="text-align: right;" id="formFamilia" class="formFamilia">
                                <input type="text" style="display: none;" name="indexPrincipal" id="indexPrincipal" value="" />
                                <input type="text" style="display: none;" name="accion" id="accion" value="altaFamilia"  required/>
                                <div class="row" style="margin-top: 5px;">
                                    <div class="col-7">
                                        <label id="labelCuotaFamilia" for="cuotaFamilia" style="vertical-align: middle; line-height: 38px; display: none;"> Cuota: </label>
                                    </div>
                                    <div class="col-2">
                                        <select style="margin-left: 5px; display: none;" name="cuotaFamilia" id="cuotaFamilia" class="form-control" required>
                                            <option > Ninguna </option>
                                            <% if(request.getAttribute("cuotas") != null) {%>
                                                <% List<Cuota> cuotas = (List<Cuota>) request.getAttribute("cuotas");
                                                if (cuotas != null) {
                                                    for (Cuota c : cuotas) {%>
                                                        <option > <%= c.getNombre()%></option>
                                                    <%}%>
                                                <%}%>
                                            <%}%> 
                                        </select>
                                    </div>
                                    <div class="col-3">
                                        <input type="hidden" class="btn btn-primary" value="Confirmar alta" id="confirmarAlta" name="confirmarAlta" onclick="
                                               console.log($('#tablaFamilia > tbody > tr').find(`td > input[name='rol']:checked`).val());
                                               $('#indexPrincipal').attr('value', $('#tablaFamilia > tbody > tr').find(`td > input[name='rol']:checked`).val());
                                                " />
                                    </div>
                                </div>
                                
                            </form> 
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <!-- Modal error Cedula invalida -->
        <div class="modal fade " id="errorCedulaInvalida" tabindex="-1" aria-labelledby="errorCedulaInvalidaLabel" aria-hidden="true">
            <div class="modal-dialog modal-dialog-centered modal-md">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title" id="errorCedulaInvalidaLabel">Error, cédula invalida</h5>
                        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                    </div>
                    <div class="modal-body" style="text-align: center">
                        <input type="button" class="btn btn-primary" value="Aceptar" data-bs-dismiss="modal"/>
                    </div>
                </div>
            </div>
        </div>
        <!-- Modal error Cedula invalida -->
        <div class="modal fade " id="errorSocioExiste" tabindex="-1" aria-labelledby="errorSocioExisteLabel" aria-hidden="true">
            <div class="modal-dialog modal-dialog-centered modal-md">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title" id="errorSocioExisteLabel"></h5>
                        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                    </div>
                    <div class="modal-body" style="text-align: center">
                        <form action="/TouringBBC/Socios" method="post" class="submitForm2">
                            <input type="text" style="display: none;" name="cedulaAct" id="cedulaAct" value=""  required/>
                            <input type="text" style="display: none;" name="accion" id="accion" value="activarSocio"  required/>
                            <input type="button" id="errorSocioExisteBoton" class="btn btn-primary" value="Aceptar" data-bs-dismiss="modal"/>
                            <input type="button" id="errorSocioExisteCancelar" class="btn btn-secondary" value="Cancelar" data-bs-dismiss="modal"/>
                        </form>
                    </div>
                </div>
            </div>
        </div>
        <!-- Modal Error Categoria-->
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
        <!-- Modal Error No existen tipos de socios-->
        <div class="modal fade " id="tipoSocioErrorNotExist" tabindex="-1" aria-labelledby="tipoSocioErrorNotExistLabel" aria-hidden="true">
            <div class="modal-dialog modal-dialog-centered modal-md">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title" id="tipoSocioErrorNotExistLabel">Error, no existe ningun tipo de socio en el sistema</h5>
                        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                    </div>
                    <form action="/TouringBBC/Socios" method="get">
                        <div class="modal-body" style="text-align: center">
                            <input type="text" style="display: none;" name="accion" id="accion" value="tipoSocios"  required/>
                            <input type="submit" class="btn btn-primary" value="Agregar Nuevo"/>
                            <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cancelar</button>
                        </div>
                    </form>
                </div>
            </div>
        </div>
        <!-- Modal Error FamiliaPrincipal no seleccionado -->
        <div class="modal fade " id="errorRolFamilia" tabindex="-1" aria-labelledby="errorRolFamiliaLabel" aria-hidden="true">
            <div class="modal-dialog modal-dialog-centered modal-md">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title" id="errorRolFamiliaLabel">Seleccione un principal en la familia, por favor</h5>
                        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                    </div>
                    <div class="modal-body" style="text-align: center">
                        <input type="text" style="display: none;" name="accion" id="accion" value="nueva"  required/>
                        <input type="submit" class="btn btn-primary" value="Aceptar" data-bs-dismiss="modal"/>
                    </div>
                </div>
            </div>
        </div>
        <!-- Modal Eliminar Familia? -->
        <div class="modal fade " id="eliminarFamiliaCreada" tabindex="-1" aria-labelledby="eliminarFamiliaCreadaLabel" aria-hidden="true">
            <div class="modal-dialog modal-dialog-centered modal-md">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title" id="eliminarFamiliaCreadaLabel">¿Cancelar creacion de familia?</h5>
                        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                    </div>
                    <div class="modal-body" style="text-align: center">
                        <input type="submit" class="btn btn-primary" value="Aceptar" onclick="
                                arrayFamily = [];
                                arrayFamilyJSON = [];
                                $('#tablaFamilia > tbody').empty();
                                $('#confirmarAlta').removeAttr('type').attr('type', 'hidden');
                                $('#familiar').prop('checked', false);
                                $('#labelCuotaFamilia').hide();
                                $('#cuotaFamilia').hide();
                                $('#agregarSocio').prop('disabled', false);
                               " data-bs-dismiss="modal"/>
                        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal" onclick="
                                $('#familiar').prop('checked', true);
                                ">Cancelar</button>
                    </div>
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
                    console.log(array2[index]);
                    if(array2[index]['edad-min'] <= diferencia && array2[index]['edad-max'] >= diferencia){
                        $('#categoriasCombo').prop('selectedIndex', index);
                    } else {
                        array2.forEach(function callback(item, index, array) {
                            if(item['edad-min'] <= diferencia && item['edad-max'] >= diferencia){
                                $('#categoriasCombo').prop('selectedIndex', index);
                            }
                        });
                    }
                    console.log(diferencia);
                    console.log(fechaNueva);
                    console.log(today);
                });
            });
            function validation_digit(ci){
                var a = 0;
                var i = 0;
                if(ci.length <= 6){
                    for(i = ci.length; i < 7; i++){
                        ci = '0' + ci;
                    }
                }
                for(i = 0; i < 7; i++){
                    a += (parseInt("2987634"[i]) * parseInt(ci[i])) % 10;
                }
                if(a%10 === 0){
                    return 0;
                }else{
                    return 10 - a % 10;
                }
            }
            function validate_ci(ci){
                ci = clean_ci(ci);
                var dig = ci[ci.length - 1];
                ci = ci.replace(/[0-9]$/, '');
                return (dig == validation_digit(ci));
            }
            function clean_ci(ci){
                return ci.replace(/\D/g, '');
            }
            var arrayFamilyJSON = [];
            var arrayFamily = [];
            var deleteLastRow = false;
            $(function(){
                $('.submitForm').on('submit', function(event){
                    let example = document.querySelector('.cedulas');
                    var arrayCedulas = JSON.parse(example.innerHTML);
                    console.log(arrayCedulas);
                    console.log(clean_ci($('#cedula').val()));
                    if(!validate_ci($('#cedula').val())){
                        event.preventDefault();
                        $('#errorCedula').click();
                    } else { // Agregar IF para cuando no haya tipos de socios en el sistema
                        arrayCedulas.forEach(function callback(item, index, array) {
                            if(item['numero'] == clean_ci($('#cedula').val())){
//                                alert(item['numero'] + ' ' + item['vigente']);
                                if(item['vigente'] == true){ // Error ya existe ese Socio
                                    $('#errorSocioExisteLabel').text('Error, el Socio ya está ingresado en el sistema');
                                    $('#errorSocioExisteBoton').val('Aceptar');
                                    $('#errorSocioExisteBoton').removeAttr("type").attr("type", "button");
//                                    alert('AAAAAAAAAAAAAAAAAAAAAa1');
                                    deleteLastRow = true;
                                } else { // Preguntar si lo quiere activar de nuevo
//                                    alert('AAAAAAAAAAAAAAAA' + $('#familiar').prop('checked'));
                                    if($('#familiar').prop('checked') == false){
                                        $('#errorSocioExisteBoton').removeAttr("type").attr("type", "submit");
                                        $('#errorSocioExisteLabel').text('El Socio ya está en el sistema ¿Activarlo?');
                                        $('#cedulaAct').attr('value', $('#cedula').val());
//                                    alert('AAAAAAAAAAAAAAAAAAAAAa2');
                                    } else {
                                        $('#errorSocioExisteLabel').text('Error, el Socio ya está ingresado en el sistema');
                                        $('#errorSocioExisteBoton').val('Aceptar');
                                        $('#errorSocioExisteBoton').removeAttr("type").attr("type", "button");
                                        deleteLastRow = true;
//                                        $('#tablaFamilia > tbody tr:last').remove();
//                                    alert('AAAAAAAAAAAAAAAAAAAAAa3');
                                    }
                                }
//                                    alert('AAAAAAAAAAAAAAAAAAAAAa4');
                                event.preventDefault();
                                $('#errorSocio').click();
                                return;
                            }
                        });
                        var familiar = $('#familiar');
                        var jugador = $('#jugador');
                        if(jugador.prop('checked') === false && familiar.prop('checked') === false){ // Socio comun (No jugador ni familia)
                            //Crear socio simple ______ENVIAR FORM
                                console.log('Hola1');
                            // FUNCIONANDOOOOO############################################################################################################################################################################################################
//                            event.preventDefault();
//                            return;
                        } else {
                            if(jugador.prop('checked') === true && familiar.prop('checked') === true){ // Crear Jugador en la familia No enviar form sino meter todos los datos en un Array Json, en la tabla y esperar
                                // Crear Obj Socio-Jugador y meter en el array _____NO ENVIAR FORM
//                                $('#confirmarAlta').removeAttr('type').attr('type', 'submit'); // Hace visible el boton para confirmar el alta 
//                                if(!arrayFamily){
//                                    var arrayFamily = [];
//                                    console.log('RECIEN CREADA');
//                                }
//                                if($('#jugador').prop('checked') === true){
                                let cedularepetida = false;
                                    $.each(arrayFamilyJSON, function(i, item){ 
                                        if (item['cedula'] == $('#cedula').val()) { 
                                            cedularepetida =  true;
                                        }
                                    });
                                    
                                if (cedularepetida) {
                                    $('#errorSocioExisteLabel').text('Error, el Socio ya está ingresado en el sistema');
                                    $('#errorSocioExisteBoton').val('Aceptar');
                                    $('#errorSocioExisteBoton').removeAttr("type").attr("type", "button");
                                    event.preventDefault();
                                    $('#errorSocio').click();
                                    limpiarCampos();
                                    return;
                                } else {

                                    const jugador = {
                                        carnet: $('#carnet option:selected').index(),
                                        categoria: $('#categoriasCombo option:selected').text(),
                                        vencimientoCarnet: $('#vencimientoCarnet').val(),
                                        vencimientoCedula: $('#vencimientoCedula').val()
                                    };
                                    const familiar = {
                                        nombre: $('#nombre').val(),
                                        apellido: $('#apellido').val(),
                                        direccion: $('#direccion').val(),
                                        telefono: $('#telefono').val(),
                                        cedula: $('#cedula').val(),
                                        ingreso: $('#fechaIngreso').val(),
                                        nacimiento: $('#fechaNacimiento').val(),
                                        tipo: $('#tipo').val(),
                                        jugador: JSON.stringify(jugador)
                                    };
                                    if(deleteLastRow === false){
                                        arrayFamily.push(JSON.stringify(familiar));
                                        arrayFamilyJSON.push(familiar);
                                        $('#tablaFamilia').find('tbody')
                                            .append($('<tr>')
                                                .append($('<td>')
                                                    .text(familiar['nombre'])
                                                )
                                                .append($('<td>')
                                                    .text(familiar['apellido'])
                                                )
                                                .append($('<td>')
                                                    .text(familiar['cedula'])
                                                )
                                                .append($('<td>')
                                                    .text(familiar['nacimiento'])
                                                )
                                                .append($('<td>')
        //                                            .append('<input type=radio name=rol>')
                                                    .append($('<input>').attr({
                                                            type: 'radio',
                                                            name: 'rol',
                                                            value: $('#tablaFamilia tr').length
                                                        })
                                                    )
                                                )
                                            );
                                        $('#confirmarAlta').removeAttr('type').attr('type', 'submit'); // Hace visible el boton para confirmar el alta 
                                        $('#labelCuotaFamilia').show();
                                        $('#cuotaFamilia').show();
                                    } else {
                                        deleteLastRow = false;
                                    }
                                    if($('#tablaFamilia > tbody tr').length === 4){
//                                        $('#agregarSocio').attr('readonly', true);
//                                        alert('AAAAAAAAAAAAAAAAAAA');
                                        $('#agregarSocio').prop('disabled', true);
                                    } else {
//                                        $('#agregarSocio').attr('readonly', false);
                                        $('#agregarSocio').prop('disabled', false);
                                    }

                                    $('#jugador').prop('checked', false);
                                    $('#divJugador > h3').css('background-color', 'rgb(178,146,146)');
                                    limpiarCampos();

                                    console.log(arrayFamily);
                                    console.log('Hola2');
                                    event.preventDefault();
                                    return;
                                }
                            } else {
                                
                                console.log($('#jugador').prop('checked'));
                                if ($('#jugador').prop('checked') === true){ // Crear solo jugador 
                                //Crear Socio jugador _____ENVIAR FORM
                                    console.log('Holaaaaaaaaaaaa');
                            // FUNCIONANDOOOOO############################################################################################################################################################################################################
//                                $('<input type=hidden>').attr({
//                                    name: 'crearJugador',
//                                    value: 'si'
//                                }).appendTo('#submitForm');
                                    return;
                                } else { // Solo familia chequeado
                                    let cedularepetida = false;
                                    $.each(arrayFamilyJSON, function(i, item){ 
                                        if (item['cedula'] == $('#cedula').val()) { 
                                            cedularepetida =  true;
                                        }
                                    });
                                    
                                    if (cedularepetida) {
                                        $('#errorSocioExisteLabel').text('Error, el Socio ya está ingresado en el sistema');
                                        $('#errorSocioExisteBoton').val('Aceptar');
                                        $('#errorSocioExisteBoton').removeAttr("type").attr("type", "button");
                                        event.preventDefault();
                                        $('#errorSocio').click();
                                        limpiarCampos();
                                        return;
                                    } else {
                                        const familiar = {
                                            nombre: $('#nombre').val(),
                                            apellido: $('#apellido').val(),
                                            direccion: $('#direccion').val(),
                                            telefono: $('#telefono').val(),
                                            cedula: $('#cedula').val(),
                                            ingreso: $('#fechaIngreso').val(),
                                            nacimiento: $('#fechaNacimiento').val(),
                                            tipo: $('#tipo').val()
                                        };
                                        console.log(deleteLastRow);
                                        if(deleteLastRow === false){
                                            arrayFamily.push(JSON.stringify(familiar));
                                            arrayFamilyJSON.push(familiar);
                                            $('#tablaFamilia').find('tbody')
                                                .append($('<tr>')
                                                    .append($('<td>')
                                                        .text(familiar['nombre'])
                                                    )
                                                    .append($('<td>')
                                                        .text(familiar['apellido'])
                                                    )
                                                    .append($('<td>')
                                                        .text(familiar['cedula'])
                                                    )
                                                    .append($('<td>')
                                                        .text(familiar['nacimiento'])
                                                    )
                                                    .append($('<td>')
        //                                                .append('<input type=radio name=rol>').prop('value', $('#myTable tr').length)
                                                        .append($('<input type=radio>').attr({
                                                                name: 'rol',
                                                                value: $('#tablaFamilia tr').length
                                                            })
                                                        )
        //                                            .append('<input>', {
        //                                                    type: 'radio',
        //                                                    name: 'rol', 
        //                                                    value: $('#myTable tr').length
        //                                                })
                                                    )
                                                );
                                            $('#confirmarAlta').removeAttr('type').attr('type', 'submit'); // Hace visible el boton para confirmar el alta 
                                            $('#labelCuotaFamilia').show();
                                            $('#cuotaFamilia').show();
                                        } else {
                                            deleteLastRow = false;
                                        }
                                        if($('#tablaFamilia > tbody tr').length === 4){
//                                            $('#agregarSocio').attr('readonly', true);
                                            $('#agregarSocio').prop('disabled', true);
//                                            alert('AAAAAAAAAAAAAAAAAAA');
                                        } else {
                                            $('#agregarSocio').prop('disabled', false);
//                                            $('#agregarSocio').attr('readonly', false);
                                        }
                                        limpiarCampos();
    //                                    $('#labelCuotaFamilia').css("visibility", "visible");
    //                                    $('#cuotaFamilia').css("visibility", "visible");

    //                                    cuotaFamilia
                                        //Crear Obj Socio simple y meter en el array  _____NO ENVIAR FORM
    //                                    $('#confirmarAlta').removeAttr('type').attr('type', 'submit'); // Hace visible el boton para confirmar el alta 

                                        console.log('Hola3');
                                        event.preventDefault();
                                        return;
                                    }
                                }
    //                            console.log('Todavia no hecho, No ejecutar nada');
                                console.log('Hola4');
                                event.preventDefault();
                                return;
                            }
                        }
                    }
                }); 
            });
            $(function(){
                $('.formFamilia').on('submit', function(event){
                    if($('#indexPrincipal').val() === ""){
                        $( '#errorRol' ).click();
                        event.preventDefault();
                        return;
                    } else {
//                    arrayFamily.push('pepeeee');
                        $('<input type=hidden>').attr({
                            name: 'familia[]',
                            value: arrayFamily
                        }).appendTo('#formFamilia');
                    }
                });
            });
            $('#jugador').change(function () {
                if($(this).prop('checked') == true) {
                    
                    //comprobar que exista una categoria para el socio sino es asi darle checked == false
                    var fechaNueva = $('#fechaNacimiento').val();
                    var fechaNuevaDate = new Date(fechaNueva);
                    var hoy = new Date();
                    var date = hoy.getFullYear()+'-'+(hoy.getMonth()+1)+'-'+hoy.getDate();
                    var dif = hoy.getFullYear() - fechaNuevaDate.getFullYear();
                    let ejemplo = document.querySelector('.ejemploCategorias');
                    var array = JSON.parse(ejemplo.innerHTML);
                    console.log(array);
                    
                    var indiceCategoriaCorrespondiente = -1;
                    array.forEach(myFunction);
                    if(indiceCategoriaCorrespondiente == -1){
                        $('#jugador').prop('checked', false);
                        
                        errorCategoria();
                    } else {
                        $('#categoriasCombo').prop('selectedIndex', indiceCategoriaCorrespondiente);
                        $('#divJugador > h3').css('background-color', 'rgb(181,31,36)');      
                    }
                    function myFunction(item, index, arr) {
                        if(item['edad-min'] <= dif && item['edad-max'] >= dif){
                            indiceCategoriaCorrespondiente = index;
                        }
                    }
                    function errorCategoria(){
                        $( '#errorCat' ).click();
                    }
                } else {
                    $('#divJugador > h3').css('background-color', 'rgb(178,146,146)');   
                    
                }
            });
            $('#familiar').change(function () {
                if($(this).prop('checked') === false) {
//                    $('#divFamiliares').css('display', 'none');   
                    $('#divFamiliares > h3').css('background-color', 'rgb(178,146,146)');
                    $('#cuota').attr('readonly', false);
                    if(arrayFamily.length >= 1){
                        $( '#eliminarFamilia' ).click();
                        $('#familiar').prop('checked', true);
                    }
                } else {
//                    $('#divFamiliares').css('display', 'block');   
                    $('#divFamiliares > h3').css('background-color', 'rgb(181,31,36)'); 
                    $('#cuota').attr('readonly', true);
//                    labelCuotaFamilia
                }
            });
            function limpiarCampos(){
//                $('#carnet option:selected').index();
//                $('#categoriasCombo option:selected').text();
                $('#vencimientoCarnet').val("");
                $('#vencimientoCedula').val("");
                $('#nombre').val("");
                $('#apellido').val("");
                $('#direccion').val("");
                $('#telefono').val("");
                $('#cedula').val("");
                $('#fechaIngreso').val("");
                $('#fechaNacimiento').val("");
                $('#tipo').prop('selectedIndex', 0);
            }
//            $('#tablaFamilia input').on('change', function() {
//                alert($('input[name=radio]:checked', '#tablaFamilia').val());
//            });
                $('#tablaFamilia').find("input[name='rol']:checked").val(); // Hacer estoooo xD
                
                $('#tablaFamilia input') // select the radio by its id
                .change(function(){ // bind a function to the change event
                    if( $(this).is(":checked") ){ // check if the radio is checked
//                        alert($(this).val());
                        alert($('#tablaFamilia').find("input[name='rol']:checked").val());
//                        $('#indexPrincipal').attr('value', $(this).val());
                        $('#indexPrincipal').attr('value', $('#tablaFamilia > tbody > tr').find("td > input[name='rol']:checked").val());
                        console.log($('#tablaFamilia > tbody > tr').find("td > input[name='rol']:checked").val());
//                        var val = $(this).val(); // retrieve the value
                        
                    }
                });
        </script>                                
    </body>
</html>
