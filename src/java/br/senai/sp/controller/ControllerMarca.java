/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package br.senai.sp.controller;

import br.senai.sp.model.dao.MarcaDao;
import br.senai.sp.model.entity.Marca;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.List;
import javax.servlet.FilterChain;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 *
 * @author Marcos
 */
@WebServlet("/Marca")
public class ControllerMarca extends HttpServlet {

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        
        request.setCharacterEncoding("UTF-8");
        String operacao = request.getParameter("operacao");
        String editar = request.getParameter("editar");
        
        String id = request.getParameter("idMarca");
        String nome = request.getParameter("nomeMarca");
        String empresa = request.getParameter("empresaMarca");
    
        if(request.getParameter("operacao") == null) {
            operacao = "Incluir";
        }
       
        if(editar.equals("N")){
            if(operacao.equals("Incluir")){
                Marca marca = new Marca();
                MarcaDao marcaDao = new MarcaDao();
                marca.setNome(nome);
                marca.setEmpresa(empresa);
                marcaDao.inserir(marca);
            }
            else if(operacao.equals("Alterar")){
                Marca marca = new Marca();
                MarcaDao marcaDao = new MarcaDao();
                marca.setId(Long.parseLong(id));
                marca.setNome(nome);
                marca.setEmpresa(empresa);
                marcaDao.alterar(marca);
            }
            else if(operacao.equals("Excluir")){
                Marca marca = new Marca();
                MarcaDao marcaDao = new MarcaDao();
                marca.setId(Long.parseLong(id));
                marcaDao.excluir(marca);
            }
            operacao = "Incluir";
        }
        else{
            Marca marca = new Marca();
            MarcaDao marcaDao = new MarcaDao();
            marca = marcaDao.consultar(Long.parseLong(id));
            request.setAttribute("idMarca", marca.getId());
            request.setAttribute("nomeMarca", marca.getNome());
            request.setAttribute("empresaMarca", marca.getEmpresa());
        }
        request.setAttribute("operacao",operacao);
        
        RequestDispatcher dispatcher = request.getRequestDispatcher("marca.jsp");
        dispatcher.forward(request, response);
    
    }
    
    
}
