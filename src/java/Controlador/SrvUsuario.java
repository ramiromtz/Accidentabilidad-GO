package Controlador;

import Modelo.Accidente;
import Modelo.DAOACCIDENTES;
import Modelo.DAOINVESTIGACION;
import Modelo.DAOUSUARIO;
import Modelo.DAOUSUARIOSV;
import Modelo.Investigacion;
import Modelo.Usuario;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession; 
import java.io.IOException;
import java.util.List;


public class SrvUsuario extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
		String accion = request.getParameter("accion");
		
		try {
			if(accion != null) {		
				switch (accion) {
				case "login": 
					verificar(request, response);
				break;
				case "cerrar":
					cerrarSesion(request, response);
				break;
                                case "registroaccidente":
                                    guardarAccidente(request, response);
                                break;
                                case "investigacion":
                                    guardarInvestigacion(request, response);
                                break;
				default:
					response.sendRedirect("index.jsp");
				}
			} else {
				response.sendRedirect("index.jsp");
			}
		} catch (Exception e) {
			try {
				System.out.println("Error:" + e.getMessage());
				this.getServletConfig().getServletContext().getRequestDispatcher("/mensaje.jsp").forward(request, response);
			} catch(ServletException | IOException ex) {
				System.out.println("Error:" + ex.getMessage());
			}
		}
    }
    // Cerrar sesión
    private void cerrarSesion(HttpServletRequest request, HttpServletResponse response) throws Exception {
		HttpSession session = request.getSession();
		session.setAttribute("usuario", null);
		session.invalidate();
		response.sendRedirect("index.jsp");
	}
    
    private void verificar(HttpServletRequest request, HttpServletResponse response)throws Exception {
		HttpSession session;
		DAOUSUARIO dao;
		Usuario usuario;
		usuario = this.obtenerUsuario(request);
		dao = new DAOUSUARIO();
		usuario = dao.identificar(usuario);
                
		if (usuario != null && usuario.getCargo().getTipou() == 3) {
			session = request.getSession();
			session.setAttribute("investigador", usuario);
			response.sendRedirect("homeL.jsp?pagina=1");
		} else if(usuario != null && usuario.getCargo().getTipou() == 2) {
			session = request.getSession();
			session.setAttribute("supervisor", usuario);
			response.sendRedirect("homeJ.jsp");
                        this.cargarUsuarios(request);
			
		} else {
			request.setAttribute("msje", "<p id='msg-error' style='text-align:center; padding: .75rem 0; background-color: #f00; color: #fff; margin-bottom: 1rem;'>Credenciales incorrectas o usuario inactivo</p>");
			request.getRequestDispatcher("/index.jsp").forward(request, response);
		} 
	}

    private Usuario obtenerUsuario(HttpServletRequest request) {
        Usuario u = new Usuario();
        u.setUsuario(request.getParameter("txtusername"));
        u.setClave(request.getParameter("txtpassword"));	
        return u;
    }
    
    // Cargar usuario
    private void cargarUsuarios(HttpServletRequest request)throws Exception {
        DAOUSUARIOSV daouv = new DAOUSUARIOSV();
        List<Usuario> usu;
        try {
            usu = daouv.listarUsuarios();
            request.setAttribute("usuarios", usu);
        } catch (Exception e)  {
                request.setAttribute("msje", "No se pudo cargar los usuarios, sorry :(" + e.getMessage());
        } finally {
            daouv = null;
            usu = null;
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
        processRequest(request, response);
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
        processRequest(request, response);
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

    private void guardarAccidente(HttpServletRequest request, HttpServletResponse response) throws Exception{
        if(request.getParameter("txtidusuario") != null && request.getParameter("txtusuario") 
                != null && request.getParameter("txtruta") != null && request.getParameter("txtfecha") != null && 
                request.getParameter("txtfecha") != null && request.getParameter("txthora") != null && request.getParameter("txtaccidente")
                != null && request.getParameter("txtdetalles") != null && request.getParameter("chkaviso") != null)  {
            
            Accidente accidente = new Accidente();
            DAOACCIDENTES daoaccidente = new DAOACCIDENTES();
            accidente.setUsuarioregistro(request.getParameter("txtidusuario"));
            accidente.setUsuario(request.getParameter("txtusuario"));
            accidente.setRuta(request.getParameter("txtruta"));
            accidente.setFecha(request.getParameter("txtfecha"));
            accidente.setHora(request.getParameter("txthora"));
            accidente.setLugar(request.getParameter("txtlugar"));
            accidente.setDescripcion(request.getParameter("txtaccidente"));
            accidente.setDetalleaccidente(request.getParameter("txtdetalles"));
            accidente.setAviso(request.getParameter("chkaviso"));
        
            try {
                daoaccidente.guardarAccidente(accidente); 
                request.setAttribute("msje", "<p id='msg-error' style='text-align:center; padding: .75rem 0; background-color: #00a613; color: #fff; margin-top: 1rem;'>Guardado correctamente</p>");
                this.getServletConfig().getServletContext().getRequestDispatcher("/homeJ.jsp").forward(request, response);
            } catch (Exception e) {
                request.setAttribute("msje", "No se pudo guardar" + e.getMessage());
            }
        } else {
            request.setAttribute("msje", "<p id='msg-error' style='text-align:center; padding: .75rem 0; background-color: #f00; color: #fff; margin-top: 1rem;'>Rellena el formulario</p>");
            request.getRequestDispatcher("/homeJ.jsp").forward(request, response);
        }
         
    }

    private void guardarInvestigacion(HttpServletRequest request, HttpServletResponse response) throws Exception{
       if(
        request.getParameter("txtusuario") != null && 
        request.getParameter("txtaccidente") != null && 
        request.getParameter("txtdeclaracion") != null && 
        request.getParameter("epp") != null && 
        request.getParameter("txtsupervisor") != null && 
        request.getParameter("txtdeclaracionsupervisor") != null && 
        request.getParameter("txtnombretestigo") != null && 
        request.getParameter("txtdeclaraciontestigo") != null && 
        request.getParameter("txtdictamen") != null && 
        request.getParameter("txtconclusiones") != null && 
        request.getParameter("txtgolpe") != null && 
        request.getParameter("txtmedidas") != null && 
        request.getParameter("chkanexos") != null &&
        request.getParameter("txtinvestigador") != null
               )
       {
            Investigacion inv = new Investigacion();
            DAOINVESTIGACION daoinv = new DAOINVESTIGACION();
            
            inv.setUsuario(request.getParameter("txtusuario"));
            inv.setAccidente(request.getParameter("txtaccidente"));
            inv.setUsuarioinv(request.getParameter("txtinvestigador"));
            inv.setDeclaracionVend(request.getParameter("txtdeclaracion"));
            inv.setDeclaracionSup(request.getParameter("txtdeclaracionsupervisor"));
            inv.setDeclaracionTest(request.getParameter("txtdeclaraciontestigo"));
            inv.setAnexos(request.getParameter("chkanexos"));
            inv.setCausaAcc(request.getParameter("txtgolpe"));
            inv.setInformecsh(request.getParameter("txtconclusiones"));
            inv.setDictamen(request.getParameter("txtdictamen"));
            inv.setNombretestigo(request.getParameter("txtnombretestigo"));
            inv.setSupervisor(request.getParameter("txtsupervisor"));
            inv.setEpp(request.getParameter("epp"));
            inv.setMedidas(request.getParameter("txtmedidas"));
             try {
                daoinv.guardarInvestigacion(inv);
                daoinv.actualizarEstadoAccidente(Integer.parseInt(request.getParameter("txtIdAccidente")), "investigado");
                request.setAttribute("msje", "<p id='msg-error' style='text-align:center; padding: .75rem 0; background-color: #00a613; color: #fff; margin-top: 1rem;'>Guardado correctamente</p>");
                this.getServletConfig().getServletContext().getRequestDispatcher("/homeL.jsp?pagina=1").forward(request, response);
                
             } catch (Exception e) {
                request.setAttribute("msje", "No se pudo guardar" + e.getMessage());
            } 
        } else {
            request.setAttribute("msje", "<p id='msg-error' style='text-align:center; padding: .75rem 0; background-color: #f00; color: #fff; margin-top: 1rem;'>Rellena el formulario</p>");
            request.getRequestDispatcher("/registro.jsp").forward(request, response);
        }
    }
}
