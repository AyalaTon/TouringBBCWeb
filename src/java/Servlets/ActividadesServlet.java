/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Servlets;

import BD.Conexion;
import Clases.Actividad;
import Clases.Cuota;
import Clases.Horario;
import Controladores.CActividades;
import Controladores.CCuotas;
import com.google.gson.JsonArray;
import com.google.gson.JsonObject;
import com.google.gson.JsonParser;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 *
 * @author milto
 */
@WebServlet(name = "Actividades", urlPatterns = {"/Actividades"})
public class ActividadesServlet extends HttpServlet {

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet ActividadesServlet</title>");            
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet ActividadesServlet at " + request.getContextPath() + "</h1>");
            out.println("</body>");
            out.println("</html>");
        }
    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
//        processRequest(request, response);
        response.setContentType("text/html;charset=UTF-8");
        request.setCharacterEncoding("UTF-8");
        String url = request.getRequestURL().toString();
        String accion = request.getParameter("accion");
        if (accion != null) {
            switch (accion) {
                case "actividades":
                    
                    List<Actividad> actividades = CActividades.getActividades();
                    List<Actividad> actividadesVigentes = new ArrayList<>();
                    
//                    JsonArray array = new JsonArray();
                    for (Actividad gi : actividades)
                    {
                        if(gi.isVigente()){
                            actividadesVigentes.add(gi);
//                            JsonObject obj = new JsonObject();
//                            obj.addProperty("nombre", gi.getNombre());
//                            obj.addProperty("cupos", gi.getCupos());
//                            obj.addProperty("edad-max", gi.getHorarios());
//                            array.add(obj);
                        }
                    }
//                    request.setAttribute("jsonAct", array);
                    request.setAttribute("actividades", actividadesVigentes);
                    request.getRequestDispatcher("vistas/actividades.jsp").forward(request, response);
                    break;
                case "altaActividad":
                    List<Cuota> cuotas = CCuotas.getCuotas();
                    List<Cuota> cuotasVigentes = new ArrayList<>();
                    JsonArray array2 = new JsonArray();
                    if(cuotas != null && cuotas.size() > 0){
                        for (Cuota gi : cuotas)
                        {
                            if(gi.isVigente() && gi.getActividad() == null){
                                cuotasVigentes.add(gi);
                                JsonObject obj = new JsonObject();
                                obj.addProperty("fecha", gi.getFecha().toString());
                                obj.addProperty("nombre", gi.getNombre());
                                obj.addProperty("monto", gi.getMonto());
                                obj.addProperty("descripcion", gi.getDescripcion());
                                obj.addProperty("frecuencia", gi.getFrecuencia());
                                array2.add(obj);
                            }
                        }
                    }
                    List<Actividad> actividades2 = CActividades.getActividades();
                    List<Actividad> actividadesVigentes2 = new ArrayList<>();
                    
                    JsonArray array = new JsonArray();
                    for (Actividad gi : actividades2)
                    {
                        if(gi.isVigente()){
                            actividadesVigentes2.add(gi);
                            JsonObject obj = new JsonObject();
                            obj.addProperty("nombre", gi.getNombre());
//                            obj.addProperty("cupos", gi.getCupos());
//                            obj.addProperty("edad-max", gi.getHorarios());
                            array.add(obj);
                        }
                    }
                    request.setAttribute("jsonAct", array);
                    request.setAttribute("jsonCuo", array2);
                    request.setAttribute("cuotas", cuotasVigentes);
                    request.getRequestDispatcher("vistas/altaActividad.jsp").forward(request, response);
                    break;
            }
        } else {
            request.getRequestDispatcher("vistas/inicio.jsp").forward(request, response);
        }
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
//        processRequest(request, response);
        response.setContentType("text/html;charset=UTF-8");
        request.setCharacterEncoding("UTF-8");
        String url = request.getRequestURL().toString();
        String accion = request.getParameter("accion");
        if (accion != null) {
            switch (accion) {
                case "altaActividad":
                    System.out.println("\nCCCCREARRRRRRR ACTIVIDADDDDDDDDDDDDDDDDDD\n");
                    String nombreAct = request.getParameter("nombreAct");
                    String cuposAct = request.getParameter("cuposAct");
                    String arrayHorarios = request.getParameter("arrayHorarios[]");
                    String arrayCuotas = request.getParameter("arrayCuotas[]");
                    
                    String[] objetos = arrayHorarios.split("\\},\\{");
                    String[] objetos2 = arrayCuotas.split("\\},\\{");
                    List<JsonObject> arrayHorariosJSON = new ArrayList<>();
                    List<JsonObject> arrayCuotasJSON = new ArrayList<>();
                    
                    Actividad a = new Actividad();
                    a.setNombre(nombreAct);
                    a.setCupos(Integer.parseInt(cuposAct));
                    a.setVigente(true);
                    Conexion.getInstance().persist(a);
                    
                    List<Horario> horarios = new ArrayList<Horario>();
                    
                    for( int i=0; i < objetos.length; i++ ){
                        if(objetos.length > 1){
                            if(i+1 == objetos.length && i != 0){
                                objetos[i] = "{" + objetos[i];
                            } else if(i != 0){
                                objetos[i] = "{" + objetos[i] + "}";
                            } else {
                                objetos[i] = objetos[i] + "}";
                            }
                        }// Ya cortados de forma correcta
                        
                        System.out.println("\n" + objetos[i]);
                        JsonObject jsonObject = new JsonParser().parse(objetos[i]).getAsJsonObject();
                        arrayHorariosJSON.add(jsonObject);
                        
                        String dia = jsonObject.get("dia").toString().replaceAll("\"", "").trim();
                        String hora = jsonObject.get("hora").toString().replaceAll("\"", "").trim();
                        String duracion = jsonObject.get("duracion").toString().replaceAll("\"", "").trim();
//                        String[] split2222 = jsonObject.get("ingreso").toString().replaceAll("\"", "").trim().split("-");
                        System.out.println("\n" + "HORARIO: " + dia + " " + hora + " " + duracion);
                        
                        Horario h = new Horario();
                        h.setDia(dia);
                        h.setHora(Integer.parseInt(hora));
                        h.setDuracion(Integer.parseInt(duracion));
                        h.setActividad(a);
                        h.setVigente(true);
                        horarios.add(h);
//                        Conexion.getInstance().persist(h);
                        
                    }
                    List<Cuota> allCuotas = CCuotas.getCuotas();
//                    List<Cuota> cuotas = new ArrayList<Cuota>();
                    
                    for( int i=0; i < objetos2.length; i++ ){
                        if(objetos2.length > 1){
                            if(i+1 == objetos2.length && i != 0){
                                objetos2[i] = "{" + objetos2[i];
                            } else if(i != 0){
                                objetos2[i] = "{" + objetos2[i] + "}";
                            } else {
                                objetos2[i] = objetos2[i] + "}";
                            }
                        }// Ya cortados de forma correcta
                        
                        System.out.println("\n" + objetos2[i]);
                        JsonObject jsonObject = new JsonParser().parse(objetos2[i]).getAsJsonObject();
                        arrayCuotasJSON.add(jsonObject);
                        
                        String nombre = jsonObject.get("nombre").toString().replaceAll("\"", "").trim();
                        String monto = jsonObject.get("monto").toString().replaceAll("\"", "").trim();
                        String frecuencia = jsonObject.get("frecuencia").toString().replaceAll("\"", "").trim();
//                        String[] split2222 = jsonObject.get("ingreso").toString().replaceAll("\"", "").trim().split("-");
                        System.out.println("\n" + "CUOTA: " + nombre + " " + monto + " " + frecuencia);
                        
                        Cuota C = null;
                        for(Cuota c : allCuotas){
                            if(c.getNombre().equals(nombre.trim()))
                                C = c;
                        }
                        for(Horario h : horarios){
                            Conexion.getInstance().persist(h);
                        }
                        a.setHorarios(horarios);
                        Conexion.getInstance().merge(a);
                        C.setActividad(a);
                        Conexion.getInstance().merge(C);
                        
                    }
                    response.setHeader("Refresh","0.1; URL=\"" + url + "?accion=actividades\"");
                    break;
                case "modificarCuota":
//                    System.out.println("\nACTUALIZAR CUOTAAAAAAAAAAAAAAAA \n");
//                    String nombreCuotaNuevo = request.getParameter("nombreNuevo");
//                    String nombreCuotaViejo = request.getParameter("nombreViejo");
//                    String descripcionNueva = request.getParameter("descripcionNueva");
//                    String fechaNueva = request.getParameter("fechaNueva");
//                    String montoNuevo = request.getParameter("montoNuevo");
//                    String frecuenciaNueva = request.getParameter("frecuenciaNueva");
//                    String actividadNueva = request.getParameter("actividadNueva");
//                    System.out.println("\n" + fechaNueva);
//                    String[] split = fechaNueva.split("-");
//                    Date fechaNuevaDate = new Date(split[0] + "/" + split[1] + "/" + split[2]);
//                    
//                    List<Cuota> allCuotas = CCuotas.getCuotas();
//                    Cuota C = null;
//                    for(Cuota c : allCuotas){
//                        if(c.getNombre().equals(nombreCuotaViejo.trim()))
//                            C = c;
//                    }
//                    C.setNombre(nombreCuotaNuevo);
//                    C.setDescripcion(descripcionNueva);
//                    C.setMonto(Integer.parseInt(montoNuevo));
//                    C.setFrecuencia(frecuenciaNueva);
//                    C.setFecha(fechaNuevaDate);
//                    if(!actividadNueva.trim().equals("Ninguna")){
//                        C.setActividad(CSocios.findActividad(actividadNueva));
//                    }
//                    
//                    Conexion.getInstance().merge(C);
//                    Conexion.getInstance().refresh(C);
                    
//                    request.getRequestDispatcher("vistas/cuotas.jsp").forward(request, response);
//                    response.setHeader("Refresh","0.1; URL=\"" + url + "?accion=cuotas\"");
                    break;
            }
        } else {
            request.getRequestDispatcher("vistas/inicio.jsp").forward(request, response);
        }
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
