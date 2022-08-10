/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Servlets;

import BD.Conexion;
import Clases.Actividad;
import Clases.Cuota;
import Controladores.CActividades;
import Controladores.CCuotas;
import Controladores.CSocios;
import com.google.gson.JsonArray;
import com.google.gson.JsonObject;
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
@WebServlet(name = "Cuotas", urlPatterns = {"/Cuotas"})
public class CuotasServlet extends HttpServlet {

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
            out.println("<title>Servlet CuotasServlet</title>");            
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet CuotasServlet at " + request.getContextPath() + "</h1>");
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
                case "cuotas":
                    List<Cuota> cuotas = CCuotas.getCuotas();
                    List<Cuota> cuotasVigentes = new ArrayList<>();
                    Conexion.getInstance().refresh(cuotas);
                    
                    List<Actividad> actividades = CActividades.getActividades();
                    List<Actividad> actividadesVigentes = new ArrayList<>();
                    
                    for (Actividad gi : actividades){
                        if(gi.isVigente())
                            actividadesVigentes.add(gi);
                    }
                    
                    JsonArray array = new JsonArray();
                    for (Cuota gi : cuotas)
                    {
                        if(gi.isVigente()){
                            cuotasVigentes.add(gi);
                            JsonObject obj = new JsonObject();
                            obj.addProperty("nombre", gi.getNombre());
                            if(gi.getActividad() != null)
                                obj.addProperty("actividad", gi.getActividad().getNombre());
//                            obj.addProperty("frecuencia", gi.getFrecuencia());
                            array.add(obj);
                        }
                    }
                    request.setAttribute("jsonCuo", array);
                    request.setAttribute("cuotas", cuotasVigentes);
                    request.setAttribute("actividades", actividadesVigentes);
                    request.getRequestDispatcher("vistas/cuotas.jsp").forward(request, response);
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
                case "altaCuota":
                    System.out.println("\nCREARRRRRRR CUOTAAAAAAAAAAAAAAAA \n");
                    String nombreCuota = request.getParameter("nombreForm");
                    String descripcion = request.getParameter("descripcionForm");
                    String fecha = request.getParameter("fechaForm");
                    String monto = request.getParameter("montoForm");
                    String frecuencia = request.getParameter("frecuenciaForm");
                    String actividad = request.getParameter("actividadForm");
                    System.out.println("\n" + fecha);
                    String[] splitt = fecha.split("-");
                    Date fechaDate = new Date(splitt[0] + "/" + splitt[1] + "/" + splitt[2]);
                    
                    Cuota nueva = new Cuota();
                    nueva.setNombre(nombreCuota);
                    nueva.setDescripcion(descripcion);
                    nueva.setFecha(fechaDate);
                    nueva.setMonto(Integer.parseInt(monto));
                    nueva.setFrecuencia(frecuencia);
                    if(!actividad.trim().equals("Ninguna")){
                        nueva.setActividad(CSocios.findActividad(actividad));
                    }
                    nueva.setVigente(true);
                    Conexion.getInstance().persist(nueva);
                    
                    response.setHeader("Refresh","0.1; URL=\"" + url + "?accion=cuotas\"");
                    break;
                case "modificarCuota":
                    System.out.println("\nACTUALIZAR CUOTAAAAAAAAAAAAAAAA \n");
                    String nombreCuotaNuevo = request.getParameter("nombreNuevo");
                    String nombreCuotaViejo = request.getParameter("nombreViejo");
                    String descripcionNueva = request.getParameter("descripcionNueva");
                    String fechaNueva = request.getParameter("fechaNueva");
                    String montoNuevo = request.getParameter("montoNuevo");
                    String frecuenciaNueva = request.getParameter("frecuenciaNueva");
                    String actividadNueva = request.getParameter("actividadNueva");
                    System.out.println("\n" + fechaNueva);
                    String[] split = fechaNueva.split("-");
                    Date fechaNuevaDate = new Date(split[0] + "/" + split[1] + "/" + split[2]);
                    
                    List<Cuota> allCuotas = CCuotas.getCuotas();
                    Cuota C = null;
                    for(Cuota c : allCuotas){
                        if(c.getNombre().equals(nombreCuotaViejo.trim()))
                            C = c;
                    }
                    C.setNombre(nombreCuotaNuevo);
                    C.setDescripcion(descripcionNueva);
                    C.setMonto(Integer.parseInt(montoNuevo));
                    C.setFrecuencia(frecuenciaNueva);
                    C.setFecha(fechaNuevaDate);
                    if(!actividadNueva.trim().equals("Ninguna")){
                        C.setActividad(CSocios.findActividad(actividadNueva));
                    }
                    
                    Conexion.getInstance().merge(C);
                    Conexion.getInstance().refresh(C);
                    
//                    request.getRequestDispatcher("vistas/cuotas.jsp").forward(request, response);
                    response.setHeader("Refresh","0.1; URL=\"" + url + "?accion=cuotas\"");
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
