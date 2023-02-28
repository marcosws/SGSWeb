/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package br.senai.sp.model.service;


/**
 *
 * @author Marcos
 */
public class SaidaService {
    
    private String mensagemErro;
    
    public SaidaService(){
        mensagemErro = "";
    }

    public String getMensagemErro() {
        return mensagemErro;
    }
    
    public boolean verificaEstoque(int qtdEstoque, int qtdSaida){
        
         mensagemErro = "";
        if(qtdEstoque == 0){
            mensagemErro = "Produto fora de estoque";
            return false;
        }
        else if(qtdSaida > qtdEstoque){
            mensagemErro = "Quantidade informada não pode ser maior que a quantidade disponivel no estoque";
            return false;
        }
        else{
            return true;
        }
    }
    public boolean verificaAlteracaoEstoque(int qtdCadastrada, int qtdAlterada){
        
         mensagemErro = "";
        if(qtdAlterada > qtdCadastrada){
            mensagemErro =  "Quantidade informada não pode ser maior que a quantidade cadastrada";
            return false;
        }
        else{
            return true;
        }
    }
    public int atualizaEstoque(int qtdEstoque, int qtdSaida){
        return qtdEstoque - qtdSaida;
    }
    
}
