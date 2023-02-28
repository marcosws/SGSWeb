<%-- 
    Document   : produto
    Created on : 02/12/2020, 14:33:28
    Author     : Marcos
--%>

<%@page import="br.senai.sp.model.entity.Produto"%>
<%@page import="br.senai.sp.model.dao.ProdutoDao"%>
<%@page import="br.senai.sp.model.entity.Departamento"%>
<%@page import="br.senai.sp.model.dao.DepartamentoDao"%>
<%@page import="br.senai.sp.model.entity.Marca"%>
<%@page import="java.util.List"%>
<%@page import="br.senai.sp.model.dao.MarcaDao"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    if(request.getAttribute("operacao") == null) {request.setAttribute("operacao","Incluir");}
    if(request.getAttribute("idProduto") == null) {request.setAttribute("idProduto","");}
    if(request.getAttribute("nomeProduto") == null) {request.setAttribute("nomeProduto","");}
    if(request.getAttribute("idMarca") == null) {request.setAttribute("idMarca","");}
    if(request.getAttribute("idDepartamento") == null) {request.setAttribute("idDepartamento","");}
%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link rel="stylesheet" href="css/style.css">
        <title>::: SGS Produto :::</title>
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
                <a href="produto.jsp" id="selected">Produto</a>
                <a href="compra.jsp">Compra</a>
                <a href="saida.jsp">Saida</a>
                <a href="estoque.jsp">Estoque</a>
            </div>
        </div>
            <div id="quadro">
            <div id="container">
                <h1>Produto</h1>
                <p>Sistema de Gerenciamento de Suprimentos</p>
                <form method="post" action="Produto?operacao=<%=request.getAttribute("operacao")%>&editar=N">
                    <label for="id-produto">Id:</label><br />
                    <input type="text" id="id-marca" class="txt-formulario" readonly="true" name="idProduto" value="<%= request.getAttribute("idProduto") %>"/><br />
                    <label for="nome-produto">Nome:</label><br />
                    <input type="text" id="nome-marca" class="txt-formulario" name="nomeProduto" value="<%= request.getAttribute("nomeProduto") %>"/><br />
                    <label for="cb-marca">Marca:</label><br />
                    
                    <select id="cb-marca" class="cb-formulario" name="idMarca">
                       <% 
                            MarcaDao marcaDao = new MarcaDao();
                            List<Marca> marcas = marcaDao.consultar();
                            for(Marca m: marcas){
                       %>
                       <option value="<%=m.getId() %>"><%=m.getNome() %></option>
                      <%
                          }
                       %>
                    </select> <br />
                    
                    <label for="cb-departamento">Departamento:</label><br />
                    <select id="cb-departamento" class="cb-formulario" name="idDepartamento">
                        <% 
                            DepartamentoDao departamentoDao = new DepartamentoDao();
                            List<Departamento> departamentos = departamentoDao.consultar();
                            for(Departamento d: departamentos){
                        %>
                      <option value="<%=d.getId() %>"><%=d.getNome() %></option>
                       <%
                          }
                        %>
                    </select><br />
                    <script>
                        document.getElementById('cb-departamento').value = "<%=request.getAttribute("idDepartamento") %>";
                        document.getElementById('cb-marca').value = "<%=request.getAttribute("idMarca") %>";
                    </script>
                    <input type="submit" id="enviar" class="btn-formulario" value="Salvar"/>  
                    <input type="button" id="cancelar" class="btn-formulario" value="Cancelar" name="cancelar" onClick="window.location.href='produto.jsp'"/>  
                    <label name="operacao">  <%= request.getAttribute("operacao") %></label><br />
                </form>
                <div id="tabela">
                    <table>
                        <caption>Produto</caption>
                        <tr>
                            <th class="produto-coluna1">Id</th>
                            <th class="produto-coluna2">Nome</th>
                            <th class="produto-coluna3">Marca</th>
                            <th class="produto-coluna4">Empresa</th>
                            <th class="produto-coluna5">Departamento</th>
                            <th class="produto-coluna6">Operação</th>
                        </tr>
                        <%
                            ProdutoDao produtoDao = new ProdutoDao();
                            List<Produto> produtos = produtoDao.consultar();
                            for(Produto p: produtos){
                        %>
                        <tr>
                            <td class="produto-coluna1"><%=p.getId() %></td>
                            <td class="produto-coluna2"><%=p.getNome() %></td>
                            <td class="produto-coluna3"><%=marcaDao.consultar(p.getIdMarca()).getNome() %></td>
                            <td class="produto-coluna4"><%=marcaDao.consultar(p.getIdMarca()).getEmpresa() %></td>
                            <td class="produto-coluna5"><%=departamentoDao.consultar(p.getIdDept()).getNome() %></td>
                            <td class="produto-coluna6"><a href="Produto?idProduto=<%=p.getId() %>&operacao=Alterar&editar=S" >Alterar<a> | <a href="Produto?idProduto=<%=p.getId() %>&operacao=Excluir&editar=S" >Excluir</a></td>
                        </tr>
                        <%
                            }
                        %>
                    </table><br /><br />
                </div>
                <div id="footer">
                    <small>SGS - Sistema de Gerenciamento de Suprimentos</small>
                </div>  
            </div>      
        </div>
    </body>
</html>

