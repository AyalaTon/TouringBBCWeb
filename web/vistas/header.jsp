<%-- 
    Document   : header
    Created on : 03-jun-2022, 16:44:07
    Author     : milto
--%>


<nav class="navbar navbar-expand-lg navbar-light bg-light sticky-top" >  <!--fixed-bottom -->
    <div class="container-fluid">
        <a class="navbar-brand" href="/TouringBBC/">
            <img src="https://imgur.com/RhwWM4Z.png" alt="Logo" width="100%" height="100%" class="d-inline-block align-text-top">
        </a>
        <div class="collapse navbar-collapse" id="navbarNavDropdown">
            <ul class="navbar-nav me-auto mb-2 mb-lg-0">
                <li class="nav-item">
                    <a class="nav-link active" aria-current="page" href="/TouringBBC/">Inicio</a>
                </li>
                <li class="nav-item dropdown">
                    <a class="nav-link dropdown-toggle" href="#" id="navbarDropdownMenuLink" role="button" data-bs-toggle="dropdown" aria-expanded="false">
                        Socios
                    </a>
                    <ul class="dropdown-menu" aria-labelledby="navbarDropdownMenuLink">
                        <li><a class="dropdown-item" href="/TouringBBC/Socios?accion=socios">Ver</a></li>
                        <li><a class="dropdown-item" href="/TouringBBC/Socios?accion=altaSocio">Agregar</a></li>
                        <li><a class="dropdown-item" href="/TouringBBC/Socios?accion=tipoSocios">Tipos</a></li>
                    </ul>
                </li>
                <li class="nav-item dropdown">
                    <a class="nav-link dropdown-toggle" href="#" id="navbarDropdownMenuLink" role="button" data-bs-toggle="dropdown" aria-expanded="false">
                        Actividades
                    </a>
                    <ul class="dropdown-menu" aria-labelledby="navbarDropdownMenuLink">
                        <li><a class="dropdown-item" href="/TouringBBC/Actividades?accion=actividades">Ver</a></li>
                        <li><a class="dropdown-item" href="/TouringBBC/Actividades?accion=altaActividad">Agregar</a></li>
                    </ul>
                </li>
                <li class="nav-item">
                    <a class="nav-link" href="/TouringBBC/Cuotas?accion=cuotas">Cuotas</a>
                </li>
                
<!--            <li class="nav-item dropdown">
                    <a class="nav-link dropdown-toggle" href="#" id="navbarDropdownMenuLink" role="button" data-bs-toggle="dropdown" aria-expanded="false">
                        Categorias
                    </a>
                    <ul class="dropdown-menu" aria-labelledby="navbarDropdownMenuLink">
                        <li><a class="dropdown-item" href="#">Reportes</a></li>
                        <li><a class="dropdown-item" href="/TouringBBC/Categorias?accion=categorias">Gestionar</a></li>
                    </ul>
                </li>
-->
                <li class="nav-item">
                    <a class="nav-link" href="/TouringBBC/Categorias?accion=categorias">Categorias</a>
                </li>
            </ul>
            <ul class="navbar-nav d-flex flex-row ">
                <!-- Icons -->
                <li class="nav-item me-3 me-lg-0">
                    <a class="nav-link" href="https://www.youtube.com/user/touringpaysandu" rel="nofollow"
                       target="_blank">
                        <i class="fab fa-youtube"></i>
                    </a>
                </li>
                <li class="nav-item me-3 me-lg-0">
                    <a class="nav-link" href="https://www.facebook.com/touringpaysandu/" rel="nofollow" target="_blank">
                        <i class="fab fa-facebook-f"></i>
                    </a>
                </li>
                <li class="nav-item me-3 me-lg-0">
                    <a class="nav-link" href="https://twitter.com/touringpaysandu" rel="nofollow" target="_blank">
                        <i class="fab fa-twitter"></i>
                    </a>
                </li>
                <li class="nav-item me-3 me-lg-0">
                    <a class="nav-link" href="https://www.instagram.com/touringpaysandu/" rel="nofollow" target="_blank">
                        <i class="fa-brands fa-instagram"></i>
                    </a>
                </li>
            </ul>
        </div>
    </div>
</nav>
