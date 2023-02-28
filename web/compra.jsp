<%-- 
    Document   : compra
    Created on : 02/12/2020, 14:33:47
    Author     : Marcos
--%>

<%@page import="br.senai.sp.model.service.CommonService"%>
<%@page import="br.senai.sp.model.entity.Compra"%>
<%@page import="br.senai.sp.model.dao.CompraDao"%>
<%@page import="br.senai.sp.model.entity.Marca"%>
<%@page import="br.senai.sp.model.dao.DepartamentoDao"%>
<%@page import="br.senai.sp.model.dao.MarcaDao"%>
<%@page import="br.senai.sp.model.entity.Produto"%>
<%@page import="java.util.List"%>
<%@page import="br.senai.sp.model.dao.ProdutoDao"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    CommonService commonService = new CommonService();
    if(request.getAttribute("operacao") == null) {request.setAttribute("operacao","Incluir");}
    if(request.getAttribute("idCompra") == null) {request.setAttribute("idCompra","");}
    if(request.getAttribute("dataCompra") == null) {request.setAttribute("dataCompra",commonService.getStringData());}
    if(request.getAttribute("idProduto") == null) {request.setAttribute("idProduto","1");}
    if(request.getAttribute("quantidadeCompra") == null) {request.setAttribute("quantidadeCompra","");}
    if(request.getAttribute("precoCompra") == null) {request.setAttribute("precoCompra","");}
    if(request.getAttribute("totalCompra") == null) {request.setAttribute("totalCompra","");}
%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link rel="stylesheet" href="css/style.css">
        <title>::: SGS Compra :::</title>
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
                <a href="compra.jsp" id="selected">Compra</a>
                <a href="saida.jsp">Saida</a>
                <a href="estoque.jsp">Estoque</a>
            </div>
        </div>
            <div id="container">
                <h1>Compra</h1>
                <p>Sistema de Gerenciamento de Suprimentos</p>
                <form method="post" action="Compra?operacao=<%=request.getAttribute("operacao")%>&editar=N">
                    
                    <label for="id-compra">Id:</label><br />
                    <input type="text" id="id-compra" class="txt-formulario" readonly="true" name="idCompra" value="<%= request.getAttribute("idCompra") %>"/><br />
                    
                    
                    <label for="data-compra">Data:</label><br />
                    <input type="text" id="data-compra" class="txt-formulario" readonly="true" name="dataCompra" value="<%= request.getAttribute("dataCompra") %>"/><br />
                    
                    <label for="cb-produto">Departamento:</label><br />
                    <select id="cb-produto" class="cb-formulario" name="idProduto">
                        <% 
                            MarcaDao marcaDao = new MarcaDao();
                            DepartamentoDao departamentoDao = new DepartamentoDao();
                            ProdutoDao produtoDao = new ProdutoDao();
                            List<Produto> produtos = produtoDao.consultar();
                            for(Produto p: produtos){
                        %>
                        <option value="<%=p.getId() %>"><%=p.getId() + " | " + 
                                          p.getNome() + " | " + 
                                          marcaDao.consultar(p.getIdMarca()).getNome()  + " | " +
                                          marcaDao.consultar(p.getIdMarca()).getEmpresa()   + " | " +
                                          departamentoDao.consultar(p.getIdDept()).getNome()  %></option>
                       <%
                          }
                        %>
                    </select><br />
               
                    <label for="quantidade-compra">Quantidade Adquirida:</label><br />
                    <input type="text" id="quantidade-compra" class="txt-formulario" name="quantidadeCompra" value="<%= request.getAttribute("quantidadeCompra") %>"/><br />
                    
                    <label for="preco-compra">Preço:</label><br />
                    <input type="text" id="preco-compra" class="txt-formulario" name="precoCompra" value="<%= request.getAttribute("precoCompra") %>"/><br />
                    
                    <label for="total-estoque-compra">Total Estoque:</label><br />
                    <input type="text" id="total-estoque-compra" class="txt-formulario" readonly="true" name="totalCompra" value="<%= request.getAttribute("totalCompra") %>"/><br />
                    <script>
                        document.getElementById('cb-produto').value = "<%=request.getAttribute("idProduto") %>";
                    </script>
                    <input type="submit" id="enviar" class="btn-formulario" value="Salvar" name="enviar"/>  
                    <input type="button" id="cancelar" class="btn-formulario" value="Cancelar" name="cancelar" onClick="window.location.href='compra.jsp'"/>  
                    <label name="operacao">  <%= request.getAttribute("operacao") %></label><br />
                </form>
                <div id="tabela">
                    <table>
                        <caption>Compra</caption>
                        <tr>
                            <th class="compra-coluna1">Id</th>
                            <th class="compra-coluna2">Data</th>
                            <th class="compra-coluna3">Preço</th>
                            <th class="compra-coluna4">Quantidade</th>
                            <th class="compra-coluna5">Total</th>
                            <th class="compra-coluna6">Produto</th>
                            <th class="compra-coluna7">Operação</th>
                        </tr>
                        <%
                            CompraDao compraDao = new CompraDao();
                            List<Compra> compras = compraDao.consultar();
                            for(Compra c: compras){
                        %>
                        <tr>
                            <td class="compra-coluna1"><%=c.getId() %></td>
                            <td class="compra-coluna2"><%=commonService.getStringData(c.getData()) %></td>
                            <td class="compra-coluna3"><%=c.getPreco() %></td>
                            <td class="compra-coluna4"><%=c.getQuantidade() %></td>
                            <td class="compra-coluna5"><%=c.getTotal() %></td>
                            <td class="compra-coluna6"><%=produtoDao.consultar(c.getIdProduto()).getId() + " | " + produtoDao.consultar(c.getIdProduto()).getNome() %></td>                              
                            <td class="compra-coluna7"><a href="Compra?idCompra=<%=c.getId() %>&operacao=Alterar&editar=S" >Alterar<a> | <a href="Compra?idCompra=<%=c.getId() %>&operacao=Excluir&editar=S" >Excluir</a></td>
                        </tr>
                        <%
                            }
                        %>
                    </table><br /><br /><br />
                </div>
                <div id="footer">
                    <small>SGS - Sistema de Gerenciamento de Suprimentos</small>
                </div>
            </div>
        </div>
    </body>
</html>

