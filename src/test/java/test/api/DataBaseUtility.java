package test.api;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.ResultSetMetaData;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.HashMap;
import java.util.LinkedList;
import java.util.List;
import java.util.Map;

public class DataBaseUtility {

	// we need to have DB information
	/*
	 * DB URL, DB UserName, DB Password the db information can be found on
	 * properties file of data driven framework - TestNG
	 */
	private static final String db_url = "jdbc:mysql://tek-database-server.mysql.database.azure.com:3306/tek_insurance_app?useSSL=true&requireSSL=false";
	private static final String db_userName = "tek_student_user";
	private static final String db_password = "MAY_2022";

	/**
	 * we need to establish a connection between this project and DB
	 */
	private static Connection getConnection() {
		try {
			System.out.println("Making Connection to Databse");
			return DriverManager.getConnection(db_url, db_userName, db_password);
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			throw new RuntimeException("Error Connecting to Database");
		}
	}

	/**
	 * we need to create reference to Statement Interface
	 */
	private static Statement getConnectionStatement() {
		try {
			return getConnection().createStatement();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			throw new RuntimeException("Error Creating Statement");
		}
	}

	public static ResultSet executeQuery(String query) {
		Statement statement;
		statement = getConnectionStatement();
		try {
			return statement.executeQuery(query);
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			throw new RuntimeException("Error Executing query");
		}
	}

	public static List<Map<String, Object>> queryResult(String query) {
		Statement statement = null;
		try {
			List<Map<String, Object>> list = new LinkedList<>();
			ResultSet resultSet = executeQuery(query);
			statement = resultSet.getStatement();
			ResultSetMetaData metadata = resultSet.getMetaData();
			int columns = metadata.getColumnCount();
			while (resultSet.next()) {
				Map<String, Object> map = new HashMap<>();
				for (int i = 1; i <= columns; i++) {
					map.put(metadata.getColumnName(i), resultSet.getObject(i));
				}
				list.add(map);
			}
			return list;
		} catch (SQLException e) {
			throw new RuntimeException("Error executing query");
		} finally {
			if (statement != null) {
				try {
					statement.getConnection().close();
					statement.close();
				} catch (SQLException e) {

				}

			}

		}
	}
	/**
	 * This method extracts the result from the List of Map result set and return in a String data type
	 * @param query
	 * @param columName
	 * @return
	 */
	
	public static String result(String query, String columName) {
		List<Map<String, Object>>result = queryResult(query);
		return result.get(0).get(columName).toString();
	}

}
