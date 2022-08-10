/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Servlets;

import BD.Conexion;
import Clases.Actividad;
import Clases.Categoria;
import Clases.Cuota;
import Clases.Familia;
import Clases.Horario;
import Clases.Jugador;
import Clases.PagoBBC;
import Clases.Socio;
import Clases.SocioActividad;
import Clases.TipoSocio;
import Controladores.CActividades;
import Controladores.CCategorias;
import Controladores.CCuotas;
import Controladores.CSocios;
import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.Date;
import com.google.gson.JsonArray;
import com.google.gson.JsonObject;
import com.google.gson.JsonParser;
import static java.lang.Integer.parseInt;
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
@WebServlet(name = "Socios", urlPatterns = {"/Socios"})
public class SociosServlet extends HttpServlet {

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
        request.setCharacterEncoding("UTF-8");
        String accion = request.getParameter("accion");
                if (accion != null) {
                    
                } else {
                    request.getRequestDispatcher("vistas/inicio.jsp").forward(request, response);
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
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
//        processRequest(request, response);
        response.setContentType("text/html;charset=UTF-8");
        request.setCharacterEncoding("UTF-8");
        String accion = request.getParameter("accion");
        String message = request.getParameter("message");
        request.setAttribute("message", message);
        if (accion != null) {
            switch (accion) {
                case "altaSocio":
                    List<TipoSocio> tiposS = CSocios.obtenerTiposSocios();
                    List<Cuota> allCuotas = CSocios.getCuotas();
                    List<Cuota> allCuotasVigentes = new ArrayList<>();
                    for(Cuota c: allCuotas){
                        if(c.isVigente()){
                            allCuotasVigentes.add(c);
                        }
                    }
                    List<Socio> allSocios = CSocios.obtenerSocios();
                    JsonArray allCedulasJson = new JsonArray();
                    for (Socio s : allSocios){
                        JsonObject obj = new JsonObject();
                        obj.addProperty("numero", s.getCi());
                        obj.addProperty("vigente", s.isVigente());
                        allCedulasJson.add(obj);
                    }
                    
                    List<Categoria> categorias = CSocios.getCategorias();
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
                    request.setAttribute("cedulasJson", allCedulasJson);
                    request.setAttribute("cuotas", allCuotasVigentes);
                    request.setAttribute("tipoSocios", tiposS);
                    request.getRequestDispatcher("vistas/altaSocio.jsp").forward(request, response);
                    break;
                case "tipoSocios":
                    List<TipoSocio> tipos = CSocios.obtenerTiposSocios();
                    for (TipoSocio t : tipos) {
                        System.out.println(t.getNombre());
                    }
                    request.setAttribute("tipos", tipos);
                    request.getRequestDispatcher("vistas/sociostipo.jsp").forward(request, response);
                    break;
                case "socios":
                    // Ver si es que se queiren ver todos los socios o solo los vigentes (Dejo en solo vigente)
                    List<Socio> sociosTodos = CSocios.obtenerSocios();
                    Conexion.getInstance().refresh(sociosTodos);
                    List<Socio> sociosVigentes = new ArrayList<>();
                    for(Socio k : sociosTodos){
                        if(k.isVigente())
                            sociosVigentes.add(k);
                    }
                    
                    List<TipoSocio> tiposSocio = CSocios.obtenerTiposSocios();
                    for (Socio s : sociosVigentes) {
                        System.out.println(s.getNombre() + " " + s.getFechaIngreso() + " " + s.getFechaNac());
                    }
                    request.setAttribute("socios", sociosVigentes);
                    request.setAttribute("tipoSocios", tiposSocio);
                    request.getRequestDispatcher("vistas/socios.jsp").forward(request, response);
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
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
//        processRequest(request, response);
        response.setContentType("text/html;charset=UTF-8");
        request.setCharacterEncoding("UTF-8");
        String url = request.getRequestURL().toString();
        if(request.getParameter("accion")!= null) {
            String accion = request.getParameter("accion");
            switch (accion) {
                case "nuevoTipoSocios":
                    String tipoSocio = request.getParameter("nombre");
                    List<TipoSocio> tipos = CSocios.obtenerTiposSocios();
                    boolean exist = false;
                    for (TipoSocio t : tipos) {
                        if(t.getNombre().equals(tipoSocio)){
                            exist = true;
                            System.out.println("EXISTE: " + t.getNombre());
                            break;
                        }
                        System.out.println(t.getNombre());
                    }
                    if(exist == false){
                        CSocios.guardarTipoSocio(tipoSocio);
                    }
                    request.setAttribute("tipos", tipos);
                    response.setHeader("Refresh","0.1; URL=\"" + url + "?accion=tipoSocios\"");
                    ;
                    break;
                case "eliminarTipoSocio":
                    String nombeTipoSocio = request.getParameter("nombreTipoSocio");
                    CSocios.eliminarTipoSocio(nombeTipoSocio);
                    response.setHeader("Refresh","0.1; URL=\"" + url + "?accion=tipoSocios\"");
                    break;
                case "modificarTipoSocio":
                    String nombeTipoSocioNuevo = request.getParameter("nombreNuevo");
                    String nombeTipoSocioViejo = request.getParameter("nombreViejo");
                    CSocios.modificarTipoSocio(nombeTipoSocioViejo, nombeTipoSocioNuevo);
                    
                    response.setHeader("Refresh","0.1; URL=\"" + url + "?accion=tipoSocios\"");
                    break;
                case "activarSocio":
                    String Activar = request.getParameter("cedulaAct");
                    Socio activarlo = CSocios.findSocio(Integer.parseInt(Activar));
                    activarlo.setVigente(true);
                    Conexion.getInstance().merge(activarlo);
                    
                    response.setHeader("Refresh","0.1; URL=\"" + url + "?accion=socios\"");
                    break;
                case "eliminarActividad":
                    String Socio = request.getParameter("cedulaSocio");
                    String SocioA = request.getParameter("idAct");
                    Socio S = CSocios.findSocio(Integer.parseInt(Socio));
                    SocioActividad SACT = CSocios.findSocioActividad(SocioA);
                    
                    S.getActividades().remove(SACT);
                    Conexion.getInstance().delete(SACT);
                    Conexion.getInstance().merge(S);
                    response.setHeader("Refresh","0.1; URL=\"" + url + "?accion=socios\"");
                    break;
                case "eliminarSocio":
                    System.out.println("\nELIMINAR SOCIOOOOOOOOOOOOO \n");
                    String cedulaAEliminar = request.getParameter("cedula");
                    Socio socioEliminar = CSocios.findSocio(Integer.parseInt(cedulaAEliminar));
                    socioEliminar.setVigente(false);
                    
                    Conexion.getInstance().merge(socioEliminar);
                    response.setHeader("Refresh","0.1; URL=\"" + url + "?accion=socios\"");
                    break;
                case "pasarAJugador":
                    int JuCarnetIndex = Integer.parseInt(request.getParameter("carnetIndexFormJugador")); // 0 = salud, 1 = adolescente. 2 = niño
                    String JuCategoria = request.getParameter("categoriaFormJugador");
                    String JuVencimientoCarnet = request.getParameter("vencimientoCarnetFormJugador");
                    String JuVencimientoCi = request.getParameter("vencimientoCedulaFormJugador");
                    String JuInformacion = request.getParameter("informacionFormJugador");
                    String JuCI = request.getParameter("CIFormJugador");
                    
                    System.out.println("Jugador carnet Index :" + JuCarnetIndex);
                    System.out.println("Jugador Categoria :" + JuCategoria);
                    System.out.println("Juhador Vencimiento Carnet :" + JuVencimientoCarnet);
                    System.out.println("Jugador Vencimiento CI :" + JuVencimientoCi);
                    System.out.println("Jugador Informacion :" + JuInformacion);
                    System.out.println("Jugador CI :" + JuCI);
                    
                    Socio sAConvertir = CSocios.findSocio(Integer.parseInt(JuCI.trim()));
                    System.out.println("Jugador Nombre :" + sAConvertir.getNombre());
                    System.out.println("Jugador Apellido :" + sAConvertir.getApellido());
                    System.out.println("Jugador CI :" + sAConvertir.getCi());
                    System.out.println("Jugador Direccion :" + sAConvertir.getDireccion());
                    System.out.println("Jugador Fecha Nacimiento :" + sAConvertir.getFechaNac());
                    System.out.println("Jugador Telefono :" + sAConvertir.getTelefono());
                    System.out.println("Jugador Fecha Ingreso :" + sAConvertir.getFechaIngreso());
                    System.out.println("Jugador Tipo :" + sAConvertir.getTipo().getNombre());
                    System.out.println("Jugador Vigente :" + sAConvertir.isVigente());
                    
                    Familia famSoc = sAConvertir.getFamilia();
                    TipoSocio tipoSoc = sAConvertir.getTipo();
                    List<PagoBBC> pagg = sAConvertir.getPagos();
                    List<SocioActividad> soAct = sAConvertir.getActividades();
                    List<Cuota> cuoSo = sAConvertir.getCuotas();
                    
                    for(Cuota l : cuoSo){ // CON ESTO DEJO TODOS LAS CUOTAS SIN SOCIO
                        List<Socio> socios = l.getSocios();
                        for(int i = 0; i < socios.size(); i++){
                            if(socios.get(i).equals(sAConvertir)){
                                socios.remove(socios.get(i));
                            }
                        }
                        Conexion.getInstance().merge(l);
                    }
                    
                    for(SocioActividad k : soAct){ // CON ESTO DEJO TODOS LAS ACTIVIDADES SIN SOCIO (NULL)
                        k.setSocios(null);
                        Conexion.getInstance().merge(k);
                    }
                    for(PagoBBC g : pagg){ // CON ESTO DEJO TODOS LOS PAGOS SIN SOCIO (NULL)
                        g.setSocio(null);
                        Conexion.getInstance().merge(g);
                    }
                    Jugador juga = new Jugador();
                    juga.setNombre(sAConvertir.getNombre());
                    juga.setApellido(sAConvertir.getApellido());
                    juga.setCi(sAConvertir.getCi());
                    juga.setFamilia(sAConvertir.getFamilia());
                    juga.setDireccion(sAConvertir.getDireccion());
                    juga.setFechaNac(sAConvertir.getFechaNac());
                    juga.setTelefono(sAConvertir.getTelefono());
                    juga.setFechaIngreso(sAConvertir.getFechaIngreso());
                    juga.setTipo(sAConvertir.getTipo());
                    juga.setVigente(true);
                    juga.setRol(sAConvertir.getRol());

                    sAConvertir.setPagos(null); // NO SE SI HACE FALTA
                    sAConvertir.setFamilia(null); // CON ESTO YA DEJO AL SOCIO SIN FAMILIA
                    sAConvertir.setTipo(null); // CON ESTO YA DEJO AL SOCIO SIN TIPO
                    
                    Conexion.getInstance().merge(sAConvertir);
                    Conexion.getInstance().refresh(sAConvertir);
                    Conexion.getInstance().delete(sAConvertir);
                    
                    juga.setPlantel(CCategorias.findCategoria(JuCategoria.trim()));                  
                    String[] cortes = JuVencimientoCarnet.split("-");
                    Date JuVencimientoCarnetDate = new Date(cortes[0] + "/" + cortes[1] + "/" + cortes[2]);
                    juga.setCarnetHabilitante(JuVencimientoCarnetDate);
                    cortes = JuVencimientoCi.split("-");
                    Date JuVencimientoCiDate = new Date(cortes[0] + "/" + cortes[1] + "/" + cortes[2]);
                    juga.setVenCi(JuVencimientoCiDate);
                    juga.setTipoCarnet(JuCarnetIndex);
                    juga.setDetalles(JuInformacion);
                    
                    Conexion.getInstance().persist(juga);
                        
                    for(Cuota l : cuoSo){ // CON ESTO DEJO TODOS LAS CUOTAS SIN SOCIO
                        List<Socio> socios = l.getSocios();
                        socios.add(juga);
                        Conexion.getInstance().merge(l);
                    }
                    
                    for(SocioActividad k : soAct){ // CON ESTO DEJO TODOS LAS ACTIVIDADES SIN SOCIO (NULL)
                        k.setSocios(juga);
                        Conexion.getInstance().merge(k);
                    }
                    for(PagoBBC g : pagg){ // CON ESTO DEJO TODOS LOS PAGOS SIN SOCIO (NULL)
                        g.setSocio(juga);
                        Conexion.getInstance().merge(g);
                    }    
                   
                    response.setHeader("Refresh","0.1; URL=\"" + url + "?accion=socios\"");
                    break;
                case "nuevoPago":
                    int montoPago = Integer.parseInt(request.getParameter("monto"));
                    String CedulaSocio = request.getParameter("Yo");
                    Socio Yo = CSocios.findSocio(Integer.parseInt(CedulaSocio));
                    
                    PagoBBC pag = new PagoBBC();
                    pag.setSocio(Yo);
                    pag.setFecha(new Date());
                    pag.setMonto(montoPago);
                    Conexion.getInstance().persist(pag);
                    Conexion.getInstance().merge(Yo);
                    
                    response.setHeader("Refresh","0.1; URL=\"" + url + "?accion=socios\"");
                    break;
                case "agregarCuota":
                    String socioCedula = request.getParameter("socio");
                    String cuotaAAgregar = request.getParameter("cuotaAAgregar");
                    
                    Cuota cuota2 = CCuotas.findCuota(cuotaAAgregar);
                    Socio socio2 = CSocios.findSocio(Integer.parseInt(socioCedula));
                    
                    if(cuota2.getSocios()!=null){ // Ya tiene socios esa cuota
                        List<Socio> sociosDeCuota = cuota2.getSocios();
                        sociosDeCuota.add(socio2);
                        cuota2.setSocios(sociosDeCuota);
                    } else { // la cuota no tiene socios aun
                        List<Socio> auxxx = new ArrayList<>();
                        auxxx.add(socio2);
                        cuota2.setSocios(auxxx);
                    }
                    
                    if(socio2.getCuotas() != null){ // tiene alguna cuota ya
                        List<Cuota> cuotasDeSocio = socio2.getCuotas();
                        cuotasDeSocio.add(cuota2);
                        socio2.setCuotas(cuotasDeSocio);
                    } else { 
                        List<Cuota> auxiliar = new ArrayList<>();
                        auxiliar.add(cuota2);
                        socio2.setCuotas(auxiliar);
                    }
                    
                    Conexion.getInstance().merge(cuota2);
                    Conexion.getInstance().merge(socio2);
                    Conexion.getInstance().refresh(socio2);
                    Conexion.getInstance().refresh(cuota2);
                    response.setHeader("Refresh","0.1; URL=\"" + url + "?accion=socios\"");
                    break;
                case "actualizarSocio":
                    System.out.println("\nACTUALIZAR SOCIOOOOOOOOOOOOO \n");
                    String nombreSocio = request.getParameter("nombre");
                    String apellidoSocio = request.getParameter("apellido");
                    String direccionSocio = request.getParameter("direccion");
                    String telefonoSocio = request.getParameter("telefono");
                    String cedulaSocio = request.getParameter("cedula");
                    String fechaIngresoSocio = request.getParameter("fechaIngreso");
                    String fechaNacimientoSocio = request.getParameter("fechaNacimiento");
                    String TipoSocio = request.getParameter("tipo");
                    
                    if(request.getParameter("categoriaJugador") != null && request.getParameter("categoriaJugador") != ""){
                        String catJugador = request.getParameter("categoriaJugador");
                        System.out.println("Categoria del player es: " + catJugador.trim());
                        Jugador jug = null;
                        jug = CSocios.findJugador(Integer.parseInt(cedulaSocio));
                        if(jug != null) {
                            jug.setPlantel(CSocios.findCategoria(catJugador.trim()));
                            Conexion.getInstance().merge(jug);
                        }
                    }
                    
                    System.out.println(nombreSocio);
                    System.out.println(apellidoSocio);
                    System.out.println(direccionSocio);
                    System.out.println(telefonoSocio);
                    System.out.println(cedulaSocio);
                    System.out.println(fechaIngresoSocio);
                    System.out.println(fechaNacimientoSocio);
                    System.out.println(TipoSocio);
                    String[] split = fechaIngresoSocio.split("-");
                    Date fechaIngresoSocioDate = new Date(split[0] + "/" + split[1] + "/" + split[2]);
                    split = fechaNacimientoSocio.split("-");
                    Date fechaNscimientoSocioDate = new Date(split[0] + "/" + split[1] + "/" + split[2]);
                    CSocios.actualizarSocio(cedulaSocio, nombreSocio, apellidoSocio, direccionSocio, telefonoSocio, fechaIngresoSocioDate, fechaNscimientoSocioDate, TipoSocio);
                    response.setHeader("Refresh","0.1; URL=\"" + url + "?accion=socios\"");
                    break;
                case "altaSocio":
                    String Snombre = request.getParameter("nombre");
                    String Sapellido = request.getParameter("apellido");
                    String Sdireccion = request.getParameter("direccion");
                    String Stelefono = request.getParameter("telefono");
                    String Scedula = request.getParameter("cedula");
                    String SfechaIngreso = request.getParameter("fechaIngreso");
                    String SfechaNacimiento = request.getParameter("fechaNacimiento");
                    String Stipo = request.getParameter("tipo");
                    
                    System.out.println("Nombre: " + Snombre);
                    System.out.println("Apellido: " + Sapellido);
                    System.out.println("Direccion: " + Sdireccion);
                    System.out.println("Telefono: " + Stelefono);
                    System.out.println("Cedula: " + Scedula);
                    System.out.println("Fecha ingreso: " + SfechaIngreso);
                    System.out.println("Fecha nacimiento: " + SfechaNacimiento);
                    System.out.println("Tipo: " + Stipo);
                    String[] split22 = SfechaIngreso.split("-");
                    Date SfechaIngresoDate = new Date(split22[0] + "/" + split22[1] + "/" + split22[2]);
                    String[] split222 = SfechaNacimiento.split("-");
                    Date SfechaNacimientoDate = new Date(split222[0] + "/" + split222[1] + "/" + split222[2]);
                    
                    String esJugador = request.getParameter("crearJugador");
                    System.out.println("JUGADOOOORRRRRRR" + esJugador);
                    if(esJugador.equals("si")){ // Es un Jugador
                        int ScarnetIndex = Integer.parseInt(request.getParameter("carnetForm")); // 0 = salud, 1 = adolescente. 2 = niño
                        String Scategoria = request.getParameter("categoriaForm");
                        String ScancimientoCarnet = request.getParameter("vencimientoCarnetForm");
                        String SvencimientoCi = request.getParameter("vencimientoCiForm");
                        String[] splitttt = SvencimientoCi.split("-");
                        Date SvenceCI = new Date(splitttt[0] + "/" + splitttt[1] + "/" + splitttt[2]);
                        splitttt = ScancimientoCarnet.split("-");
                        Date SvenceCarnet = new Date(splitttt[0] + "/" + splitttt[1] + "/" + splitttt[2]);
                        
                        System.out.println("Es un jugador lo que estoy queriendo crearrrrrr");
                        Jugador SS = new Jugador();
                        SS.setNombre(Snombre.trim());
                        SS.setApellido(Sapellido.trim());
                        SS.setCi(parseInt(Scedula));
                        SS.setDireccion(Sdireccion);
                        SS.setFechaNac(SfechaNacimientoDate);
                        SS.setTelefono(Stelefono);
                        SS.setFechaIngreso(SfechaIngresoDate);
                        SS.setTipo(CSocios.findTipoSocio(Stipo));
                        SS.setVigente(true);
                        
                        SS.setCarnetHabilitante(SvenceCarnet);
                        SS.setPlantel(CSocios.findCategoria(Scategoria.trim()));
                        SS.setVenCi(SvenceCI);
                        SS.setTipoCarnet(ScarnetIndex);
                        SS.setDetalles("");
                        
                        String Scuota = request.getParameter("cuota");
                        if(Scuota.trim().equals("Ninguna")){
                            Familia fa =  new Familia();
                            Conexion.getInstance().persist(fa);
                            SS.setFamilia(fa);
                            SS.setRol(true);
                        } else {
                            Familia fa =  new Familia();
                            Conexion.getInstance().persist(fa);
                            SS.setFamilia(fa);
                            SS.setRol(true);
                            
                            Cuota ScuotaObj = null;
                            List<Cuota> cuotas = CSocios.getCuotas();
                            for(Cuota cu : cuotas){
                                if(cu.getNombre().equals(Scuota.trim()))
                                    ScuotaObj = cu;
                            }
                            //Tengo la Cuota
                            if(ScuotaObj.getSocios() == null){
                                ScuotaObj.setSocios(new ArrayList<Socio>());
                            }
                            ScuotaObj.getSocios().add(SS);
                            Conexion.getInstance().merge(ScuotaObj);
                        }
                        Conexion.getInstance().persist(SS);
                    } else { // Socio normal
                        System.out.println("Es un Socio comun lo que estoy queriendo crearrrrrr");
                        Socio SS = new Socio();
                        SS.setNombre(Snombre.trim());
                        SS.setApellido(Sapellido.trim());
                        SS.setCi(parseInt(Scedula));
                        SS.setDireccion(Sdireccion);
                        SS.setFechaNac(SfechaNacimientoDate);
                        SS.setTelefono(Stelefono);
                        SS.setFechaIngreso(SfechaIngresoDate);
                        SS.setTipo(CSocios.findTipoSocio(Stipo));
                        SS.setVigente(true);
                        
                        String Scuota = request.getParameter("cuota");
                        if(Scuota.trim().equals("Ninguna")){
                            Familia fa =  new Familia();
                            Conexion.getInstance().persist(fa);
                            SS.setFamilia(fa);
                            SS.setRol(true);
                        } else {
                            Familia fa =  new Familia();
                            Conexion.getInstance().persist(fa);
                            SS.setFamilia(fa);
                            SS.setRol(true);
                            
                            Cuota ScuotaObj = null;
                            List<Cuota> cuotas = CSocios.getCuotas();
                            for(Cuota cu : cuotas){
                                if(cu.getNombre().equals(Scuota.trim()))
                                    ScuotaObj = cu;
                            }
                            //Tengo la Cuota
                            if(ScuotaObj.getSocios() == null){
                                ScuotaObj.setSocios(new ArrayList<Socio>());
                            }
                            ScuotaObj.getSocios().add(SS);
                            Conexion.getInstance().merge(ScuotaObj);
                        }
                        Conexion.getInstance().persist(SS);
                    }
                    response.setHeader("Refresh","0.1; URL=\"" + url + "?accion=socios\"");
                    break;
                case "altaFamilia":
                    String arrayFamilia = request.getParameter("familia[]");
                    int principalFamilia = Integer.parseInt(request.getParameter("indexPrincipal"));
                    String Scuota = request.getParameter("cuotaFamilia");
                    System.out.println("\nCuota para la Flia: " + Scuota);
                    System.out.println("\nArray original: " + arrayFamilia);
                    //No pude convertir la cadena que me llega a JsonArray por lo que hago es cortar el array en los objetos y esos si convertirlos en JsonObject
                    String[] objetos = arrayFamilia.split("\\},\\{");
                    List<JsonObject> ArraySocios = new ArrayList<>();
                    System.out.println("\n El principal es el #" + principalFamilia);
                    //Creo la Familia
                    Familia fa =  new Familia();
                    Conexion.getInstance().persist(fa);
                    
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
                        ArraySocios.add(jsonObject);
                        
                        String[] split2222 = jsonObject.get("ingreso").toString().replaceAll("\"", "").trim().split("-");
                        System.out.println("\n Ingreso:" + jsonObject.get("ingreso").toString().trim());
                        Date SofechaIngresoDate = new Date(split2222[0] + "/" + split2222[1] + "/" + split2222[2]);
                        split2222 = jsonObject.get("nacimiento").toString().replaceAll("\"", "").trim().split("-");
                        Date SofechaNacimientoDate = new Date(split2222[0] + "/" + split2222[1] + "/" + split2222[2]);
                        
                        if(jsonObject.get("jugador") != null){ // Socio jugador 
                            System.out.println("Es un jugador lo que estoy queriendo crearrrrrr");
                            
                            String jugador = jsonObject.get("jugador").toString();
                            jugador = jugador.substring(1, jugador.length()-1);
                            jugador = jugador.replaceAll("\\\\", "");
                            JsonObject jsonObjectJugador = new JsonParser().parse(jugador).getAsJsonObject(); 
                            
                            Jugador SS = new Jugador();
                            SS.setNombre(jsonObject.get("nombre").toString().replaceAll("\"", "").trim());
                            SS.setApellido(jsonObject.get("apellido").toString().replaceAll("\"", "").trim());
                            SS.setCi(Integer.parseInt(jsonObject.get("cedula").toString().replaceAll("\"", "").trim()));
                            SS.setDireccion(jsonObject.get("direccion").toString().replaceAll("\"", "").trim());
                            SS.setFechaNac(SofechaNacimientoDate);
                            SS.setTelefono(jsonObject.get("telefono").toString().replaceAll("\"", "").trim());
                            SS.setFechaIngreso(SofechaIngresoDate);
                            SS.setTipo(CSocios.findTipoSocio(jsonObject.get("tipo").toString().replaceAll("\"", "").trim()));
                            SS.setVigente(true);
                            
                            split2222 = jsonObjectJugador.get("vencimientoCarnet").toString().replaceAll("\"", "").trim().split("-");
                            Date SoVenceCarnetDate = new Date(split2222[0] + "/" + split2222[1] + "/" + split2222[2]);
                            split2222 = jsonObjectJugador.get("vencimientoCedula").toString().replaceAll("\"", "").trim().split("-");
                            Date SoVenceCiDate = new Date(split2222[0] + "/" + split2222[1] + "/" + split2222[2]);
                        
                            SS.setCarnetHabilitante(SoVenceCarnetDate);
                            SS.setVenCi(SoVenceCiDate);
                            SS.setPlantel(CSocios.findCategoria(jsonObjectJugador.get("categoria").toString().replaceAll("\"", "").trim()));
                            SS.setTipoCarnet(Integer.parseInt(jsonObjectJugador.get("carnet").toString().replaceAll("\"", "").trim()));
                            SS.setDetalles("");
                        
                            if(i+1 == principalFamilia){ // Si es el principal seleccionado se settea como true
                                SS.setRol(true);
                            } else {
                                SS.setRol(false);
                            }
                            
                            SS.setFamilia(fa);
                            
                            if(!Scuota.trim().equals("Ninguna")){ // Si se selecciono una cuota
                                Cuota ScuotaObj = null;
                                List<Cuota> cuotas = CSocios.getCuotas();
                                for(Cuota cu : cuotas){
                                    if(cu.getNombre().equals(Scuota.trim()))
                                        ScuotaObj = cu;
                                }
                                //Tengo la Cuota
                                if(ScuotaObj.getSocios() == null){
                                    ScuotaObj.setSocios(new ArrayList<Socio>());
                                }
                                ScuotaObj.getSocios().add(SS);
                                Conexion.getInstance().merge(ScuotaObj);
                                // Socio de tipo Jugador ya guardado
                            }
                            Conexion.getInstance().persist(SS);
                        } else { //Socio comun
                            System.out.println("Es un Socio comun lo que estoy queriendo crearrrrrr");
                            
                            Socio SS = new Socio();
                            SS.setNombre(jsonObject.get("nombre").toString().replaceAll("\"", "").trim());
                            SS.setApellido(jsonObject.get("apellido").toString().replaceAll("\"", "").trim());
                            SS.setCi(Integer.parseInt(jsonObject.get("cedula").toString().replaceAll("\"", "").trim()));
                            SS.setDireccion(jsonObject.get("direccion").toString().replaceAll("\"", "").trim());
                            SS.setFechaNac(SofechaNacimientoDate);
                            SS.setTelefono(jsonObject.get("telefono").toString().replaceAll("\"", "").trim());
                            SS.setFechaIngreso(SofechaIngresoDate);
                            SS.setTipo(CSocios.findTipoSocio(jsonObject.get("tipo").toString().replaceAll("\"", "").trim()));
                            SS.setVigente(true);
                            
                            if(i+1 == principalFamilia){ // Si es el principal seleccionado se settea como true
                                SS.setRol(true);
                            } else {
                                SS.setRol(false);
                            }
                            
                            SS.setFamilia(fa);
                            
                            if(!Scuota.trim().equals("Ninguna")){ // Si se selecciono una cuota
                                Cuota ScuotaObj = null;
                                List<Cuota> cuotas = CSocios.getCuotas();
                                for(Cuota cu : cuotas){
                                    if(cu.getNombre().equals(Scuota.trim()))
                                        ScuotaObj = cu;
                                }
                                //Tengo la Cuota
                                if(ScuotaObj.getSocios() == null){
                                    ScuotaObj.setSocios(new ArrayList<Socio>());
                                }
                                ScuotaObj.getSocios().add(SS);
                                Conexion.getInstance().merge(ScuotaObj);
                                // Socio comun ya guardado
                            }
                            Conexion.getInstance().persist(SS);
                        }
                        
                    }
                    
                    for(JsonObject pe : ArraySocios){
                        System.out.println("\nAAAAAAAAAAAAAAAAAA: " + pe.get("nombre"));
                    }
                    
                    response.setHeader("Refresh","0.1; URL=\"" + url + "?accion=socios\"");
                    break;
                case "detallesSocio":
                    int cantActividades = 0;
                    if(CActividades.getActividades() != null)
                        cantActividades = CActividades.getActividades().size();
                    
                    int CI = Integer.parseInt(request.getParameter("CISocio"));
                    Socio s = CSocios.findSocio(CI);
                    System.out.println("Nombre: " + s.getNombre());
                    System.out.println("Apellido: " + s.getApellido());
                    System.out.println("Direccion: " + s.getDireccion());
                    System.out.println("Telefono: " + s.getTelefono());
                    System.out.println("Cedula: " + s.getCi());
                    System.out.println("Fecha ingreso: " + s.getFechaIngreso());
                    System.out.println("Fecha nacimiento: " + s.getFechaNac());
                    System.out.println("Tipo: " + s.getTipo());
                    
                    List<Cuota> cuotasV = new ArrayList<>();
                    if(s.getCuotas().size() > 0){
                        for(Cuota pepe : s.getCuotas()){
                            System.out.println("\nEntra: " + pepe.getNombre());
                            if(pepe.isVigente()){
                                cuotasV.add(pepe);
                            }
                        }
                    }
                    if(s.getActividades().size() > 0){
                        List<SocioActividad> sact = s.getActividades();
                        for(SocioActividad g : sact){
                            Cuota ge = g.getCuota();
                            if(ge.isVigente())
                                cuotasV.add(ge);
                        }
                    }
                    
                    List<Cuota> cuotasTodas = CSocios.getCuotas();
                    List<Cuota> cuotasRestantes = new ArrayList<>();
                    for(Cuota a : cuotasTodas){
                        boolean pertenece = false;
                        for(Cuota x : cuotasV){
                            if(x.equals(a)){
                                pertenece = true;
                            }
                        }
                        if(!pertenece)
                            cuotasRestantes.add(a);
                    }
                    
                    List<PagoBBC> pagos = new ArrayList<>();
                    if(s.getPagos() != null){
                        pagos = s.getPagos();
                    }
                    
                    List<Categoria> categorias = CSocios.getCategorias();
                    List<TipoSocio> tipoSocios = CSocios.obtenerTiposSocios();
                    Jugador j = null;
                    j = CSocios.findJugador(CI);
                    //AGREGAR LA FAMILIA
                    Conexion.getInstance().refresh(s.getFamilia());
                    List<Socio> familiares = s.getFamilia().getSocios();
                    List<Socio> familia = new ArrayList<>();
                    for(Socio f : familiares){
                        if(f.isVigente())
                            familia.add(f);
                    }
                    
                    List<Socio> sociosTotales = CSocios.obtenerSocios();
                    List<Socio> sociosVigentes = new ArrayList<>();
                    for(Socio so : sociosTotales){
                        if(so.isVigente())
                            sociosVigentes.add(so);
                    }
                    
                    JsonArray array = new JsonArray();
                    for (Categoria gi : categorias)
                    {
                        if(gi.isVigente()){ // VER si este filtro es necesario 
                            JsonObject obj = new JsonObject();
                            obj.addProperty("nombre", gi.getNombre());
                            obj.addProperty("edad-min", gi.getEdadMin());
                            obj.addProperty("edad-max", gi.getEdadMax());
                            array.add(obj);
                        }
                    }
                    System.out.println("El jugador es: " + j);
                    request.setAttribute("cantActividades", cantActividades);
                    request.setAttribute("jsonCat", array);
                    request.setAttribute("jugador", j);
                    request.setAttribute("pagos", pagos);
                    request.setAttribute("cuotasRestantes", cuotasRestantes);
                    request.setAttribute("cuotas", cuotasV);
                    request.setAttribute("socio", s);
                    request.setAttribute("tipoSocios", tipoSocios);
                    request.setAttribute("sociosVigentes", sociosVigentes);
                    request.setAttribute("categorias", categorias);
                    request.setAttribute("familia", familia);
                    request.getRequestDispatcher("vistas/detallesSocio.jsp").forward(request, response);
                    break;
                case "actualizarJugador":
                    SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd");
                    int Cedula = Integer.parseInt(request.getParameter("CIJugador"));
                    Jugador ju = CSocios.findJugador(Cedula);
                    String vencimientoCedula = request.getParameter("vencimientoCedula");
                    String fechaNacimientoNueva = request.getParameter("fechaNacimientoNueva");
                    String[] split2 = vencimientoCedula.split("-");
                    Date venceCI = new Date(split2[0] + "/" + split2[1] + "/" + split2[2]);
                    String vencimientoCarnet = request.getParameter("vencimientoCarnet");
                    split2 = vencimientoCarnet.split("-");
                    Date venceCarnet = new Date(split2[0] + "/" + split2[1] + "/" + split2[2]);
                    split2 = fechaNacimientoNueva.split("-");
                    Date fechaNacimientoNuevaDate = new Date(split2[0] + "/" + split2[1] + "/" + split2[2]);
                    int carnet = Integer.parseInt(request.getParameter("carnetIndex"));
                    String categoria = request.getParameter("categoriasCombo");
                    String informacion = request.getParameter("informacion");
                    
                    ju.setVenCi(venceCI);
                    ju.setCarnetHabilitante(venceCarnet);
                    ju.setPlantel(CSocios.findCategoria(categoria));
                    ju.setFechaNac(fechaNacimientoNuevaDate);
                    ju.setTipoCarnet(carnet);
                    ju.setDetalles(informacion);
                    Conexion.getInstance().merge(ju);
                    
                    response.setHeader("Refresh","0.1; URL=\"" + url + "?accion=socios\"");
                    break;
                case "agregarFamiliar":
                    Socio socioActual = CSocios.findSocio(Integer.parseInt(request.getParameter("socio")));
                    Socio socioAAgregar = CSocios.findSocio(Integer.parseInt(request.getParameter("socioAAgregar")));
                    
                    if(socioAAgregar.getFamilia().getSocios().size()>1){ // DEMASAIADAS DUDAS SOBRE ESTE IF PREGUNTARLE A ALGUIEN DESPUES NO SE SI ANDA BIEN ESTO
                                                                         // CREO QUE SI AGREGAR UN PRINCIPAL DE UNA FAMILIA A OTRA PASAN COSAS (PREGUNTAR ESO)
                        if(socioAAgregar.getRol()){ // SI NO ME EQUIVOCO ESTE IF ES TODO AL REVEZ (Lo DEJO COMO YO CREO QUE ES)
                            if(socioAAgregar.getFamilia().getSocios().get(0) == socioAAgregar) // Si el socio 0 de su porpia familia es el mismo
                                socioAAgregar.getFamilia().getSocios().get(1).setRol(true); // le doy rol true
                            else
                                socioAAgregar.getFamilia().getSocios().get(0).setRol(true); // de lo contrario le doy el rol a otro socio
                        }
                        socioAAgregar.setFamilia(socioActual.getFamilia());
                        socioAAgregar.setRol(false);
                        Conexion.getInstance().merge(socioAAgregar);

                    } else {
                        Familia fami = socioAAgregar.getFamilia();
                        socioAAgregar.setFamilia(socioActual.getFamilia());
                        socioAAgregar.setRol(false);
                        Conexion.getInstance().merge(socioAAgregar);
                        Conexion.getInstance().delete(fami);
                    }
                    response.setHeader("Refresh","0.1; URL=\"" + url + "?accion=socios\"");
                    break;
                case "asociarActividad":
                    if(request.getParameter("modificarAsociacionConfirmacion") != null){
                        String IDSA = request.getParameter("modificarAsociacionConfirmacion"); // ID de la SocioActividad modificada
                        
                        System.out.println("IDSA: " + IDSA);
                        SocioActividad sa = CSocios.findSocioActividad(IDSA);
                        Socio socio = CSocios.findSocio(Integer.parseInt(request.getParameter("socioForm")));
                        String actividad = request.getParameter("actividadForm");
                        String cuota = request.getParameter("cuotaForm");
                        String horariosSeleccionados = request.getParameter("arrayHorarios[]");
                        System.out.println(horariosSeleccionados);
                        Cuota cuot = null;
                        Actividad actt = CSocios.findActividad(actividad);
                        System.out.println(actt.getCuotas().size());
                        for(Cuota a : actt.getCuotas()){
                            if(a.getNombre().equals(cuota.trim())){
                                cuot = a;
                            }
                        }
                        
                        sa.setCuota(cuot); // Cuota seleccionada ya setteada
                        List<String> horariosActividad = new ArrayList<>();
                        for(Horario p : actt.getHorarios()){
                            horariosActividad.add(p.getDia() + "," + p.getHora() + "," + p.getDuracion());
                            System.out.println(p.getDia() + "," + p.getHora() + "," + p.getDuracion());
                        }

                        String[] arrOfStr = horariosSeleccionados.split("true");
                        List<String> dias = new ArrayList<>();
                        List<String> horas = new ArrayList<>();
                        for (String a : arrOfStr){ // CORTO EL STRING EN TRUE PARA QUEDARME CON LOS DIAS Y HORAS (DEBERIA LLEGARME AL MENOS UN HORAIRO )
                            char firstChar = a.charAt(0);
                            if(firstChar == ','){
                                a = a.replaceFirst(",", "");
                            }
                            String[] arrOfStr2 = a.split(",");
                            dias.add(arrOfStr2[0]);
                            horas.add(arrOfStr2[1]);
                            System.out.println("DIA: " + arrOfStr2[0]);
                            System.out.println("HORA: " + arrOfStr2[1]);
                        }
                        
                        List<Horario> horarios = new ArrayList<>();
                        int index = 0;
                        for(Horario h : actt.getHorarios()){ // recorro los horarios de esa actividad y me quedo con los que selecciono el user y armo una lista para setearle a la SocioActividad que estoy modificando
                            index = 0;
                            for(String dia : dias){
                                if(dia.equals(h.getDia())){
                                    if(h.getHora() == Integer.parseInt(horas.get(index))){
                                        horarios.add(h);
                                    }
                                }
                                index += 1;
                            }
                        }
                        
                        sa.setHorarios(horarios); // nuevos horarios seleccionados ya settteados
                        Conexion.getInstance().merge(sa);
                        Conexion.getInstance().refresh(sa);
                        
                        System.out.println(cuot.getNombre());
                        
                        response.setHeader("Refresh","0.1; URL=\"" + url + "?accion=socios\"");
                        break;
                    } else if(request.getParameter("modificarAsociacion") != null){ // AQUI ES CUANDO LLEGA DESDE DETALLES DEL SOCIO Y SE QUIERE MODIFICAR UNA ASOCIACION
                        String socioActividadSeleccionada = request.getParameter("idSocioAct");
                        SocioActividad sa = CSocios.findSocioActividad(socioActividadSeleccionada);
                        Socio socio = CSocios.findSocio(Integer.parseInt(request.getParameter("socio")));
                        String actividad = request.getParameter("actividadAsociada");
                        System.out.println("Horarios de la SocioActividad");
                        System.out.println("Horarios de la actividad");
                        Actividad act = CSocios.findActividad(actividad);
                        List<String> horariosActividad = new ArrayList<>();
                        for(Horario p : act.getHorarios()){
                            horariosActividad.add(p.getDia() + "," + p.getHora() + "," + p.getDuracion());
                            System.out.println(p.getDia() + "," + p.getHora() + "," + p.getDuracion());
                        }
                        
                        Actividad a = CSocios.findActividad(actividad);
                        List<Cuota> cuotas = a.getCuotas();
                        List<String> listaSeleccionados = new ArrayList<>();
                        for(Horario p : sa.getHorarios()){
                            listaSeleccionados.add(p.getDia() + "," + p.getHora() + "," + p.getDuracion());
                            System.out.println(p.getDia() + "," + p.getHora() + "," + p.getDuracion());
                        }
                        request.setAttribute("horariosActiv", horariosActividad);
                        request.setAttribute("horariosSelect", listaSeleccionados);
                        request.setAttribute("IDSA", socioActividadSeleccionada);
                        request.setAttribute("actividad", actividad);
                        request.setAttribute("socio", socio);
                        request.setAttribute("cuotas", cuotas);
                        request.getRequestDispatcher("vistas/modificarAsociacion.jsp").forward(request, response);
                    } else if(request.getParameter("actividadForm") != null){ // SOLO PARA COMPROBAR QUE VIENE DE LA PAGINA DE ASOCIAR LA NUEVA ACTIVIDAD DEL SOCIO
                        String actividadSeleccionada = request.getParameter("actividadForm");
                        String cuotaSeleccionada = request.getParameter("cuotaForm");
                        String cedulaSeleccionada = request.getParameter("CISocio");
                        String horariosSeleccionados = request.getParameter("arrayHorarios[]");
                        SocioActividad sa = new  SocioActividad();
                        Actividad act = CSocios.findActividad(actividadSeleccionada.trim());
                        sa.setActividades(act); // SOLO RECIBE UNA ACTIVIDAD
                        Socio socioo = CSocios.findSocio(Integer.parseInt(cedulaSeleccionada));
                        sa.setSocios(socioo); // LA SOCIOACTIVIDAD NUEVA YA TIENE UN SOCIO SETTEADO Y UNA ACTIVIDAD EN ESTE PUNTO
                        Cuota cuot = null;
                        for(Cuota c : act.getCuotas()){
                            System.out.println("CUOTA de la Actividad: " + c.getNombre());
                            
                            if(c.getNombre().equals(cuotaSeleccionada.trim())){
                                System.out.println("CUOTA ENCONTRADA");
                                cuot = c;
                                break;
                            }
                        }
                        sa.setCuota(cuot); // LE SETTEO LA CUOTA A LA ACTIVIDAD
                        String[] arrOfStr = horariosSeleccionados.split("true");
                        List<String> dias = new ArrayList<>();
                        List<String> horas = new ArrayList<>();
                        for (String a : arrOfStr){ // CORTO EL STRING EN TRUE PARA QUEDARME CON LOS DIAS Y HORAS (DEBERIA LLEGARME AL MENOS UN HORAIRO )
                            System.out.println("TOKEN: " + a);
                            char firstChar = a.charAt(0);
                            if(firstChar == ','){
                                a = a.replaceFirst(",", "");
                            }
                            String[] arrOfStr2 = a.split(",");
                            dias.add(arrOfStr2[0]);
                            horas.add(arrOfStr2[1]);
                            System.out.println("DIA: " + arrOfStr2[0]);
                            System.out.println("HORA: " + arrOfStr2[1]);
                        }
                        
                        List<Horario> horarios = new ArrayList<>();
                        List<Horario> horariosACT = act.getHorarios();
                        System.out.println("HorarioACT tamanio: " + horariosACT.size());
                        System.out.println("Dias tamanio: " + dias.size());
                        System.out.println("Horas tamanio: " + horas.size());
                        
                        int index = 0;
                        for(Horario h : act.getHorarios()){
                            index = 0;
                            for(String dia : dias){ // RECORRO LOS DIAS QUE SELECCIONO EL USUARIO
                                if(dia.equals(h.getDia())){ // SI COINCIDE CON ALGUNO DE LOS HORARIOS TAMBIEN PREGUNTO POR LA HORA DE ESE DIA
                                    if(h.getHora() == Integer.parseInt(horas.get(index))){
                                        horarios.add(h);
                                    }
                                }
                                index += 1;
                            }
                        }
                        System.out.println("Horario tamanio: " + horarios.size());
                        for(Horario h : horarios){
                            System.out.println("Horario: " + h.getHora());
                        }
                        sa.setHorarios(horarios); // LE SETTEO LOS HORARIOS A LA ACTIVIDAD
                        
                        Conexion.getInstance().persist(sa);
                        Conexion.getInstance().merge(socioo);
                        Conexion.getInstance().refresh(socioo);
                        
                        System.out.println(" Socio: " + cedulaSeleccionada);
                        System.out.println(" Actividad: " + actividadSeleccionada);
                        System.out.println(" Cuota: " + cuotaSeleccionada);
                        System.out.println(" Horarios: " + horariosSeleccionados);
                        response.setHeader("Refresh","0.1; URL=\"" + url + "?accion=socios\"");
                        break;
                    } else { // ACA LLEGO DESDE EL BOTON DE NUEVA ACTIVIDAD DE LOS DETALLES DEL SOCIO
                        int cedulaSoc = Integer.parseInt(request.getParameter("CIJugador"));
                        System.out.println("Cedula del Socio que me llega : " + cedulaSoc);
                        Socio soc = CSocios.findSocio(cedulaSoc);
                        List<Actividad> actividades = CSocios.getActividades(); // SOLO PARA TRAR TODAS LAS ACTIVIDADES
                        List<Actividad> actividadesVigentes = new ArrayList<>(); // ACA LLENO DE ACTIVIDADES VIGENTES (QUE EN DEFINITIVA SON LAS QUE ME IMPORTAN)
                        for(Actividad act: actividades){
                            if(act.isVigente()){
                                actividadesVigentes.add(act);
                            }
                        }
                        JsonArray arrayActividades = new JsonArray();
                        for (Actividad act : actividadesVigentes) // CREO UN ARRAY JSON CON TODAS LAS ACTIVIDADES VIGENTES Y SUS RESPECTIVAS CUOTAS Y HORARIOS
                        {
                            JsonObject obj = new JsonObject();
                            obj.addProperty("actividad", act.getNombre());
                            obj.addProperty("cupos", act.getCupos() - act.getSocios().size());
//                            obj.addProperty("cupos", 5);
                            
                            JsonArray arrayCuotas = new JsonArray();
                            if(act.getCuotas().size()>0){
                                for (Cuota cu : act.getCuotas())
                                {
                                    if(cu.isVigente()){
                                        JsonObject objC = new JsonObject();
                                        objC.addProperty("nombre", cu.getNombre());
                                        arrayCuotas.add(objC);
                                    }
                                }
                            } else {
                                JsonObject objC = new JsonObject();
                                objC.addProperty("nombre", "No hay cuotas disponibles");
                                arrayCuotas.add(objC);
                            }
                            obj.add("cuota", arrayCuotas);
                            JsonArray arrayHorarios = new JsonArray();
                            for (Horario h : act.getHorarios())
                            {
                                JsonObject objH = new JsonObject();
                                objH.addProperty("dia", h.getDia());
                                objH.addProperty("hora", h.getHora());
                                objH.addProperty("duracion", h.getDuracion());

                                arrayHorarios.add(objH);
                            }
                            obj.add("horarios", arrayHorarios);
                            arrayActividades.add(obj);
                        }
                        request.setAttribute("arrayActividades", arrayActividades);
                        request.setAttribute("socio", soc);
                        request.setAttribute("actividades", actividadesVigentes);
                        request.getRequestDispatcher("vistas/asociarActividad.jsp").forward(request, response);
                    }
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
