package webGis_Demo;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import net.sf.json.JSONArray;

/**
 * Servlet implementation class QueryProvinceGroup
 */
@WebServlet("/QueryProvinceGroup")
public class QueryProvinceGroup extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public QueryProvinceGroup() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		//response.getWriter().append("Served at: ").append(request.getContextPath());
		request.setCharacterEncoding("utf-8");    
	     response.setCharacterEncoding("utf-8");
	     String sql = request.getParameter("sql");
	     System.out.println(sql);
	     PrintWriter out = response.getWriter();
	     out.println(getJson(sql));
	}
	
	
	//����json�ַ���
	private String getJson(String sql) {
		//��ȡ���ݿ�
		ConnDB db=new ConnDB();
		Connection cn=db.getConnction();
		int selectCount = 0 ;
		ResultSet rs = null;
		
		
		try {
			rs=db.select(sql);
			rs.last(); // ������ƶ������һ��   
			selectCount = rs.getRow(); // �õ���ǰ�кţ����������¼��
			rs.beforeFirst();//�ƻ���
			//rs.next();		
		}catch (Exception e) {
			// TODO: handle exception
			System.out.println("��ѯ���ݿ�ʧ��");
			return null;
		}
		
		if(selectCount==0) {
			System.out.println("δ��ѯ������");
			return null;
		}else {
			//System.out.println("��ѯ"+selectCount+"��������"); 
		}
		
		int count = 0;
		ProviceGroupBy[] pg = new ProviceGroupBy[selectCount];
		try {
			while(rs.next()){
			
			
				String province = rs.getString(1);
				String pcount = rs.getString(2);
				ProviceGroupBy p = new ProviceGroupBy(province, pcount);
				pg[count] = p;
				//System.out.println(name+cor1);
				count++;
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			System.out.println("��ѯ���ݿ�ʧ��2");
		}
		
		//�ر����ݿ�����
    	try {
			rs.close();
			db.closeCon(cn);
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
    	
    	return JsonHelper.convertObject(pg);
		
		
	}
	
	
	

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
