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
 * Servlet implementation class QueryServlet
 */
@WebServlet(description = "以json返回多个查询数据", urlPatterns = { "/zhw_query" })
public class QueryServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public QueryServlet() {
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
	     
	     Person[] persons = queryDb(sql);
	     if(persons==null) {
	    	 return;
	     }
	     
	     System.out.println("QueryServlet:查询到数据 ,"+persons.length+"条数据");
	     //System.out.println(persons[0].toString());
	     String array = JsonHelper.convertObject(persons);
	     //System.out.println("strArray:"+array);
	     PrintWriter out = response.getWriter();
	     out.println(array);
	     out.flush();
	     out.close();
	     
	}

	
	private Person[] queryDb(String sql) {
		//读取数据库
		ConnDB db=new ConnDB();
		Connection cn=db.getConnction();
		int selectCount = 0 ;
		ResultSet rs = null;
		

		
		try {
			rs=db.select(sql);
			rs.last(); // 将光标移动到最后一行   
			selectCount = rs.getRow(); // 得到当前行号，即结果集记录数
			rs.beforeFirst();//移回来
			//rs.next();		
		}catch (Exception e) {
			// TODO: handle exception
			System.out.println("查询数据库失败");
			return null;
		}
		
		if(selectCount==0) {
			System.out.println("未查询到数据");
			return null;
		}else {
			//System.out.println("查询"+selectCount+"到条数据"); 
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
				String id = rs.getString(11);
				String misdate = rs.getString(12);
				Person p = new  Person(name,sex,birth,tall,adress,cor1,describe,other,id,misdate);
				p.setUpdateTime(time);
				p.setImgurl(img_url);
				person[count] = p;
				//System.out.println(name+cor1);
				count++;
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			System.out.println("查询数据库失败2");
		}
    	
    	//关闭数据库连接
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

    	
    	return person;
    	
    	
	}
	
	
	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
		
	     

		
		
	}

}
