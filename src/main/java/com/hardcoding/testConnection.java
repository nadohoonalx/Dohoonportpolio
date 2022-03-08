package com.hardcoding;

import java.sql.Connection;

import javax.sql.DataSource;

import org.apache.ibatis.session.SqlSession;
import org.apache.ibatis.session.SqlSessionFactory;
import org.junit.Test;
import org.springframework.beans.factory.annotation.Autowired;


public class testConnection {

@Autowired
private DataSource dataSource;

@Autowired 
private SqlSessionFactory sqlSessionFactory;

@Test
public void testConnection() {
		
	try (
		Connection con = dataSource.getConnection();
		SqlSession session = sqlSessionFactory.openSession();
	)
	{
		System.out.println("con" + con);
		System.out.println("session" + session);
	}catch(Exception e) {
		e.printStackTrace();
	}
}
}
