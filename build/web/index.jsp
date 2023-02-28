<%-- 
    Document   : index
    Created on : 01/12/2020, 21:02:41
    Author     : Marcos
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link rel="stylesheet" href="css/style.css">
        <title>::: SGS Home :::</title>
    </head>
    <body>
        <div id="body">
        <div id="cabecalho">
            <div id="logo">
                <h1>SGS</h1>
                <p id="subtitulo">Sistema de Gerenciamento de Suprimentos</p>
            </div>
            <div id="menu">
                <a href="index.jsp" id="selected">Home</a>
                <a href="marca.jsp">Marca</a>
                <a href="departamento.jsp">Departamento</a>
                <a href="produto.jsp">Produto</a>
                <a href="compra.jsp">Compra</a>
                <a href="saida.jsp">Saida</a>
                <a href="estoque.jsp">Estoque</a>
            </div>
        </div>
            <div id="container">
                <h1>Home</h1>
                <p>Sistema de Gerenciamento de Suprimentos</p>
                <div id="conteudo">
                    <h4>Cadastro</h4>
                    <ul>
                        <li>Marca</li>
                        <li>Departamento</li>
                        <li>Produto</li>
                    </ul>
                    <h4>Operações</h4>
                    <ul>
                        <li>Compa</li>
                        <li>Saida</li>
                    </ul>
                    <h4>Consulta</h4>
                    <ul>
                        <li>Estoque</li>
                    </ul>
                </div>
                <div id="footer">
                    <small>SGS - Sistema de Gerenciamento de Suprimentos</small>
                </div>
            </div>
        </div>
    </body>
</html>
