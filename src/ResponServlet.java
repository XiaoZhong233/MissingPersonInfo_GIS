

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

import webGis_Demo.ConnDB;
import webGis_Demo.Person;

/**
 * Servlet implementation class ResponServlet
 */
@WebServlet("/zhw")
public class ResponServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public ResponServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		request.setCharacterEncoding("UTF-8");
		response.setContentType("application/json;charset=UTF-8");
		//response.getWriter().append("Served at: ").append(request.getContextPath());
		response.setCharacterEncoding("utf-8");
		//String lon = request.getParameter("lon"); // ����aaa.jsp���洫����test����<br>
		//String lat = request.getParameter("lat");
		int id = Integer.parseInt(request.getParameter("id"));
		System.out.println(id);
		
		
		//cor = "113.58255478654918,22.27656465424921";
		

		//��ȡ���ݿ�
		ConnDB db=new ConnDB();
		Connection cn=db.getConnction();
		int selectCount = 0 ;
		String TB_NAME = ConnDB.TB_NAME;
		//"select * from personnew where adress LIKE \"�㶫%\""
		String sql= "select * from "+TB_NAME+" where id = "+id;
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
			return;
		}
		
		if(selectCount==0) {
			System.out.println("δ��ѯ������"); 
			response.getWriter().write("δ��ѯ������");
			return;
		}else {
			System.out.println("��ѯ"+selectCount+"��������"); 
		}
		
		int count = 0;
		Person person[] =new Person[selectCount];
    	try {
			while(rs.next()){
				
				String name = rs.getString(1);
				String sex = rs.getString(2);
				String birth = rs.getString(3);
				String tall = rs.getString(4);
				String adress = rs.getString(5);
				String cor1 = rs.getString(6);
				String describe = rs.getString(7);
				String other = rs.getString(8);
				String time = rs.getString(9);
				String img_url = rs.getString(10);
				String idd = rs.getString(11);
				String misdate = rs.getString(12);
				Person p = new  Person(name,sex,birth,tall,adress,cor1,describe,other,idd,misdate);
				p.setUpdateTime(time);
				p.setImgurl(img_url);
				person[count] = p;
				System.out.println(name+cor1);
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
    	
    	
    	//д��ǰ��
    	//System.out.println(person[0].getName()); 
    	
//		response.setCharacterEncoding("UTF-8");
//    	response.getWriter().print(person[0].getName()+","+person[0].getAdress());

    	
    	PrintWriter out = response.getWriter();
    	
    	
		//��json��ʽ��������
    	Person p = person[0];
//    	String jsonResult = String.format("{\"name\":\"%s\",\"sex\":\"%s\",\"birth\":\"%s\",\"adress\":\"%s\",\"cor\":\"%s\",\"describe\":\"%s\",\"other\":\"%s\",\"updateTime\":\"%s\"��\"FLAG\":\"SUCCESS\"}",
//    			p.getName(),p.getSex(),p.getBirth(),p.getAdress(),p.getCor(),p.getDescribe(),p.getOther(),p.getUpdateTime());
    	
    	String jsonResult = String.format("{\"name\":\"%s\",\"sex\":\"%s\",\"birth\":\"%s\",\"adress\":\"%s\",\"cor\":\"%s\",\"describe\":\"%s\",\"other\":\"%s\",\"updateTime\":\"%s\",\"tall\":\"%s\",\"imgurl\":\"%s\",\"missingdate\":\"%s\"}", p.getName(),p.getSex(),p.getBirth(),p.getAdress(),p.getCor(),p.getDescribe(),p.getOther(),p.getUpdateTime(),p.getTall(),p.getImgurl(),p.getMissingdate());
    	System.out.println(jsonResult);
    	out.println(jsonResult);
    	out.flush();
        out.close();
	
		
		
		
		
	}
	
	
	
	

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
