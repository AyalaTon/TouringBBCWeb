/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package resources;

import Clases.TipoSocio;
import Controladores.CSocios;
import java.util.List;

/**
 *
 * @author milto
 */
public class ThreadB extends Thread {


//    public void run(String tipoSocio) {
//        synchronized (this) {
//                    List<TipoSocio> tipos = CSocios.obtenerTiposSocios();
//                    boolean exist = false;
//                    for (TipoSocio t : tipos) {
//                        if(t.getNombre().equals(tipoSocio)){
//                            exist = true;
//                            message = "Error: Ya existe el tipo socio " + tipoSocio;
//                            System.out.println("EXISTE: " + t.getNombre());
//                            break;
//                        }
//                        System.out.println(t.getNombre());
//                    }
//
//            notify();
//        }
//    }

    public void start(String[] cosas) {
        synchronized (this) {
            String tipoSocio = cosas[0];
            List<TipoSocio> tipos = CSocios.obtenerTiposSocios();
            boolean exist = false;
            for (TipoSocio t : tipos) {
                if(t.getNombre().equals(tipoSocio)){
                    exist = true;
                    cosas[1] = "Error: Ya existe el tipo socio " + tipoSocio;
                    System.out.println("EXISTE: " + t.getNombre());
                    break;
                }
                System.out.println(t.getNombre());
            }
            if(exist == false) {
                CSocios.guardarTipoSocio(tipoSocio);
            }
            notifyAll();
        }
    }
}
