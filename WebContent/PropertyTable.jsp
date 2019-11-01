<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
    <%@page import="java.sql.*"%>
<%@page import="webGis_Demo.ConnDB"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<script type="text/javascript" src="http://ajax.microsoft.com/ajax/jquery/jquery-1.4.min.js"></script>
<link type="text/css" rel="stylesheet" href="tablecss.css"/>

<%
request.setCharacterEncoding("utf-8");
String SQL = request.getParameter("sql");
%>

<title>属性表</title>
</head>
<body>
<script type="text/javascript">

var sql = '<%=SQL%>'

$.ajax(function(){
	
})


</script>


<%
	ConnDB connDB=new ConnDB();
	Connection connection=connDB.getConnction();
	String sql=SQL;
	sql = "select * from missingperson";
	ResultSet rs=connDB.select(sql);
 %>
 
 
 
 <div align="center">
 <font size="4"><strong> 失踪人口信息：</strong><br>  
        下面的表格就是查询结果：
         </font><br> 
         </div>
          
 <div class="table_div">
		<!-- 导航栏部分 -->
		<div class="div_clear">
  			<div class="left_top"></div>
  			<div class="center_top">
  				<div style="float:left">
  				<img src="./tab/images/tb.gif" width="16px" height="16px" style="vertical-align:middle"/>
  				<span style="font-weight:bold">你当前的位置</span>：[失踪人口信息]-[失踪人口信息表]
 		 		</div>
 		 		<div style="float:right;padding-right:50px">
 		 		<img width='16' height='16' src="./tab/images/query.png" style="vertical-align:middle"/>
					
 		 		</div>
 		 		
		 		<div style="float:right;padding-right:50px">
		  			<img width='16' height='16' src="./tab/images/add.gif" style="vertical-align:middle"/>
					
		  		</div>
  			</div>
  			<div class="right_top"></div>
  		</div>
  		<!-- 导航栏部分结束 -->
  		<!-- 表格部分 -->
  		
  		<div class="div_clear">
  			<div class="left_center"></div>
  			
  				<!-- 表格内容块 -->
  			 	<div class="center_center">
  			 		  <div class="table_content">
  			 		  	<table cellspacing="0px" cellpadding="0px">
  			 		  		<!-- 表头 -->
  			 		  		<thead>
  			 		  			  <tr>
  									<th width="16%">姓    名</th>
  									<th width="16%">性    别</th>
  									<th width="16%">地    址</th>
  									<th width="16%">描    述</th>
  									<th width="16%">识别编号</th>
  									<th width="20%" style="border-right:none">操作</th>
  								  </tr>
  			 		  		</thead>
  			 		  		<!-- 表体 -->
  			 		  		<tbody>
  			 		  			
					  			<%
					  				int count=0;
					        	  		while(rs.next()){
					        	  			out.print("<tr>");  
					                        out.print("<td>" + rs.getString(1).toString()+ "</td>");  
					                        out.print("<td>" + rs.getString(2).toString() + "</td>");  
					                        out.print("<td>" + rs.getString(5).toString() + "</td>");  
					                        out.print("<td>" + rs.getString(7).toString() + "</td>");
					                        out.print("<td>" + rs.getString(11).toString() + "</td>");
					                        out.print("<td width='20%' style='border-right:none'><img width='16' height='16' src=\"./tab/images/delete.gif\" ><a href=Delete.jsp?id="+rs.getString(11) + " onclick=\"return window.confirm('是否确定删除？')\" >删除</a>"); 
					                        out.print("<img width='16' height='16' src=\"./tab/images/edit.gif\" > <a href=Update.jsp?id="+rs.getString(11) + " onclick=\"return window.confirm('是否确定编辑？')\" >编辑</a></td>"); 
					                        out.print("</tr>");
					                        count++;
					        	  		}
					        	 
					        	%>
  			 		  		<!-- 表尾 -->
  			 		  		<tfoot>
  			 		  			
  			 		  		</tfoot>
  			 		  	</table>
  			 		  		
  			 		  </div>
  			 	</div>
  			 	
  			 	<div class="right_center"></div>
  		</div>
  		<!-- 底部框 -->
  		<div class="div_clear">
  			<div class="left_bottom"></div>
  			<div class="center_bottom">
  				<span>&nbsp;&nbsp;共有<%=count %>条记录，当前第 1/1 页</span>
  				<div style="float:right;padding-right:30px">
  					 <input type="button" value="首页"/>
  				 	 <input type="button" value="上页"/>
   					 <input type="button" value="下页"/>
				     <input type="button" value="尾页"/>
   					 <span>跳转到</span>
   					 <input type="text" size="1"/>
   					 <input type="button" value="跳转"/>
  				</div>
  			</div>
  			<div class="right_bottom"></div>	
  		</div>
  	</div>
 
 <%
	if (rs != null) {  
  	  rs.close();  
	}  	
 %>



</body>
</html>