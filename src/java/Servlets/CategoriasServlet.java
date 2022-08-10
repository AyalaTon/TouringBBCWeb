/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Servlets;

import BD.Conexion;
import Clases.Categoria;
import Controladores.CCategorias;
import com.google.gson.JsonArray;
import com.google.gson.JsonObject;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
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
@WebServlet(name = "Categorias", urlPatterns = {"/Categorias"})
public class CategoriasServlet extends HttpServlet {

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
            out.println("<title>Servlet CategoriasServlet</title>");            
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet CategoriasServlet at " + request.getContextPath() + "</h1>");
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
        response.setContentType("text/html;charset=UTF-8");
        request.setCharacterEncoding("UTF-8");
        String url = request.getRequestURL().toString();
        String accion = request.getParameter("accion");
        if (accion != null) {
            switch (accion) {
                case "categorias":
                    List<Categoria> categorias = CCategorias.getCategorias();
                    List<Categoria> categoriasVigentes = new ArrayList<>();
                    
                    JsonArray array = new JsonArray();
                    for (Categoria gi : categorias)
                    {
                        if(gi.isVigente()){
                            categoriasVigentes.add(gi);
                            JsonObject obj = new JsonObject();
                            obj.addProperty("nombre", gi.getNombre());
                            obj.addProperty("edad-min", gi.getEdadMin());
                            obj.addProperty("edad-max", gi.getEdadMax());
                            array.add(obj);
                        }
                    }
                    request.setAttribute("jsonCat", array);
                    request.setAttribute("categorias", categoriasVigentes);
                    request.getRequestDispatcher("vistas/altaCategoria.jsp").forward(request, response);
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
        response.setContentType("text/html;charset=UTF-8");
        request.setCharacterEncoding("UTF-8");
        String url = request.getRequestURL().toString();
        String accion = request.getParameter("accion");
        if (accion != null) {
            switch (accion) {
                case "modificarCategoria":
                    String categoriaSelect = request.getParameter("nombreViejo");
                    String nombreNuevo = request.getParameter("nombreNuevo");
                    int edadMin = Integer.parseInt(request.getParameter("edadMinForm"));
                    int edadMax = Integer.parseInt(request.getParameter("edadMaxForm"));
                    Categoria cat = CCategorias.findCategoria(categoriaSelect);
                    cat.setNombre(nombreNuevo);
                    cat.setEdadMin(edadMin);
                    cat.setEdadMax(edadMax);
                    Conexion.getInstance().merge(cat);
                    Conexion.getInstance().refresh(cat);
                    response.setHeader("Refresh","0.150; URL=\"" + url + "?accion=categorias\"");
                    break;
                    case "altaCategoria":
                        String nombre = request.getParameter("nombre");
                        int edadMin2 = Integer.parseInt(request.getParameter("edadMin"));
                        int edadMax2 = Integer.parseInt(request.getParameter("edadMax"));
                        Categoria newCat = new Categoria();
                        newCat.setNombre(nombre);
                        newCat.setEdadMin(edadMin2);
                        newCat.setEdadMax(edadMax2);
                        newCat.setVigente(true);
                        Conexion.getInstance().persist(newCat);
                        Conexion.getInstance().refresh(newCat);
                        
                        response.setHeader("Refresh","0.150; URL=\"" + url + "?accion=categorias\"");
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
