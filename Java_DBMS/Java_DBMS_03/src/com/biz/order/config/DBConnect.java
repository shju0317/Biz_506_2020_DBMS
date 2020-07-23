package com.biz.order.config;

import java.io.IOException;
import java.io.InputStream;

import org.apache.ibatis.io.Resources;
import org.apache.ibatis.session.SqlSessionFactory;
import org.apache.ibatis.session.SqlSessionFactoryBuilder;

public class DBConnect {
	private static String configFile;
	private static SqlSessionFactory sqlSessionFactory;

	static {
		configFile = "com/biz/order/config/mybatis-context.xml";
		InputStream inputStream = null;

		try {
			inputStream = Resources.getResourceAsStream(configFile);

			SqlSessionFactoryBuilder builder = new SqlSessionFactoryBuilder();

			if (sqlSessionFactory == null) {
				sqlSessionFactory = builder.build(inputStream);
			}

		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}

	public static SqlSessionFactory getSqlSessionFactory() {
		return sqlSessionFactory;
	}
}
