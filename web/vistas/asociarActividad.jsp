<%-- 
    Document   : asociarActividad
    Created on : 07-jul-2022, 19:22:01
    Author     : milto
--%>

<%@page import="java.util.ArrayList"%>
<%@page import="Clases.Cuota"%>
<%@page import="Clases.Actividad"%>
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
    <body onload="cargarCupos(); cargarHorarios();">
        <jsp:include page="header.jsp"/>
        <% Socio socio = (Socio) request.getAttribute("socio");%>
        <input id="errorCupos" name="errorCupos" type="button" data-bs-toggle="modal" data-bs-target="#errorCuposInsuficientes" style="display: none;">
        <input id="errorHorario" name="errorHorario" type="button" data-bs-toggle="modal" data-bs-target="#errorHorarioNoSeleccionado" style="display: none;">
        <div style="display: none;" class="actividadesCuotas"> 
            <%=request.getAttribute("arrayActividades")%>
        </div>
        <div class="bg-image" style="background-image: url('https://imgur.com/SvgFMB2.jpg'); background-position: center center; background-size:cover ; height: 120vh;">
            <div class="container">
                <h1 style="text-align: center; color: white; background-color: rgb(181,31,36);">ASOCIAR ACTIVIDAD </h1>
                <div class="row">
                    <div class="col-6" style="">
                        <div class="row" style="margin-top: 5px;">
                            <h5 style="text-align: center;"> Socio <%= socio.getNombre()  + " " + socio.getApellido()%></h5>
                        </div>
                        <div class="row" style="margin-top: 5px;">
                            <div class="col-2">
                                <label for="actividad" style="vertical-align: middle; line-height: 38px; margin-left: -3px;"> Actividad: </label>
                            </div>
                            <div class="col-10">
                                <select style="margin-left: 5px;" name="actividad" id="actividad" class="form-control" required onchange="
                                        $('#cuota').empty();
                                        $('#horariosBody').empty();
                                        var indexPrincipal = $('#actividad option:selected').index();
                                        let example = document.querySelector('.actividadesCuotas');
                                        var arrayAct = JSON.parse(example.innerHTML);
                                        arrayAct[indexPrincipal]['cuota'].forEach(function callback(item, index, array) {
                                            $('#cuota').append(new Option(item['nombre'], index));
                                        });
                                        $('#cupos').text('Cupos: ' + arrayAct[indexPrincipal]['cupos']);
                                        arrayAct[indexPrincipal]['horarios'].forEach(function callback(item, index, array) {
                                            console.log($('#actividad option:selected').text());
                                            $('#horarios').find('tbody')
                                                .append($('<tr>')
                                                    .append($('<td>')
                                                        .text(item['dia'])
                                                    )
                                                    .append($('<td>')
                                                        .text(item['hora'])
                                                    )
                                                    .append($('<td>')
                                                        .text(item['duracion'])
                                                    )
                                                    .append($('<td>').css('text-align','center')
                                                        .append('<input type=checkbox>')
                                                    )
                                                );
                                        });
                                        
                                        ">
                                    <% if(request.getAttribute("actividades") != null) {%>
                                        <% List<Actividad> actividades = (List<Actividad>) request.getAttribute("actividades");
                                        if (actividades != null) {
                                            for (Actividad t : actividades) {%>
                                            <option> <%= t.getNombre()%></option>
                                            <%}%>
                                        <%}%>
                                    <%}%> 
                                </select>
                            </div>
                        </div>
                        <div class="row" style="margin-top: 5px;">
                            <div class="col-2">
                                <label for="cuota" style="vertical-align: middle; line-height: 38px; margin-left: -3px;"> Cuota: </label>
                            </div>
                            <div class="col-10" >
                                <select style="margin-left: 5px;" name="cuota" id="cuota" class="form-control" required>
                                    <% if(request.getAttribute("actividades") != null) {%>
                                        <% List<Actividad> actividades = (List<Actividad>) request.getAttribute("actividades");
                                        if (actividades.get(0).getCuotas() != null) {
                                            for (Cuota c : actividades.get(0).getCuotas()) {%>
                                                <option > <%= c.getNombre()%></option>
                                            <%}%>
                                        <%}%>
                                    <%}%> 
                                </select>
                            </div>
                        </div>
                        <div class="row" style="margin-top: 5px;">
                            <div class="col-2" >
                                <p style="vertical-align: middle; line-height: 38px; margin-left: -3px;" id="cupos" name="cupos" > Cupos: 0</p>
                            </div>
                            <div class="col-2" style="text-align: right; margin-left: 5px;">
                                <form action="/TouringBBC/Socios" method="post" id="formEnvio" name="formEnvio" class="submitForm" >
                                    <input type="text" style="display: none;" name="accion" id="accion" value="asociarActividad"  required/>
                                    <input type="text" style="display: none;" name="actividadForm" id="actividadForm" value=""  required/>
                                    <input type="text" style="display: none;" name="cuotaForm" id="cuotaForm" value=""  required />
                                    <input type="text" style="display: none;" name="CISocio" id="CISocio" value="<%=socio.getCi()%>"  required/>
                                    <input type="submit" class="btn btn-primary" value="Confirmar" onclick="
                                        var indexPrincipal = $('#actividad option:selected').index();
                                        let example = document.querySelector('.actividadesCuotas');
                                        var arrayAct = JSON.parse(example.innerHTML);
                                        if((arrayAct[indexPrincipal]['cupos'] - 1) > -1){ // SI RESTANDO UN CUPO QUEDAN AL MENOS 0... SINO ERROR
                                            var cuotaSeleccionada = $('#cuota option:selected').text();
                                            $('#cuotaForm').val(cuotaSeleccionada);
                                            var actividadSeleccionada = $('#actividad option:selected').text();
                                            $('#actividadForm').val(actividadSeleccionada);
                                            var arrayHorarios = [];
                                            $('#horariosBody').find('tr').each(function() {
                                                var estacheckeado = false;
                                                var data2 = [];
                                                $(this).find('td').each(function (i, item) {
                                                    var xdata = $(this).find('input');
                                                    if(xdata.prop('type') == 'checkbox' && xdata.prop('checked') == true){
                                                        estacheckeado= true;
                                                        data2.push(true);
                                                    } else if(xdata.prop('type') == 'checkbox' && xdata.prop('checked') == false){
                                                    } else {
                                                        data2.push(item['outerText']);
                                                    }
                                                });
                                                if(estacheckeado == true){
                                                    arrayHorarios.push(data2);
                                                }
                                            });
                                            if(arrayHorarios.length == 0){ // NO HA SELECCIONADO UN HORARIO, ERROR
                                            } else {
                                                $('<input type=hidden>').attr({
                                                    name: 'arrayHorarios[]',
                                                    value: arrayHorarios
                                                }).appendTo('#formEnvio');
                                            }
                                        } else { // MOSTRAR UN MODAL QUE DIGA QUE NO HAY CUPOS DISPONIBLES
                                            var cuotaSeleccionada = $('#cuota option:selected').text();
                                            $('#cuotaForm').val(cuotaSeleccionada);
                                            var actividadSeleccionada = $('#actividad option:selected').text();
                                            $('#actividadForm').val(actividadSeleccionada);
                                        }
                                           ">
                                </form>
                            </div>
                        </div>
                    </div>
                    <div class="col-6" style="">
                        <table class="table table-light table-striped table-hover" id="horarios" name="horarios">
                            <thead id="horariosHead" name="horariosHead">
                                <tr>
                                    <th scope="col" style="">Día</th>
                                    <th scope="col" style="width: 20%;">Hora</th>
                                    <th scope="col" style="width: 20%;">Duracion</th>
                                    <th scope="col" style="width: 20%;">Seleccionar</th>
                                </tr>
                            </thead>
                            <tbody id="horariosBody" name="horariosBody">
                                
                            </tbody>
                        </table>
                    </div>
                </div>
            </div>
        </div>
        <!-- Modal error no hay cupos -->
        <div class="modal fade " id="errorCuposInsuficientes" tabindex="-1" aria-labelledby="errorCuposLabel" aria-hidden="true">
            <div class="modal-dialog modal-dialog-centered modal-md">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title" id="errorCuposLabel">Error, no hay cupos disponibles</h5>
                        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                    </div>
                    <div class="modal-body" style="text-align: center">
                        <input type="text" style="display: none;" name="accion" id="accion" value="nueva"  required/>
                        <input type="submit" class="btn btn-primary" value="Aceptar" data-bs-dismiss="modal"/>
                    </div>
                </div>
            </div>
        </div>
        <!-- Modal error no seleccionado un horario -->
        <div class="modal fade " id="errorHorarioNoSeleccionado" tabindex="-1" aria-labelledby="errorHorarioNoSeleccionadoLabel" aria-hidden="true">
            <div class="modal-dialog modal-dialog-centered modal-md">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title" id="errorHorarioNoSeleccionadoLabel">Seleccione un horario, por favor</h5>
                        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                    </div>
                    <div class="modal-body" style="text-align: center">
                        <input type="text" style="display: none;" name="accion" id="accion" value="nueva"  required/>
                        <input type="submit" class="btn btn-primary" value="Aceptar" data-bs-dismiss="modal"/>
                    </div>
                </div>
            </div>
        </div>
        <script type="text/javascript">
            function cargarHorarios(){
                $('#horariosBody').empty();
                var indexPrincipal = $('#actividad option:selected').index();
                let example = document.querySelector('.actividadesCuotas');
                var arrayAct = JSON.parse(example.innerHTML);
                arrayAct[indexPrincipal]['horarios'].forEach(function callback(item, index, array) {
                    $('#horarios').find('tbody')
                        .append($('<tr>')
                            .append($('<td>')
                                .text(item['dia'])
                            )
                            .append($('<td>')
                                .text(item['hora'])
                            )
                            .append($('<td>')
                                .text(item['duracion'])
                            )
                            .append($('<td>').css('text-align','center')
                                .append('<input type=checkbox>')
                            )
                        );
                });
            }
            function cargarCupos(){
                let example = document.querySelector('.actividadesCuotas');
                var arrayAct = JSON.parse(example.innerHTML);
                $('#cupos').text('Cupos: ' + arrayAct[0]['cupos'] );
            }
            $(function(){
                $('.submitForm').on('submit', function(event){
                    var indexPrincipal = $('#actividad option:selected').index();
                    let example = document.querySelector('.actividadesCuotas');
                    var arrayAct = JSON.parse(example.innerHTML);
                    if((arrayAct[indexPrincipal]['cupos']) === 0){
                        event.preventDefault();
                        $('#errorCupos').click();
                    } else {
                        var horarioSeleccionado = [];
                        $('#horariosBody').find('tr').each(function() {
                            $(this).find('td').each(function (i, item) {
                                var xdata = $(this).find('input');
                                if(xdata.prop('type') == 'checkbox' && xdata.prop('checked') == true){
                                    horarioSeleccionado.push('si');
                                    return false;
                                }
                            });
                        });
                        if(horarioSeleccionado.length == 0){ // NO HA SELECCIONADO UN HORARIO, ERROR
                            event.preventDefault();
                            $('#errorHorario').click();
                        }
                    }
                }); 
            });
            function mySubmitFunction(){
                var indexPrincipal = $('#actividad option:selected').index();
                let example = document.querySelector('.actividadesCuotas');
                var arrayAct = JSON.parse(example.innerHTML);
                if((arrayAct[indexPrincipal]['cupos']) === 0){
                    errorCupos();
                    return false;
                } else {
                    return true;
                }
            }
        </script>
    </body>
</html>
