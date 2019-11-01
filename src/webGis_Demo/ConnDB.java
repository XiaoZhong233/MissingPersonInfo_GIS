package webGis_Demo;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;


public class ConnDB {
	private static String URL = "jdbc:mysql://localhost:3306/";	//���ݿ�����  "webgisdb"�����ݿ���
	private static String USER = "root";//���ݿ��˺�
	private static String PASSWORD = "root";//���ݿ�����
	private static String DB_NAME = "webgisdb";//���ݿ�����
	public static String TB_NAME="missingperson";//����
	private  Connection conn = null;
	
	
	
	/**
	 * �޲ι��캯��Ĭ�ϵ����ݿ�Ϊwebgisdb
	 */
	public ConnDB() {
		try {
			URL="jdbc:mysql://localhost:3306/"+DB_NAME+"?characterEncoding=utf-8";
			Class.forName("com.mysql.jdbc.Driver");
			} catch (ClassNotFoundException e) {
			e.printStackTrace();
			}
	}
	
	public ConnDB(String databaseName) {
		try {
		DB_NAME = databaseName;
		Class.forName("com.mysql.jdbc.Driver");
		URL=URL+databaseName+"?characterEncoding=utf-8";
		} catch (ClassNotFoundException e) {
		e.printStackTrace();
		}
	}
	
	//��ȡ���ݿ�����
	public Connection getConnction() {
	try {
	conn = DriverManager.getConnection(URL, USER, PASSWORD);
	} catch (SQLException e) {
	e.printStackTrace();
	}
	return conn;
	}
	
	
	//�ر����ݿ�����
	public void closeCon(Connection con) throws Exception{
	if(con!=null){
	con.close();
	}
	}
	
	 /** 
     * ���ݴ����SQL��䷵��һ������� 
     *  
     * @param sql 
     * @return 
     * @throws Exception 
     */  
	public ResultSet select(String sql) throws Exception {  
        Statement stmt = null;  
        ResultSet rs = null;  
        try {  
            stmt = conn.createStatement();  
            rs = stmt.executeQuery(sql);  
            return rs;  
        } catch (SQLException sqle) {  
            throw new SQLException("select data exception: "  
                    + sqle.getMessage());  
        } catch (Exception e) {  
            throw new Exception("System e exception: " + e.getMessage());  
        }  
  
    }  
  
    /** 
     * ���ݴ����SQL��������ݿ�����һ����¼ 
     *  
     * @param sql 
     * @throws Exception 
     */  
	public void insert(String sql) throws Exception {  
        PreparedStatement ps = null;  
        try {   
             ps = conn.prepareStatement(sql);  
             ps.executeUpdate();   
        } catch (SQLException sqle) {  
            throw new Exception("insert data exception: " + sqle.getMessage());  
        } finally {  
            try {  
                if (ps != null) {  
                    ps.close();  
                }  
            } catch (Exception e) {  
                throw new Exception("ps close exception: " + e.getMessage());  
            }  
        }  
        try {  
            if (conn != null) {  
                conn.close();  
            }  
        } catch (Exception e) {  
            throw new Exception("connection close exception: " + e.getMessage());  
        }  
    }  
  
    /** 
     * ���ݴ����SQL���������ݿ��¼ 
     *  
     * @param sql 
     * @throws Exception 
     */  
	public void update(String sql) throws Exception {  
        PreparedStatement ps = null;  
        try {  
            ps = conn.prepareStatement(sql);  
            ps.executeUpdate();  
        } catch (SQLException sqle) {  
            throw new Exception("update exception: " + sqle.getMessage());  
        } finally {  
            try {  
                if (ps != null) {  
                    ps.close();  
                }  
            } catch (Exception e) {  
                throw new Exception("ps close exception: " + e.getMessage());  
            }  
        }  
        try {  
            if (conn != null) {  
                conn.close();  
            }  
        } catch (Exception e) {  
            throw new Exception("connection close exception: " + e.getMessage());  
        }  
    }  
  
    /** 
     * ���ݴ����SQL���ɾ��һ�����ݿ��¼ 
     *  
     * @param sql 
     * @throws Exception 
     */  
	public void delete(String sql) throws Exception {   
        PreparedStatement ps = null;  
        try {  

            ps = conn.prepareStatement(sql);  
            ps.executeUpdate();  
        } catch (SQLException sqle) {  
            throw new Exception("delete data exception: " + sqle.getMessage());  
        } finally {  
            try {  
                if (ps != null) {  
                    ps.close();  
                }  
            } catch (Exception e) {  
                throw new Exception("ps close exception: " + e.getMessage());  
            }  
        }  
        try {  
            if (conn != null) {  
                conn.close();  
            }  
        } catch (Exception e) {  
            throw new Exception("connection close exception: " + e.getMessage());  
        }  
    }  
	
	
	public static void main(String[] args) {
		ConnDB connDB=new ConnDB();
		try {
			Connection connection=connDB.getConnction();
			Statement stmt=connection.createStatement();
			ResultSet rs=stmt.executeQuery("select * from person where adress LIKE \"����%\"");
			System.out.println("���ӳɹ� "+ DB_NAME);
			while(rs.next()){
				System.out.println(rs.getString(5));
			}
			connDB.closeCon(connection);
		} catch (Exception e) {
			// TODO: handle exception
			System.out.println("����ʧ�� "+ DB_NAME);
		}
	}
}

