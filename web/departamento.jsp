<%-- 
    Document   : departamento
    Created on : 02/12/2020, 14:21:43
    Author     : Marcos
--%>

<%@page import="br.senai.sp.model.entity.Departamento"%>
<%@page import="java.util.List"%>
<%@page import="br.senai.sp.model.dao.DepartamentoDao"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    if(request.getAttribute("operacao") == null) {request.setAttribute("operacao","Incluir");}
    if(request.getAttribute("idDepartamento") == null) {request.setAttribute("idDepartamento","");}
    if(request.getAttribute("nomeDepartamento") == null) {request.setAttribute("nomeDepartamento","");}
%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link rel="stylesheet" href="css/style.css">
        <title>::: SGS Departamento :::</title>
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
                <a href="departamento.jsp" id="selected">Departamento</a>
                <a href="produto.jsp">Produto</a>
                <a href="compra.jsp">Compra</a>
                <a href="saida.jsp">Saida</a>
                <a href="estoque.jsp">Estoque</a>
            </div>
        </div>
            <div id="container">
                <h1>Departamento</h1>
                <p>Sistema de Gerenciamento de Suprimentos</p>
                <form method="post" action="Departamento?operacao=<%=request.getAttribute("operacao")%>&editar=N">
                    <label for="id-departamento">Id:</label><br />
                    <input type="text" id="id-departamento" class="txt-formulario" readonly="true" name="idDepartamento" value="<%= request.getAttribute("idDepartamento") %>"/><br />
                    <label for="nome-departamento">Nome:</label><br />
                    <input type="text" id="nome-departamento" class="txt-formulario" name="nomeDepartamento" value="<%= request.getAttribute("nomeDepartamento") %>"/><br />
                    <input type="submit" id="enviar" class="btn-formulario" value="Salvar"/>  
                    <input type="button" id="cancelar" class="btn-formulario" value="Cancelar" name="cancelar" onClick="window.location.href='departamento.jsp'"/>  
                    <label name="operacao">  <%= request.getAttribute("operacao") %></label><br />
                </form>
                <div id="tabela">
                    <table>
                        <caption>Departamento</caption>
                        <tr>
                            <th class="departamento-coluna1">Id</th>
                            <th class="departamento-coluna2">Nome</th>
                            <th class="departamento-coluna3">Operação</th>
                        </tr>
                        <% 
                            DepartamentoDao departamentoDao = new DepartamentoDao();
                            List<Departamento> departamentos = departamentoDao.consultar();
                            for(Departamento d: departamentos){
                        %>
                        <tr>
                            <td class="departamento-coluna1"><%=d.getId() %></td>
                            <td class="departamento-coluna2"><%=d.getNome() %></td>
                            <td class="departamento-coluna3"><a href="Departamento?idDepartamento=<%=d.getId() %>&operacao=Alterar&editar=S" >Alterar<a> | <a href="Departamento?idDepartamento=<%=d.getId() %>&operacao=Excluir&editar=S" >Excluir</a></td>
                        </tr>
                        <%
                            }
                        %>
                    </table>
                </div>
                <div id="footer">
                    <small>SGS - Sistema de Gerenciamento de Suprimentos</small>
                </div>
            </div>
        </div>
    </body>
</html>

