<%-- 
    Document   : estoque
    Created on : 02/12/2020, 14:34:24
    Author     : Marcos
--%>

<%@page import="br.senai.sp.model.service.CommonService"%>
<%@page import="br.senai.sp.model.entity.Estoque"%>
<%@page import="br.senai.sp.model.dao.EstoqueDao"%>
<%@page import="br.senai.sp.model.entity.Departamento"%>
<%@page import="java.util.List"%>
<%@page import="br.senai.sp.model.dao.DepartamentoDao"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link rel="stylesheet" href="css/style.css">
        <title>::: SGS Estoque :::</title>
    </head>
    <body>
        <div id="body">
        <div id="cabecalho">
            <div id="logo">
                <h1>SGS</h1>
                <p id="subtitulo">Sistema de Gerenciamento de Suprimentos</p>
            </div>
            <div id="menu">
                <a href="index.jsp">Home</a>
                <a href="marca.jsp">Marca</a>
                <a href="departamento.jsp">Departamento</a>
                <a href="produto.jsp">Produto</a>
                <a href="compra.jsp">Compra</a>
                <a href="saida.jsp">Saida</a>
                <a href="estoque.jsp" id="selected">Estoque</a>
            </div>
        </div>
            <div id="container">
                <h1>Estoque</h1>
                <p>Sistema de Gerenciamento de Suprimentos</p>
                    <form method="post" action="Estoque">
                    <label for="cb-departamento">Departamento:</label><br />
                    <select id="cb-departamento" class="cb-formulario" name="departamento">
                        <% 
                            DepartamentoDao departamentoDao = new DepartamentoDao();
                            List<Departamento> departamentos = departamentoDao.consultar();
                            for(Departamento d: departamentos){
                        %>
                        <option value="<%=d.getNome() %>"><%=d.getNome() %></option>
                       <%
                          }
                       %>
                    </select><br />
                    <input type="submit" id="enviar" class="btn-formulario" value="Consultar" name="enviar"/>  
                    <input type="button" id="cancelar" class="btn-formulario" value="Cancelar" name="cancelar" onClick="window.location.href='estoque.jsp'"/>  
                </form>
                <div id="tabela">
                    <table>
                        <caption>Estoque</caption>
                        <tr>
                            <th class="estoque-coluna1">Departamento</th>
                            <th class="estoque-coluna2">Empresa</th>
                            <th class="estoque-coluna3">Marca</th>
                            <th class="estoque-coluna4">Produto</th>
                            <th class="estoque-coluna5">Preço</th>
                            <th class="estoque-coluna6">Data Cadastro</th>
                            <th class="estoque-coluna7">Quantidade</th>
                            <th class="estoque-coluna8">Estoque</th>
                        </tr>
                        <%
                            CommonService commonService = new CommonService();
                            if(request.getAttribute("departamento")!= null){
                                String departamento = request.getAttribute("departamento").toString();
                                EstoqueDao estoqueDao = new EstoqueDao();
                                List<Estoque> estoques = estoqueDao.consultar(departamento);
                                for(Estoque e: estoques){
                        %>
                        <tr>
                            <td class="estoque-coluna1"><%=e.getDepartamento() %></td>
                            <td class="estoque-coluna2"><%=e.getEmpresa() %></td>
                            <td class="estoque-coluna3"><%=e.getMarca() %></td>
                            <td class="estoque-coluna4"><%=e.getProduto() %></td>
                            <td class="estoque-coluna5"><%=e.getPreco() %></td>
                            <td class="estoque-coluna6"><%=commonService.getStringData(e.getData()) %></td>                              
                            <td class="estoque-coluna7"><%=e.getQuantidade() %></td>
                            <td class="estoque-coluna8"><%=e.getEstoque() %></td>
                        </tr>
                        <%
                                }
                            }
                        %>
                    </table><br /><br /><br />
                <div id="footer">
                    <small>SGS - Sistema de Gerenciamento de Suprimentos</small>
                </div>
            </div>
        </div>
    </body>
</html>

