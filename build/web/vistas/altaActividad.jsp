<%-- 
    Document   : altaActividad
    Created on : 01-ago-2022, 10:35:05
    Author     : milto
--%>

<%@page import="Clases.Cuota"%>
<%@page import="java.util.List"%>
<%@page import="java.text.SimpleDateFormat"%>
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
        <div style="display: none;" class="actExistentes">
            <%=request.getAttribute("jsonAct")%>
        </div>
        <input id="errorCampos" name="errorCampos" type="button" data-bs-toggle="modal" data-bs-target="#errorCamposIncompletos" style="display: none;">
        <input id="errorNoSelected" name="errorNoSelected" type="button" data-bs-toggle="modal" data-bs-target="#errorNoSelectedHorarioCuota" style="display: none;">
        <input id="errorHorarioExist" name="errorHorarioExist" type="button" data-bs-toggle="modal" data-bs-target="#errorHorarioExistente" style="display: none;">
        <div class="bg-image" style="background-image: url('https://imgur.com/SvgFMB2.jpg'); background-position: center center; background-size:cover ; height: 120vh;">
            <div class="container">
                <br>
                <h1 style="text-align: center; color: white; background-color: rgb(181,31,36);">ALTA ACTIVIDAD </h1>
                <div class="row">
                    <div class="col-1">
                        <label for="nombreAct" style="vertical-align: middle; line-height: 38px;" > Nombre: </label>
                    </div>
                    <div class="col-6">
                        <input style="" type="text" name="nombreAct" id="nombreAct" class="form-control" form="formAlta" required>
                    </div>
                    <div class="col-1">
                        <label for="cuposAct" style="vertical-align: middle; line-height: 38px;"> Cupos: </label>
                    </div>
                    <div class="col-4">
                        <input style="" type="number" min="1" name="cuposAct" id="cuposAct" class="form-control" form="formAlta" required>
                    </div>
                </div>
                <div class="row">
                    <div class="col-4" ><!-- "style="border-color: red; border-style: solid; border-width: 3px; -->
                        <br>
                        <label for="nombre" style="text-align: center; width: 100%; color: white; background-color: rgb(181,31,36); margin-bottom: .5rem"><h3>CUOTAS</h3></label>
                            
                            <div class="row">
                                <div class="col-2">
                                    <label for="cuotas" style="vertical-align: middle; line-height: 38px;"> Cuotas: </label>
                                </div>
                                <div class="col-6">
                                    <select name="cuotas" id="cuotas" class="form-control" >
                                        <%List<Cuota> cuotas = (List<Cuota>) request.getAttribute("cuotas");
                                        SimpleDateFormat format = new SimpleDateFormat("dd/MM/yyyy");
                                        if (cuotas != null){
                                            for (Cuota t : cuotas) {%>
                                                <option> <%=t.getNombre()%> </option>
                                            <%}%>    
                                            <option> Nueva... </option>                                
                                        <%}%>    
                                    </select>
                                </div>
                                <div class="col-2">
                                    <input type="button" name="agregarCuota" id="agregarCuota" class="btn btn-primary" value="Agregar" onclick="
                                            let array = document.querySelector('.ejemploCuotas');
                                            var arrayCuotas = JSON.parse(array.innerHTML);
                                            let cuotaSelect = $('#cuotas option:selected').text();
                                            if(cuotaSelect.trim() === 'Nueva...'){
                                                $(location).prop('href', '/TouringBBC/Cuotas?accion=cuotas');
                                            } else {
                                                agregado = -1;
                                                arrayCuotas.forEach(function (item, index) {
                                                    if(item['nombre'] === cuotaSelect.trim()){
                                                        arrayCuotasSelect.push(item);
                                                        $('#tablaCuotas').find('tbody')
                                                            .append($('<tr data-bs-toggle=modal data-bs-target=#accionesCuota class=cuotaRow>')
                                                                .append($('<td class=cuotaName>')
                                                                    .text(item['nombre'])
                                                                )
                                                                .append($('<td>')
                                                                    .text(item['monto'])
                                                                )
                                                                .append($('<td>')
                                                                    .text(item['frecuencia'])
                                                                )
                                                            );
                                                        agregado = index;
                                                    }
                                                });
                                                if(agregado > -1){
                                                    $('#cuotas option:selected').remove();
                                                }
                                            }
                                           ">
                                </div>
                            </div>
                            <div style="margin-top: 5px;">
                                <table class="table table-light table-striped table-hover" id="tablaCuotas">
                                    <thead>
                                        <tr>
                                            <th scope="col">Nombre</th>
                                            <th scope="col">Monto</th>
                                            <th scope="col">Frecuencia</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        
                                    </tbody>
                                </table>
                            </div>
                    </div>
                    <div class="col-8"> <!-- "style="border-color: red; border-style: solid; border-width: 3px; -->
                        <br>
                        <label style="text-align: center; width: 100%; color: white; background-color: rgb(181,31,36); margin-bottom: .5rem" ><h3>HORARIOS</h3></label>
                        <div class="row">
                            <div class="col-1">
                                <label for="dias" style="vertical-align: middle; line-height: 38px;"> Dia: </label>
                            </div>
                            <div class="col-2">
                                <select name="dias" id="dias" class="form-control">
                                    <option> Lunes </option>   
                                    <option> Martes </option>   
                                    <option> Miércoles </option>   
                                    <option> Jueves </option>   
                                    <option> Viernes </option>   
                                    <option> Sábado </option>   
                                    <option> Domingo </option>   
                                </select>
                            </div>
                            <div class="col-1">
                                <label for="hora" style="vertical-align: middle; line-height: 38px;"> Hora: </label>
                            </div>
                            <div class="col-2">
                                <input type="number" name="hora" id="hora" min="0" max="23" class="form-control">
                            </div>
                            <div class="col-2">
                                <label for="duracion" style="vertical-align: middle; line-height: 38px;"> Duración(min): </label>
                            </div>
                            <div class="col-2">
                                <input type="number" name="duracion" id="duracion" class="form-control" min="0" step="15">
                            </div>
                            <div class="col-2">
                                <input type="button" name="agregarHorario" id="agregarHorario" class="btn btn-primary" value="Agregar" onclick="
                                        let existe = false;
                                        arrayHorariosSelect.forEach(function (item, index) {
                                            if(item['dia'] == $('#dias option:selected').text().trim() && item['hora'] == $('#hora').val() && item['duracion'] == $('#duracion').val()){
                                                existe= true;
                                            }
                                        });
                                        if(existe){
                                                $('#errorHorarioExist').click();
                                        } else {
                                            if($('#hora').val() !== '' && $('#duracion').val() !== '' && $('#duracion').val() !== '0'){
                                                $('#tablaHorarios').find('tbody')
                                                    .append($('<tr data-bs-toggle=modal data-bs-target=#accionesHorario class=horarioRow>')
                                                        .append($('<td class=horarioName>')
                                                            .text($('#dias option:selected').text())
                                                        )
                                                        .append($('<td>')
                                                            .text($('#hora').val())
                                                        )
                                                        .append($('<td>')
                                                            .text($('#duracion').val())
                                                        )
                                                    );
                                                const item = {
                                                    dia: $('#dias option:selected').text().trim(),
                                                    hora: $('#hora').val(),
                                                    duracion: $('#duracion').val()
                                                };
                                                arrayHorariosSelect.push(item);
                                                $('#dias').prop('selectedIndex', 0);
                                                $('#hora').prop('value', '');
                                                $('#duracion').prop('value', '');
                                            } else {
                                                $('#errorCampos').click();
                                            }
                                        }
                                       ">
                            </div>
                        </div>
                        <div style="margin-top: 5px;">
                            <table class="table table-light table-striped table-hover" id="tablaHorarios">
                                <thead>
                                    <tr>
                                        <th scope="col">Día</th>
                                        <th scope="col">Hora</th>
                                        <th scope="col">Duración</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    
                                </tbody>
                            </table>
                        </div>
                        <div style="text-align: right;">
                            <form action="/TouringBBC/Actividades" method="post" id="formAlta" name="formAlta">
                                <input type="text" style="display: none;" name="accion" id="accion" value="altaActividad"  required/>
                                <input type="button" class="btn btn-primary" value="Confirmar Alta" id="enviarForm" onclick="
                                    let a = document.querySelector('.actExistentes');
                                    var actExistentes = JSON.parse(a.innerHTML);
                                    let nameRepet = false
                                    actExistentes.forEach(function(item, index){
                                        if($('#nombreAct').val().toUpperCase().trim() === item['nombre'].toString().toUpperCase()){
                                            //Ya existe ese nombre
                                            nameRepet = true;
                                        }
                                    });
                                    if(nameRepet){
                                        $('#nombreAct')[0].setCustomValidity('Ya existe otra actividad con ese nombre');
                                    } else 
                                        $('#nombreAct')[0].setCustomValidity('');
                                    
                                    arrayCuotasSelectJSON = [];
                                    arrayHorariosSelectJSON = [];
                                    if(arrayCuotasSelect.length < 1){
                                        $('#errorNoSelected').click();
                                        $('#errorNoSelectedLabel').text('Error, cuota no seleccionada');
                                    } else if(arrayHorariosSelect.length < 1){
                                        $('#errorNoSelected').click();
                                        $('#errorNoSelectedLabel').text('Error, horario no seleccionado');
                                    } else {
                                        arrayCuotasSelect.forEach(function(item, index){
                                            arrayCuotasSelectJSON.push(JSON.stringify(item));
                                        });
                                        arrayHorariosSelect.forEach(function(item, index){
                                            arrayHorariosSelectJSON.push(JSON.stringify(item));
                                        });
                                        $('<input type=hidden>').attr({
                                            name: 'arrayHorarios[]',
                                            value: arrayHorariosSelectJSON
                                        }).appendTo('#formAlta');
                                        $('<input type=hidden>').attr({
                                            name: 'arrayCuotas[]',
                                            value: arrayCuotasSelectJSON
                                        }).appendTo('#formAlta');
                                        
                                        $('#enviarForm').removeAttr('type').attr('type', 'submit');
                                        
                                    }
                                       ">
                            </form>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        
        <!-- Modal accionesCuotas -->
        <div class="modal fade" id="accionesCuota" tabindex="-1" aria-labelledby="accionesCuotaLabel" aria-hidden="true">
            <div class="modal-dialog modal-dialog-centered modal-lg">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title" id="accionesCuotaLabel">Cuota seleccionada</h5>
                        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                    </div>
                    <div class="modal-body" >
                        <table id="tablaModal" class="table table-light table-striped table-hover">
                            <thead>
                                <tr>
                                    <th scope="col">Fecha</th>
                                    <th scope="col">Nombre</th>
                                    <th scope="col">Monto</th>
                                    <th scope="col">Descripcion</th>
                                    <th scope="col">Frecuencia</th>
                                </tr>
                            </thead>
                            <tbody>
                                
                            </tbody>
                        </table>
                        <input type="text" style="display: none;" name="nombreCuota" id="nombreCuota"/>
                    </div>
                    <div class="modal-footer"style="text-align: center">
                        <input type="button" class="btn btn-primary" value="Quitar" data-bs-dismiss="modal" onclick="
                            $('#tablaCuotas > tbody  > tr').each(function(index, tr) {
                                let nombre = $(tr).find('td:first').text();
                                if (nombre === $('#nombreCuota').val()){
                                    tr.remove();
                                    $('#cuotas').prepend(new Option(nombre, nombre));
                                    arrayCuotasSelect.forEach(function (item, index) {
                                        if(item['nombre'] === $('#nombreCuota').val()){
                                            arrayCuotasSelect.splice(arrayCuotasSelect.indexOf(item),1);
                                        }
                                    });
                                }
                            });
                           ">
                        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Aceptar</button>
                    </div>
                </div>
            </div>
        </div>
        <!-- Modal accionesHorario -->
        <div class="modal fade" id="accionesHorario" tabindex="-1" aria-labelledby="accionesHorarioLabel" aria-hidden="true">
            <div class="modal-dialog modal-dialog-centered modal-lg">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title" id="accionesHorarioLabel">Horario seleccionado</h5>
                        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                    </div>
                    <div class="modal-body" >
                        <table id="tablaModal2" class="table table-light table-striped table-hover">
                            <thead>
                                <tr>
                                    <th scope="col">Día</th>
                                    <th scope="col">Horario</th>
                                    <th scope="col">Duración</th>
                                </tr>
                            </thead>
                            <tbody>
                                
                            </tbody>
                        </table>
                    </div>
                    <div class="modal-footer"style="text-align: center">
                        <input type="text" style="display: none;" name="diaModal" id="diaModal"/>
                        <input type="text" style="display: none;" name="horaModal" id="horaModal"/>
                        <input type="text" style="display: none;" name="duracionModal" id="duracionModal"/>
                        <input type="button" class="btn btn-primary" value="Quitar" data-bs-dismiss="modal" onclick="
                            $('#tablaHorarios > tbody  > tr').each(function(index, tr) {
                                let dia = $(tr).find('td:first').text();
                                let hora = $(tr).find('td:first').next().text();
                                let duracion = $(tr).find('td:first').next().next().text();
                                if(dia.trim() == $('#diaModal').val().trim() && hora == $('#horaModal').val() && duracion == $('#duracionModal').val()){
                                    tr.remove();
                                    arrayHorariosSelect.forEach(function (item, index) {
                                        if(item['dia'] == $('#diaModal').val().trim() && item['hora'] == $('#horaModal').val() && item['duracion'] == $('#duracionModal').val()){
                                           arrayHorariosSelect.splice(arrayHorariosSelect.indexOf(item), 1);
                                        }
                                    });
                                }
                            });
                           ">
                        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Aceptar</button>
                    </div>
                </div>
            </div>
        </div>
        <!-- Modal Error Campos incompletos al agregar un horario -->
        <div class="modal fade " id="errorCamposIncompletos" tabindex="-1" aria-labelledby="errorCamposIncompletosLabel" aria-hidden="true">
            <div class="modal-dialog modal-dialog-centered modal-md">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title" id="errorCamposIncompletosLabel">Hora y/o duración incorrectos</h5>
                        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                    </div>
                    <div class="modal-body" style="text-align: center">
                        <input type="submit" class="btn btn-primary" value="Aceptar" data-bs-dismiss="modal"/>
                    </div>
                </div>
            </div>
        </div>
        <!-- Modal Error Horario Existente -->
        <div class="modal fade " id="errorHorarioExistente" tabindex="-1" aria-labelledby="errorHorarioExistenteLabel" aria-hidden="true">
            <div class="modal-dialog modal-dialog-centered modal-md">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title" id="errorHorarioExistenteLabel">Horario ya existente</h5>
                        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                    </div>
                    <div class="modal-body" style="text-align: center">
                        <input type="submit" class="btn btn-primary" value="Aceptar" data-bs-dismiss="modal"/>
                    </div>
                </div>
            </div>
        </div>
        <!-- Modal Error Horario o Cuota no seleccionado -->
        <div class="modal fade " id="errorNoSelectedHorarioCuota" tabindex="-1" aria-labelledby="errorNoSelectedHorarioCuotaLabel" aria-hidden="true">
            <div class="modal-dialog modal-dialog-centered modal-md">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title" id="errorNoSelectedLabel"></h5>
                        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                    </div>
                    <div class="modal-body" style="text-align: center">
                        <input type="submit" class="btn btn-primary" value="Aceptar" data-bs-dismiss="modal"/>
                    </div>
                </div>
            </div>
        </div>
        
        
        <script type="text/javascript">
            var arrayCuotasSelect = [];
            var arrayCuotasSelectJSON = [];
            var arrayHorariosSelect = [];
            var arrayHorariosSelectJSON = [];
            $(function(){
                $('#tablaCuotas > tbody').click(function (e){
                    let td = e.target;
                    let tr = td.closest('tr');
                    let nombreSeleccionado = $(tr).find('td:first').text();
                    $('#tablaModal > tbody'). empty();
                    
                    let array = document.querySelector('.ejemploCuotas');
                    var arrayCuotas = JSON.parse(array.innerHTML);
                    arrayCuotas.forEach(function (item, index) {
                        if(item['nombre'] === nombreSeleccionado.trim()){
                            $('#tablaModal').find('tbody')
                                .append($('<tr>')
                                    .append($('<td>')
                                        .text(item['fecha'])
                                    )
                                    .append($('<td>')
                                        .text(item['nombre'])
                                    )
                                    .append($('<td>')
                                        .text(item['monto'])
                                    )
                                    .append($('<td>')
                                        .text(item['descripcion'])
                                    )
                                    .append($('<td>')
                                        .text(item['frecuencia'])
                                    )
                                );
                        }
                    });
                    
                    $('#nombreCuota').attr('value', nombreSeleccionado);
                });
            });
            $(function(){
                $('#tablaHorarios > tbody').click(function (e){
                    let td = e.target;
                    let tr = td.closest('tr');
                    let diaSelect = $(tr).find('td:first').text();
                    let horaSelect = $(tr).find('td:first').next().text();
                    let duracionSelect = $(tr).find('td:first').next().next().text();
                    $('#tablaModal2 > tbody'). empty();
                    $('#tablaModal2').find('tbody')
                        .append($('<tr>')
                            .append($('<td>')
                                .text(diaSelect)
                            )
                            .append($('<td>')
                                .text(horaSelect)
                            )
                            .append($('<td>')
                                .text(duracionSelect)
                            )
                        );
                    $('#diaModal').attr('value', diaSelect);
                    $('#horaModal').attr('value', horaSelect);
                    $('#duracionModal').attr('value', duracionSelect);
                });
            });
            function limpiarCampos(){
                $('#nombreForm').val("");
                $('#fechaForm').val("");
                $('#descripcionForm').val("");
                $('#montoForm').val("");
                $('#actividadForm').prop('selectedIndex', 0);                                                    
                $('#frecuenciaForm').prop('selectedIndex', 0);   
            }
        </script>   
    </body>
</html>