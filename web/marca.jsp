<%-- 
    Document   : marca
    Created on : 02/12/2020, 14:20:06
    Author     : Marcos
--%>

<%@page import="br.senai.sp.model.entity.Marca"%>
<%@page import="br.senai.sp.model.dao.MarcaDao"%>
<%@page import="java.util.List"%>
<%@page import="java.util.ArrayList"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    if(request.getAttribute("operacao") == null) {request.setAttribute("operacao","Incluir");}
    if(request.getAttribute("idMarca") == null) {request.setAttribute("idMarca","");}
    if(request.getAttribute("nomeMarca") == null) {request.setAttribute("nomeMarca","");}
    if(request.getAttribute("empresaMarca") == null) {request.setAttribute("empresaMarca","");}
%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link rel="stylesheet" href="css/style.css">
        <title>::: SGS Marca :::</title>
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
                <a href="marca.jsp" id="selected">Marca</a>
                <a href="departamento.jsp">Departamento</a>
                <a href="produto.jsp">Produto</a>
                <a href="compra.jsp">Compra</a>
                <a href="saida.jsp">Saida</a>
                <a href="estoque.jsp">Estoque</a>
            </div>
        </div>
            <div id="container">
                <h1>Marca</h1>
                <p>Sistema de Gerenciamento de Suprimentos</p>
                <form method="post" action="Marca?operacao=<%=request.getAttribute("operacao")%>&editar=N">
                    <label for="id-marca">Id:</label><br />
                    <input type="text" id="id-marca" class="txt-formulario" readonly="true" name="idMarca" value="<%= request.getAttribute("idMarca") %>"/><br />
                    <label for="nome-marca">Nome:</label><br />
                    <input type="text" id="nome-marca" class="txt-formulario" name="nomeMarca" value="<%= request.getAttribute("nomeMarca") %>"/><br />
                    <label for="empresa-marca">Empresa:</label><br />
                    <input type="text" id="empresa-marca" class="txt-formulario" name="empresaMarca" value="<%= request.getAttribute("empresaMarca") %>"/><br />
                    <input type="submit" id="enviar" class="btn-formulario" value="Salvar" name="enviar"/>  
                    <input type="button" id="cancelar" class="btn-formulario" value="Cancelar" name="cancelar" onClick="window.location.href='marca.jsp'"/>  
                    <label name="operacao">  <%= request.getAttribute("operacao") %></label><br />
                </form>
                <div id="tabela">
                    <table>
                        <caption>Marca</caption>
                        <tr>
                            <th class="marca-coluna1">Id</th>
                            <th class="marca-coluna2">Nome</th>
                            <th class="marca-coluna3">Empresa</th>
                            <th class="marca-coluna4">Operação</th>
                        </tr>
                        <%
                            MarcaDao marcaDao = new MarcaDao();
                            List<Marca> marcas = marcaDao.consultar();
                            for(Marca m: marcas){
                        %>
                        <tr>
                            <td class="marca-coluna1"><%=m.getId() %></td>
                            <td class="marca-coluna2"><%=m.getNome() %></td>
                            <td class="marca-coluna3"><%=m.getEmpresa() %></td>
                            <td class="marca-coluna4"><a href="Marca?idMarca=<%=m.getId() %>&operacao=Alterar&editar=S" >Alterar<a> | <a href="Marca?idMarca=<%=m.getId() %>&operacao=Excluir&editar=S" >Excluir</a></td>
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

