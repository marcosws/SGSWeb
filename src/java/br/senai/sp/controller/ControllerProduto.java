/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package br.senai.sp.controller;

import br.senai.sp.model.dao.ProdutoDao;
import br.senai.sp.model.entity.Produto;
import java.io.IOException;
import java.io.PrintWriter;
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
@WebServlet(name = "ControllerProduto", urlPatterns = {"/Produto"})
public class ControllerProduto extends HttpServlet {

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
        
        String id = request.getParameter("idProduto");
        String nome = request.getParameter("nomeProduto");
        String idMarca = request.getParameter("idMarca");
        String idDepartamento = request.getParameter("idDepartamento");
  
        if(request.getParameter("operacao") == null) {
            operacao = "Incluir";
        }
       
        if(editar.equals("N")){
            if(operacao.equals("Incluir")){
                Produto produto = new Produto();
                ProdutoDao produtoDao = new ProdutoDao();
                produto.setNome(nome);
                produto.setIdMarca(Long.parseLong(idMarca));
                produto.setIdDept(Long.parseLong(idDepartamento));
                produtoDao.inserir(produto);      
            }
            else if(operacao.equals("Alterar")){
                Produto produto = new Produto();
                ProdutoDao produtoDao = new ProdutoDao();
                produto.setId(Long.parseLong(id));
                produto.setNome(nome);
                produto.setIdMarca(Long.parseLong(idMarca));
                produto.setIdDept(Long.parseLong(idDepartamento));
                produtoDao.alterar(produto); 
            }
            else if(operacao.equals("Excluir")){
                Produto produto = new Produto();
                ProdutoDao produtoDao = new ProdutoDao();
                produto.setId(Long.parseLong(id));
                produtoDao.excluir(produto);  
            }
            operacao = "Incluir";
        }
        else{
            Produto produto = new Produto();
            ProdutoDao produtoDao = new ProdutoDao();
            produto = produtoDao.consultar(Long.parseLong(id));
            request.setAttribute("idProduto", produto.getId());
            request.setAttribute("nomeProduto", produto.getNome());
            request.setAttribute("idMarca", produto.getIdMarca());
            request.setAttribute("idDepartamento", produto.getIdDept());  
        }
        request.setAttribute("operacao",operacao);
        

        RequestDispatcher dispatcher = request.getRequestDispatcher("produto.jsp");
        dispatcher.forward(request, response);
    }

}
