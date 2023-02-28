/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package br.senai.sp.controller;

import br.senai.sp.model.dao.DepartamentoDao;
import br.senai.sp.model.entity.Departamento;
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
@WebServlet(name = "ControllerDepartamento", urlPatterns = {"/Departamento"})
public class ControllerDepartamento extends HttpServlet {

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
    protected void service(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
       
        request.setCharacterEncoding("UTF-8");
        String operacao = request.getParameter("operacao");
        String editar = request.getParameter("editar");
        
        String id = request.getParameter("idDepartamento");
        String nome = request.getParameter("nomeDepartamento");
  
        if(request.getParameter("operacao") == null) {
            operacao = "Incluir";
        }
       
        if(editar.equals("N")){
            if(operacao.equals("Incluir")){
                Departamento departamento = new Departamento();
                DepartamentoDao departamentoDao = new DepartamentoDao();
                departamento.setNome(nome);
                departamentoDao.inserir(departamento);
            }
            else if(operacao.equals("Alterar")){
                Departamento departamento = new Departamento();
                DepartamentoDao departamentoDao = new DepartamentoDao();
                departamento.setId(Long.parseLong(id));
                departamento.setNome(nome);
                departamentoDao.alterar(departamento);
            }
            else if(operacao.equals("Excluir")){
                Departamento departamento = new Departamento();
                DepartamentoDao departamentoDao = new DepartamentoDao();
                departamento.setId(Long.parseLong(id));
                departamentoDao.excluir(departamento);
            }
            operacao = "Incluir";
        }
        else{
            Departamento departamento = new Departamento();
            DepartamentoDao departamentoDao = new DepartamentoDao();
            departamento = departamentoDao.consultar(Long.parseLong(id));
            request.setAttribute("idDepartamento", departamento.getId());
            request.setAttribute("nomeDepartamento", departamento.getNome());
        }
        request.setAttribute("operacao",operacao);
        
        RequestDispatcher dispatcher = request.getRequestDispatcher("departamento.jsp");
        dispatcher.forward(request, response);
        
    }

   
}
