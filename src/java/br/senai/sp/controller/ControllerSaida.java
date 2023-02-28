/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package br.senai.sp.controller;

import br.senai.sp.model.dao.CompraDao;
import br.senai.sp.model.dao.SaidaDao;
import br.senai.sp.model.entity.Compra;
import br.senai.sp.model.entity.Saida;
import br.senai.sp.model.service.CommonService;
import br.senai.sp.model.service.SaidaService;
import java.io.IOException;
import java.util.Calendar;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 *
 * @author Marcos
 */
@WebServlet(name = "ControllerSaida", urlPatterns = {"/Saida"})
public class ControllerSaida extends HttpServlet {

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void service(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        request.setCharacterEncoding("UTF-8");
        String operacao = request.getParameter("operacao");
        String editar = request.getParameter("editar");
        
        String id = request.getParameter("idSaida");
        String idCompra = request.getParameter("idCompra");
        String quantidade = request.getParameter("quantidadeSaida");
     
        
        String debug = "id[" + id + "] idCompra[" + idCompra + "] quantidade[" + quantidade + "].";
  
        if(request.getParameter("operacao") == null) {
            operacao = "Incluir";
        }
       
        if(editar.equals("N")){
            if(operacao.equals("Incluir")){
                
               SaidaDao saidaDao = new SaidaDao();
                Saida saida = new Saida();
                SaidaService saidaService = new SaidaService();
                CompraDao compraDao = new CompraDao();
                Compra compra = new Compra();
                compra = compraDao.consultar(Long.parseLong(idCompra));

                if(saidaService.verificaEstoque(compra.getTotal(),Integer.parseInt(quantidade))){
                    Calendar data = Calendar.getInstance();
                    saida.setData(data);
                    saida.setQuantidade(Integer.parseInt(quantidade));
                    saida.setIdCompra(Long.parseLong(idCompra));
                    saida.setIdProduto(compra.getIdProduto());
                    saidaDao.inserir(saida);
                    compra.setTotal(saidaService.atualizaEstoque(compra.getTotal(), Integer.parseInt(quantidade)));
                    compraDao.alterar(compra);
                }
                request.setAttribute("status",saidaService.getMensagemErro());
               
            }
            else if(operacao.equals("Alterar")){
                
                SaidaDao saidaDao = new SaidaDao();
                Saida saida = new Saida();
                SaidaService saidaService = new SaidaService();
                CompraDao compraDao = new CompraDao();
                Compra compra = new Compra();
                compra = compraDao.consultar(Long.parseLong(idCompra));

                if(saidaService.verificaAlteracaoEstoque(compra.getQuantidade(),Integer.parseInt(quantidade))){

                    saida.setId(Long.parseLong(id));
                    saida.setQuantidade(Integer.parseInt(quantidade));
                    saida.setIdCompra(Long.parseLong(idCompra));
                    saida.setIdProduto(compra.getIdProduto());
                    saidaDao.alterar(saida);
                    compra.setTotal(saidaService.atualizaEstoque(compra.getQuantidade(), Integer.parseInt(quantidade)));
                    compraDao.alterar(compra);
                    
                }
                request.setAttribute("status",saidaService.getMensagemErro());
                
            }
            else if(operacao.equals("Excluir")){
 
                SaidaDao saidaDao = new SaidaDao();
                Saida saida = new Saida();
                CompraDao compraDao = new CompraDao();
                Compra compra = new Compra();
                saida = saidaDao.consultar(Long.parseLong(id));
                saidaDao.excluir(saida);
                compra = compraDao.consultar(saida.getIdCompra());
                compra.setTotal(compra.getQuantidade());
                compraDao.alterar(compra);   
            }
            operacao = "Incluir";
        }
        else{
            CommonService commonService = new CommonService();
            SaidaDao saidaDao = new SaidaDao();
            Saida saida = new Saida();
            saida = saidaDao.consultar(Long.parseLong(id));
            request.setAttribute("idSaida", saida.getId());
            request.setAttribute("dataSaida", commonService.getStringData(saida.getData()));
            request.setAttribute("idCompra", saida.getIdCompra()); 
            request.setAttribute("quantidadeSaida", saida.getQuantidade());

        }
        request.setAttribute("operacao",operacao);
        request.setAttribute("debug",debug);

        RequestDispatcher dispatcher = request.getRequestDispatcher("saida.jsp");
        dispatcher.forward(request, response);
          
    }

}
