<%-- 
    Document   : modificarAsociacion
    Created on : 20-jul-2022, 22:15:19
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
    <body>
        <jsp:include page="header.jsp"/>
        <input id="errorHorario" name="errorHorario" type="button" data-bs-toggle="modal" data-bs-target="#errorHorarioNoSeleccionado" style="display: none;">
        <% Socio socio = (Socio) request.getAttribute("socio");%>
        <% String actividad = (String) request.getAttribute("actividad");%>
        <% List<Cuota> cuotas = (List<Cuota>) request.getAttribute("cuotas");%>
        <% String IDSA = (String) request.getAttribute("IDSA");%>
        <div class="bg-image" style="background-image: url('https://imgur.com/SvgFMB2.jpg'); background-position: center center; background-size:cover ; height: 120vh;">
            <div class="container">
                <h1 style="text-align: center;">Modificar actividad asociada a <%= socio.getNombre()  + " " + socio.getApellido()%></h1>
                <div class="row">
                    <div class="col-6" style="border: solid; border-color: black;">
                        <div class="row" style="margin-top: 5px;">
                            <h5 style="text-align: center;"> Socio <%= socio.getNombre()  + " " + socio.getApellido()%></h5>
                        </div>
                        <div class="row" style="margin-top: 5px;">
                            <div class="col-2">
                                <label for="actividad" style="vertical-align: middle; line-height: 38px; margin-left: -3px;"> Actividad: </label>
                            </div>
                            <div class="col-10">
                                <select style="margin-left: 5px;" name="actividad" id="actividad" class="form-control" >
                                        <option> <%= actividad%></option>
                                </select>
                            </div>
                        </div>
                        <div class="row" style="margin-top: 5px;">
                            <div class="col-2">
                                <label for="cuota" style="vertical-align: middle; line-height: 38px; margin-left: -3px;"> Cuota: </label>
                            </div>
                            <div class="col-10" >
                                <select style="margin-left: 5px;" name="cuota" id="cuota" class="form-control">
                                    <%for (Cuota c : cuotas){ %>
                                        <option > <%=c.getNombre() %></option>
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
                                    <input type="text" style="display: none;" name="actividadForm" id="actividadForm" value="<%= actividad%>"  required/>
                                    <input type="text" style="display: none;" name="cuotaForm" id="cuotaForm" value=""  required />
                                    <input type="text" style="display: none;" name="socioForm" id="socioForm" value="<%=socio.getCi()%>"  required/>
                                    <input type="text" style="display: none;" name="modificarAsociacionConfirmacion" id="modificarAsociacionConfirmacion" value="<%=IDSA%>"  required/>
                                    
                                    <input type="submit" class="btn btn-primary" value="Confirmar" onclick="
                                            var cuotaSeleccionada = $('#cuota option:selected').text();
                                            $('#cuotaForm').val(cuotaSeleccionada);
                                            
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
                                           "/>
                                </form>
                            </div>
                        </div>
                    </div>
                    <div class="col-6" style="border: solid; border-color: black;">
                        <table class="table table-light table-striped table-hover" id="horarios" name="horarios">
                            <thead id="horariosHead" name="horariosHead">
                                <tr>
                                    <th scope="col" style="">Día</th>
                                    <th scope="col" style="width: 20%;">Hora</th>
                                    <th scope="col" style="width: 20%;">Duracion</th>
                                    <th scope="col" style="width: 20%;">Seleccionar</th>
                                </tr>
                            </thead>
                            <% if (request.getAttribute("horariosActiv") != null) {%>
                                <% List<String> horariosActiv = (List<String>) request.getAttribute("horariosActiv");%>
                                <% List<String> horariosSelect = (List<String>) request.getAttribute("horariosSelect");%>
                                <tbody id="horariosBody" name="horariosBody">
                                    <%for(int i = 0; i < horariosActiv.size(); i++ ){
                                        String[] fila = horariosActiv.get(i).split(",");
                                        boolean coincide = false;
                                            System.out.println("#########################################################################");
                                            System.out.println("horario de la actividad(i): " + horariosActiv.get(i));
                                        for(int x = 0; x < horariosSelect.size(); x++ ){
                                            System.out.println("horario seleccionado(x): " + horariosSelect.get(x));
                                            if(horariosActiv.get(i).equals(horariosSelect.get(x))){%>
                                                <% System.out.println("Entra porque coincide"); %>
                                                <tr>
                                                    <td> <%= fila[0] %> </td>
                                                    <td> <%= fila[1] %> </td>
                                                    <td> <%= fila[2] %> </td>
                                                    <td style="text-align: center"> <input type=checkbox checked> </td>
                                                </tr>
                                            <% coincide = true;
                                            }
                                        }
                                        if(!coincide){ %>
                                            <tr>
                                                <td> <%= fila[0] %> </td>
                                                <td> <%= fila[1] %> </td>
                                                <td> <%= fila[2] %> </td>
                                                <td style="text-align: center"> <input type=checkbox> </td>
                                            </tr>
                                        <%}%>
                                    <%}%>
                                </tbody>
                            <%}%>
                        </table>
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
            $(function(){
                $('.submitForm').on('submit', function(event){
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
                    if(horarioSeleccionado.length === 0){ // NO HA SELECCIONADO UN HORARIO, ERROR
                        event.preventDefault();
                        $('#errorHorario').click();
                    }
                });
            });
        </script>
    </body>
</html>
