<%-- 
    Document   : altaCatgoria
    Created on : 28-jul-2022, 10:51:00
    Author     : milto
--%>

<%@page import="Clases.Categoria"%>
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
        <div style="display: none;" class="ejemploCategorias">
            <%=request.getAttribute("jsonCat")%>
        </div>
        <div class="bg-image" style="background-image: url('https://imgur.com/SvgFMB2.jpg'); background-position: center center; background-size:cover ; height: 120vh;">
            <div class="container">
                <br>
                <h1 style="text-align: center; color: white; background-color: rgb(181,31,36);">CATEGORIAS </h1>
                <div class="row">
                    <div class="col-6" ><!-- "style="border-color: red; border-style: solid; border-width: 3px; -->
                        <form action="/TouringBBC/Categorias" method="post">
                            <label for="nombre" style="text-align: center; width: 100%;"><h2>Nueva</h2></label>
                            <div class="row" style="margin-top: 5px;">
                                <div class="col-2" >
                                    <label for="nombre" style="vertical-align: middle; line-height: 38px;"> Nombre: </label>
                                </div>
                                <div class="col-10">
                                    <input style="margin-left: 5px;" autocomplete="off" type="text" name="nombre" id="nombre" class="form-control" autofocus required value="">
                                </div>
                            </div>
                            <div class="row" style="margin-top: 5px;">
                                <div class="col-2" >
                                    <label for="edadMin" style="vertical-align: middle; line-height: 38px; margin-left: -3px;"> Edad Min: </label>
                                </div>
                                <div class="col-4">
                                    <input style="margin-left: 5px;" autocomplete="off" type="number" min="1" max="150" name="edadMin" id="edadMin" class="form-control"  required>
                                </div>
                                <div class="col-2" >
                                    <label for="edadMax" style="vertical-align: middle; line-height: 38px; margin-left: -3px;"> Edad Max: </label>
                                </div>
                                <div class="col-4">
                                    <input style="margin-left: 5px;" autocomplete="off" type="number" min="1" max="150" name="edadMax" id="edadMax" class="form-control"  required>
                                </div>
                            </div>
                            <div style="text-align: right; margin-top: 5px;">
                                <input style="display: none;" type="text" name="accion" id="accion" value="altaCategoria" required>
                                <input type="submit" name="guardar" id="guardar" class="btn btn-primary" value="guardar" onclick="
                                        if($('#nombre').val().trim() === ''){
                                            $('#nombre')[0].setCustomValidity('Completa este campo');
                                            return;
                                        } else {
                                            $('#nombre')[0].setCustomValidity('');
                                        }
                                        if($('#edadMin').val()-0 > $('#edadMax').val()-0){
                                            $('#edadMin')[0].setCustomValidity('La edad minima debe ser menor a la máxima');
                                            return;
                                        } else {
                                            $('#edadMin')[0].setCustomValidity('');
                                        }
                                        let array = document.querySelector('.ejemploCategorias');
                                        var arrayCategorias = JSON.parse(array.innerHTML);
                                        let invalido = false;
                                        arrayCategorias.forEach(function (item) {
                                            if(item['nombre'].toUpperCase() === $('#nombre').val().trim().toUpperCase()){
                                                invalido = true;
                                            }

                                        });
                                        if(invalido === true)
                                            $('#nombre')[0].setCustomValidity('Ya existe otra categoria con ese nombre');
                                        else
                                            $('#nombre')[0].setCustomValidity('');

                                        let invalido2 = false;
                                        arrayCategorias.forEach(function (item) {
                                            let arrayItems = [];
                                            for(let j = item['edad-min']; j <= item['edad-max']; j++){
                                                arrayItems.push(j);
                                            }
                                            let arrayNuevo = [];
                                            for(let i = $('#edadMin').val()-0; i <= $('#edadMax').val()-0; i++){
                                                arrayNuevo.push(i);
                                            }
                                            if((jQuery.inArray(arrayNuevo[0], arrayItems) !== -1) || (jQuery.inArray(arrayNuevo[arrayNuevo.length-1], arrayItems) !== -1) || (jQuery.inArray(arrayItems[0], arrayNuevo) !== -1) || (jQuery.inArray(arrayItems[arrayItems.length-1], arrayNuevo) !== -1)){
                                                invalido2 = true;
                                            } else {// ERROR
                                            }
                                        });
                                        if(invalido2)
                                            $('#edadMin')[0].setCustomValidity('Error, los rangos de edades se superponen con otra categoria');
                                        else
                                            $('#edadMin')[0].setCustomValidity('');
                                       
                                       ">
                            </div>
                        </form>
                    </div>
                    <div class="col-6">
                        <label style="text-align: center; width: 100%;" ><h2>Lista</h2></label>
                        <div class="list-group">
                            <div style="overflow: auto; max-height: 70vh !important;">
                                <table class="table table-light table-striped table-hover">
                                    <thead>
                                        <tr>
                                            <th scope="col">Nombre</th>
                                            <th scope="col">Edad Mínima</th>
                                            <th scope="col">Edad Máxima</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                    <% List<Categoria> cats = (List<Categoria>) request.getAttribute("categorias");
                                    if (cats != null){
                                        for (Categoria t : cats) {%>
                                        <tr data-bs-toggle="modal" data-bs-target="#accionesActividad"  onclick="
                                                $('#nombreNuevo').val('<%=t%>'); 
                                                $('#nombreViejo').val('<%=t%>');
                                                $('#edadMaxForm').val('<%=t.getEdadMax()%>');
                                                $('#edadMinForm').val('<%=t.getEdadMin()%>');
                                                ">
                                            <td ><%=t%></td>
                                            <td><%=t.getEdadMin()%></td>
                                            <td><%=t.getEdadMax()%></td>
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
        </div>
        <!-- Modal -->
        <div class="modal fade " id="accionesActividad" tabindex="-1" aria-labelledby="accionesActividadLabel" aria-hidden="true">
            <div class="modal-dialog modal-dialog-centered">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title" id="accionesActividadLabel">Editar Categoria</h5>
                        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                    </div>
                    <form action="/TouringBBC/Categorias" method="post">
                        <div class="modal-body">
                            <input autocomplete="off" type="text" name="nombreNuevo" id="nombreNuevo" class="form-control" placeholder="Nombre..." required onchange="">
                            <input style="display: none;" type="text" name="nombreViejo" id="nombreViejo" required>
                            <input style="display: none;" type="text" name="accion" id="accion" value="modificarCategoria" required>
                            <div class="row" style="text-align: right; margin-top: 5px;">
                                <div class="col-3" >
                                    <label for="edadMinForm" style="vertical-align: middle; line-height: 38px; margin-left: -3px;"> Edad Min: </label>
                                </div>
                                <div class="col-3" >
                                    <input style="" type="number" name="edadMinForm" min="1" max="150" id="edadMinForm" value="" class="form-control" required>
                                </div>
                                <div class="col-3" >
                                    <label for="edadMaxForm" style="vertical-align: middle; line-height: 38px; margin-left: -3px;"> Edad Max: </label>
                                </div>
                                <div class="col-3" >
                                    <input style="" type="number" name="edadMaxForm" min="1" max="150" id="edadMaxForm" value="" class="form-control" required>
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
                                let array = document.querySelector('.ejemploCategorias');
                                var arrayCategorias = JSON.parse(array.innerHTML);
                                let invalido = false;
                                arrayCategorias.forEach(function (item) {
                                    if(item['nombre'].toUpperCase() !== $('#nombreViejo').val().toUpperCase()){
                                        if(item['nombre'].toUpperCase() === $('#nombreNuevo').val().trim().toUpperCase()){
                                            invalido = true;
                                        }
                                    }

                                });
                                if(invalido === true)
                                    $('#nombreNuevo')[0].setCustomValidity('Ya existe otra categoria con ese nombre');
                                else
                                    $('#nombreNuevo')[0].setCustomValidity('');
                                
                                let invalido2 = false;
                                arrayCategorias.forEach(function (item) {
                                    let arrayItems = [];
                                    for(let j = item['edad-min']; j <= item['edad-max']; j++){
                                        arrayItems.push(j);
                                    }
                                    let arrayNuevo = [];
                                    for(let i = $('#edadMinForm').val()-0; i <= $('#edadMaxForm').val()-0; i++){
                                        arrayNuevo.push(i);
                                    }
                                    if(item['nombre'] !== $('#nombreViejo').val()){
                                        if((jQuery.inArray(arrayNuevo[0], arrayItems) !== -1) || (jQuery.inArray(arrayNuevo[arrayNuevo.length-1], arrayItems) !== -1) || (jQuery.inArray(arrayItems[0], arrayNuevo) !== -1) || (jQuery.inArray(arrayItems[arrayItems.length-1], arrayNuevo) !== -1)){
                                            invalido2 = true;
                                        } else {// ERROR
                                        }
                                    }
                                });
                                if(invalido2)
                                    $('#edadMinForm')[0].setCustomValidity('Error, los rangos de edades se superponen');
                                else
                                    $('#edadMinForm')[0].setCustomValidity('');
                                
                            "/>
                        </div>
                    </form>
                </div>
            </div>
        </div>
    </body>
</html>
