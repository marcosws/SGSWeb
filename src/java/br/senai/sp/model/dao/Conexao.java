/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package br.senai.sp.model.dao;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;
import java.util.Properties;
import java.util.logging.Level;
import java.util.logging.Logger;
import org.sqlite.SQLiteConfig;

/**
 * @author Marcos
 */
public class Conexao {
    
    private Properties connectionProperties = new Properties();
    
    public Connection getConnection() {
        
        SQLiteConfig config = new SQLiteConfig();
        config.enforceForeignKeys(true);
        connectionProperties = config.toProperties();
        String strConexao = "jdbc:sqlite:C:/Estudos/JAVA/senai/BackendJavaSpringBoot/SGSWeb/db/SGSDB_WEB.db";
        try {
            Class.forName("org.sqlite.JDBC");
        } catch (ClassNotFoundException ex) {
            Logger.getLogger(Conexao.class.getName()).log(Level.SEVERE, null, ex);
        }
        try{	
            return DriverManager.getConnection(strConexao,connectionProperties);	
	}
	catch(SQLException e){
            e.printStackTrace();
        }
        return null;
    }
}
