/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package br.senai.sp.controller;

import br.senai.sp.model.dao.CompraDao;
import br.senai.sp.model.entity.Compra;
import br.senai.sp.model.service.CommonService;
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
@WebServlet(name = "ControllerCompra", urlPatterns = {"/Compra"})
public class ControllerCompra extends HttpServlet {

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
        
        String id = request.getParameter("idCompra");
        String idProduto = request.getParameter("idProduto");
        String quantidade = request.getParameter("quantidadeCompra");
        String preco = request.getParameter("precoCompra");
        
        String debug = "id[" + id + "] idProduto[" + idProduto + "] quantidade[" + quantidade + "] preco[" + preco + "].";
  
        if(request.getParameter("operacao") == null) {
            operacao = "Incluir";
        }
       
        if(editar.equals("N")){
            if(operacao.equals("Incluir")){
                CompraDao compraDao = new CompraDao();
                Compra compra = new Compra();
                compra.setPreco(Double.parseDouble(preco));
                Calendar date = Calendar.getInstance();
                compra.setData(date);
                compra.setQuantidade(Integer.parseInt(quantidade));
                compra.setTotal(compra.getQuantidade());
                compra.setIdProduto(Long.parseLong(idProduto));
                compraDao.inserir(compra);      
            }
            else if(operacao.equals("Alterar")){
                CompraDao compraDao = new CompraDao();
                Compra compra = new Compra();
                compra.setId(Long.parseLong(id));
                compra.setPreco(Double.parseDouble(preco));
                compra.setQuantidade(Integer.parseInt(quantidade));
                compra.setTotal(compra.getQuantidade());
                compra.setIdProduto(Long.parseLong(idProduto));
                compraDao.alterar(compra);
            }
            else if(operacao.equals("Excluir")){
                CompraDao compraDao = new CompraDao();
                Compra compra = new Compra();
                compra.setId(Long.parseLong(id));
                compraDao.excluir(compra);  
            }
            operacao = "Incluir";
        }
        else{
            CommonService commonService = new CommonService();
            CompraDao compraDao = new CompraDao();
            Compra compra = new Compra();
            compra = compraDao.consultar(Long.parseLong(id));
            request.setAttribute("idCompra", compra.getId());
            request.setAttribute("dataCompra", commonService.getStringData(compra.getData()));
            request.setAttribute("idProduto", compra.getIdProduto()); 
            request.setAttribute("quantidadeCompra", compra.getQuantidade());
            request.setAttribute("precoCompra", compra.getPreco());  
            request.setAttribute("totalCompra", compra.getTotal()); 
        }
        request.setAttribute("operacao",operacao);
        
        request.setAttribute("debug",debug);

        RequestDispatcher dispatcher = request.getRequestDispatcher("compra.jsp");
        dispatcher.forward(request, response);
        
    }

}
