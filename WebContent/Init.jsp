
<%@page import="java.sql.*"%>
<%@page import="webGis_Demo.ConnDB"%>
<%@page import="webGis_Demo.Person"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>

<head>
<script type="text/javascript" src="http://ajax.microsoft.com/ajax/jquery/jquery-1.4.min.js"></script>
<script type="text/javascript" src="http://api.map.baidu.com/api?v=2.0&ak=O8fpFPd6pw5VYK1uGsdMSAtL5MQRjAjs"></script>
<script type="text/javascript" src="http://api.map.baidu.com/library/Heatmap/2.0/src/Heatmap_min.js"></script>
<link rel="stylesheet" href="css/newFormcss.css"  rel="external nofollow"  type="text/css" />
<script src="http://libs.baidu.com/jquery/1.9.0/jquery.js"></script>
<script src="js/newForm.js"></script>


</head>

  <title>失踪人口信息</title>
  <meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
  <meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0, user-scalable=no">
  	<script type="text/javascript" src="http://api.map.baidu.com/library/DistanceTool/1.2/src/DistanceTool_min.js"></script>
  <style type="text/css">
    #map{
    	position: absolute;
        width:86.4%;
        height:90%;
        top:90px;
        left:261px;
        
        
    }
    #loadbg{
    	position: absolute;
        width:88%;
        height:90%;
        top:90px;
        left:260px;
        background-color: #C0C0C0;
        opacity:.5;
        z-index:1;
        display:none;
    }
    


		#container{height:500px;width:100%;}
		#r-result{width:100%;}

	#topnivi{
		position: absolute;
		 width:100%;
		 height:100px;
		 top:0;
		 left:0;
		 background-color: #44495a;
	}

    *{
        padding: 0;
        margin: 0;
    }
    html,body{
        height: 100%;
    }
    .wrap{
    position: absolute;
        width: 260px;
        height: 100%;
        background-color: #44495a;
    }
    .header{
        width: 100%;
        height: 80px;
        background-color: #44495a;
        font-size: 30px;
        color: #fff;
        text-align: center;
        line-height: 90px;
    }
    .nav{
        width:250px;
        margin: 10px 5px 0;
    }
    
    .listsingle{
    margin-bottom: 5px;
    }
    
    .listsingle h2{
            position: relative;
        padding: 15px 0;
        background-color: #3889d4;
        text-align: center;
        font-size: 16px;
        color: #fff;
        transition: .5s;
    }
    

    
    .list{
        margin-bottom: 5px;
    }
    .list h2{
        position: relative;
        padding: 15px 0;
        background-color: #3889d4;
        text-align: center;
        font-size: 16px;
        color: #fff;
        transition: .5s;
    }
    .list h2.on{
        background-color: #393c4a;
    }
    .list i{
        position: absolute;
        right: 10px;
        top: 16px;
        border: 8px solid transparent;
        border-left-color: #fff;/*triangle*/
        transform:rotate(0deg);
        transform-origin: 1px 8px;
        transition: .5s;
    }
    .list i.on{
        transform:rotate(90deg);
    }
    .hide{
        overflow: hidden;
        height: 0;
        transition: .5s;
    }
    .hide h5{
        padding: 10px 0;
        background-color: #282c3a;
        text-align: center;
        color:#fff;
        border-bottom:#42495d;
        cursor:pointer
    }
  </style>

  
  
  

  
<script>

$(document).ready(function(){
	  $("button").click(function(){

	  });
	});

	
	
</script>
	
	
	
  
</head>
<body>

<div id="topnivi">
</div>



<div class="wrap">
        <div class="header">失踪人口信息</div>
        <div class="nav">
            <ul>
                <li class="list">
                    <h2><i></i>地区数据显示</h2>
                    <div class="hide" id='dataList'>
                        <h5 id='all'>全国的数据显示</h5>
                        <h5 id='zsj'>珠三角数据显示</h5>
                        <h5 id='zx'>中西部地区数据显示</h5>
                        <h5 id='hb'>华北部数据显示</h5>
                        <h5 id='csj'>长三角数据显示</h5>
                        <h5 id='qt'>其他地区数据显示</h5>
                    </div>
                </li>
                <li class="list">
                    <h2><i></i>搜索查询</h2>
                    <div class="hide" id='queryList'>
                        <h5 id='nj'>按年龄</h5>
                        <h5 id='sg'>按失踪时身高</h5>
                        <h5 id='sj'>按失踪年份</h5>
                        <h5 id='wm'>按外貌特征</h5>
                        <h5 id='qtsql'>其他（SQL）</h5>
                    </div>
                </li>
                <li class="listsingle">
                    <h2 id='chart'><i></i>图表显示</h2>
                    <div class="hide">
                    </div>
                </li>
                
                <li class="listsingle">
                    <h2 id='shuxingbiao'><i></i>属性表</h2>
                    <div class="hide">
                    </div>
                </li>
                
                
                <li class="listsingle">
                    <h2 id='relitu'><i></i>热力图</h2>
                    <div class="hide">
                    </div>
                </li>
                
                
            </ul>
        </div>
    </div>

<div id='loadbg'><h1 style='line-height:700px;text-align:center'>正在向服务器请求数据....</h1></div>

<div id="map" ></div>




</body>

<%
	
	
  	//建立数据库连接
	ConnDB db=new ConnDB();
	Connection cn=db.getConnction();
	String TB_NAME = ConnDB.TB_NAME;
	int selectCount = 0 ;
	//"select * from personnew where adress LIKE \"广东%\""
	String sql= "select * from "+TB_NAME;
	ResultSet rs=db.select(sql);
	
	rs.last(); // 将光标移动到最后一行   
	selectCount = rs.getRow(); // 得到当前行号，即结果集记录数
	rs.beforeFirst();//移回来
	
	rs.next();
	
	%>
    
<script type="text/javascript">
	var TB_NAME = "<%=TB_NAME%>";
	var msql ="select * from "+ TB_NAME; //查询语句
    var map = new BMap.Map("map", {});                        // 创建Map实例
    map.centerAndZoom(new BMap.Point(105.000, 38.000), 5);     // 初始化地图,设置中心点坐标和地图级别
    map.enableScrollWheelZoom();                        //启用滚轮放大缩小
    //初始化地图
    var top_left_control = new BMap.ScaleControl({anchor: BMAP_ANCHOR_TOP_LEFT});// 左上角，添加比例尺
	map.addControl(top_left_control); 
	//var overView = new BMap.OverviewMapControl();
	var overViewOpen = new BMap.OverviewMapControl({isOpen:true, anchor: BMAP_ANCHOR_BOTTOM_LEFT});
	//map.addControl(overView);          //添加默认缩略地图控件
	map.addControl(overViewOpen);      //右下角，打开
	  var navigationControl = new BMap.NavigationControl({
		    // 靠左上角位置
		    anchor: BMAP_ANCHOR_TOP_LEFT,
		    // LARGE类型
		    type: BMAP_NAVIGATION_CONTROL_LARGE,
		    // 启用显示定位
		    enableGeolocation: true
		  });
		  map.addControl(navigationControl);
		  // 添加定位控件
		  	
		  var geolocationControl = new BMap.GeolocationControl({
			  anchor:BMAP_ANCHOR_BOTTOM_RIGHT,
				
		  });
		  geolocationControl.addEventListener("locationSuccess", function(e){
		    // 定位成功事件
		    var address = '';
		    address += e.addressComponent.province;
		    address += e.addressComponent.city;
		    address += e.addressComponent.district;
		    address += e.addressComponent.street;
		    address += e.addressComponent.streetNumber;
		    alert("当前定位地址为：" + address);
		  });
		  geolocationControl.addEventListener("locationError",function(e){
		    // 定位失败事件
		    alert(e.message);
		  });
		  map.addControl(geolocationControl);
	
		  
		  var myDis = new BMapLib.DistanceTool(map);	  
    //加入右键菜单
    var menu = new BMap.ContextMenu();
	var txtMenuItem = [
		{
			text:'放大',
			callback:function(){map.zoomIn()}
		},
		{
			text:'缩小',
			callback:function(){map.zoomOut()}
		},
		{
			text:'路线规划',
			callback:function(){
				 var judge = prompt("输入起点和终点和规划策略，分别以','隔开（输入'1'代表最少时间;输入'2'代表最短距离;输入'3'代表避开高速）。");
		            if (judge) {
		            	var rs = judge.split(",");
		            	if(rs.length!=3)
		            		alert("输入不合法！")
		            	return;
		            	var start = rs[0];
		            	var end = rs[1];
		            	var routePolicy = rs[2];
		            	
		            	//var routePolicy = [BMAP_DRIVING_POLICY_LEAST_TIME,BMAP_DRIVING_POLICY_LEAST_DISTANCE,BMAP_DRIVING_POLICY_AVOID_HIGHWAYS];
		            	$("#result").click(function(){
		            		map.clearOverlays(); 
		            		var i=$("#driving_way select").val();
		            		search(start,end,routePolicy[i]); 
		            		function search(start,end,route){ 
		            			var driving = new BMap.DrivingRoute(map, {renderOptions:{map: map, autoViewport: true},policy: route});
		            			driving.search(start,end);
		            		}
		            	});
		            	
		            	
		            }else{
		            	
		            	return
		            }
			}
		},
		{
			text:'测距',
			callback:function(){
				
				myDis.open()
			}  //开启鼠标测距
		}
		
	];
	for(var i=0; i < txtMenuItem.length; i++){
		menu.addItem(new BMap.MenuItem(txtMenuItem[i].text,txtMenuItem[i].callback,100));
	}
	map.addContextMenu(menu);
    
    
    <%
    	//获取请求
    	//TO-DO
    %>
    
    
    
    
	var curpoints = new Array();  									// 海量点数据
	
	var heatmapOverlay;   //热力图图层
    //数据库读取头
    var rs = "<%=rs %>"
    
    <%
    	//坐标转换
    	double longitude[] = new double[selectCount];
    	double latitude[] = new double[selectCount] ;
    	//Person person[] =new Person[selectCount];
    	int ids[] = new int[selectCount];
    	int count = 0;
    	String tmp = "";
    	while(rs.next()){
    		
    		int id = Integer.parseInt( rs.getString(11));
    		String cor = rs.getString(6);
    		ids[count] = id;
    		
    		String[] a = rs.getString(6).split(",");
    		double x=0,y=0;
    		if(a!=null){
    			x = Double.parseDouble(a[0]);
    			y = Double.parseDouble(a[1]);
    		}
    		longitude[count]=x;
    		latitude[count]=y;
    		count++;
    	}
    	rs.close();
    
    %>
    
    var  lon=new   Array();
    var lat = new Array();
    var id = new Array();
	<%   for(int i=0;i <selectCount;i++){   %>
    	    lon[ <%=i%> ]= "<%=longitude[i]%>";
    		lat[ <%=i%>] = "<%=latitude[i]%>";
    		id[<%=i%>] = "<%=ids[i]%>";
	<%   }   %>
    
	//装载海量点
    if (document.createElement('canvas').getContext) {  // 判断当前浏览器是否支持绘制海量点
        for (var i = 0; i < lon.length; i++) {
          var point = new BMap.Point(lon[i], lat[i]);
          curpoints.push(point);
          var _id =id[i]; 
          point.data = _id;
      	}
    } else {
        alert('请在chrome、safari、IE8+以上浏览器');
    }
	
	
	//绘制全国范围海量点
    function drawPoint(points){
        var options = {
                size: BMAP_POINT_SIZE_BIGGER,
                //BMAP_POINT_SIZE_BIG,BMAP_POINT_SIZE_NORMAL
                shape: BMAP_POINT_SHAPE_STAR,
                color: '#d370c3'
            }
            var pointCollection = new BMap.PointCollection(points, options);  // 初始化PointCollection
            pointCollection.addEventListener('click', function (e) {
              //alert('单击点的坐标为：' + e.point.lng + ',' + e.point.lat);  // 监听点击事件
              //alert(e.point.data);
              getMessageByLocFromDB(e.point.data,map,e)
              //alert("get!"+info);
              <% %>
            });
            //alert("绘制海量点:点数量"+points.length);
            map.clearOverlays();
            map.addOverlay(pointCollection);  // 添加Overlay
            zoomToViewPort(points);
        
	}
	
    
    drawPoint(curpoints);
    $(document).ready(function(){
    	$("#all").css("color","red");
    });

    
//    padding: 10px 0;
//    background-color: #282c3a;
//    text-align: center;
//    color:#fff;
//    border-bottom:#42495d;
//    cursor:pointer

    function resetDataShowBtn(){
    	$(document).ready(function(){
    		$(".hide h5").css("color","#fff")
    	});
    }

    
    //控制属性表
    $(document).ready(function(){
    	$('#shuxingbiao').click(function(){
    		
    		var html = "<iframe name='framename'  id='contentFram' src='./PropertyTable.jsp?sql="+msql+"'></iframe>";
    		var button ="";
				var win = new Window({ 
				    width : 1200, //宽度
				    height : 800, //高度
				    title : '属性表', //标题
				    content : html, //内容
				    isMask : false, //是否遮罩
				    buttons : button, //按钮
				    isDrag:true, //是否移动
				    });
				$("#contentFram").height(800);
				$("#contentFram").width(1200);
				//alert($("#contentFram").attr('src'))
    	})
    	
    	
    })
    
    //控制图表
    $(document).ready(function(){
	  	$('#chart').click(function(){
	    		
	    		var html = "<iframe name='framename'  id='contentFram' src='./chart.jsp?tbname="+TB_NAME+"'></iframe>";
	    		var button ="";
					var win = new Window({ 
					    width : 1200, //宽度
					    height : 800, //高度
					    title : '图表展示', //标题
					    content : html, //内容
					    isMask : false, //是否遮罩
					    buttons : button, //按钮
					    isDrag:true, //是否移动
					    });
					$("#contentFram").height(800);
					$("#contentFram").width(1200);
	    	})
    })
    
    
	//控制左侧菜单逻辑
    $(document).ready(function(){
    	 $("#dataList h5").click(function(){
    		 
    		 var id = $(this).attr("id");
    		 //如果当前不是被选中状态才会触发
			 if($(this).css("color")!="red"){
				 //ajax异步请求查询
				 sql1 = "SELECT * from "+TB_NAME+" ";
	    		 switch(id){
	    		 	case "all":
	    		 		msql =sql1; 
	    		 		break;
	    		 	case "zsj":
	    		 		msql=sql1+"WHERE "+TB_NAME+".adress LIKE \"%广东%\"";
	    		 		break;
	    		 	case "zx":
	    		 		sql11=" OR "+TB_NAME+".adress LIKE \"%山西%\"";
	    		 		sql12=" OR "+TB_NAME+".adress LIKE \"%吉林%\"";
	    		 		sql13=" OR "+TB_NAME+".adress LIKE \"%黑龙江%\"";
	    		 		sql14=" OR "+TB_NAME+".adress LIKE \"%安徽%\"";
	    		 		sql15=" OR "+TB_NAME+".adress LIKE \"%江西%\"";
	    		 		sql16=" OR "+TB_NAME+".adress LIKE \"%河南%\"";
	    		 		sql17=" OR "+TB_NAME+".adress LIKE \"%湖北%\"";
	    		 		sql18=" OR "+TB_NAME+".adress LIKE \"%湖南%\"";
	    		 		sql19=" OR "+TB_NAME+".adress LIKE \"%广西%\"";
	    		 		sql20=" OR "+TB_NAME+".adress LIKE \"%重庆%\"";
	    		 		sql21=" OR "+TB_NAME+".adress LIKE \"%四川%\"";
	    		 		sql22=" OR "+TB_NAME+".adress LIKE \"%贵州%\"";
	    		 		sql23=" OR "+TB_NAME+".adress LIKE \"%云南%\"";
	    		 		sql24=" OR "+TB_NAME+".adress LIKE \"%西藏%\"";
	    		 		sql25=" OR "+TB_NAME+".adress LIKE \"%陕西%\"";
	    		 		sql26=" OR "+TB_NAME+".adress LIKE \"%甘肃%\"";
	    		 		sql27=" OR "+TB_NAME+".adress LIKE \"%宁夏%\"";
	    		 		sql28=" OR "+TB_NAME+".adress LIKE \"%内蒙古%\"";
	    		 		sql29=" OR "+TB_NAME+".adress LIKE \"%青海%\"";
	    		 		msql=sql1+"WHERE "+TB_NAME+".adress LIKE \"%新疆%\""+sql11+sql12+sql13+sql14+sql15+sql16+sql17+sql18+sql19+sql20+sql21
	    		 		+sql22+sql21+sql22+sql23+sql24+sql25+sql26+sql27;
	    		 		break;
	    		 	case "hb":
	    		 		sql11=" OR "+TB_NAME+".adress LIKE \"%黑龙江%\"";
	    		 		sql12=" OR "+TB_NAME+".adress LIKE \"%吉林%\"";
	    		 		sql13=" OR "+TB_NAME+".adress LIKE \"%辽宁%\"";
	    		 		sql14=" OR "+TB_NAME+".adress LIKE \"%山西%\"";
	    		 		sql15=" OR "+TB_NAME+".adress LIKE \"%河北%\"";
	    		 		sql16=" OR "+TB_NAME+".adress LIKE \"%山东%\"";
	    		 		sql17=" OR "+TB_NAME+".adress LIKE \"%河南%\"";
	    		 		sql18=" OR "+TB_NAME+".adress LIKE \"%内蒙古%\"";
	    		 		sql19=" OR "+TB_NAME+".adress LIKE \"%天津%\"";
	    		 		sql20=" OR "+TB_NAME+".adress LIKE \"%北京%\"";
	    		 		msql=sql1+"WHERE "+TB_NAME+".adress LIKE \"%济南%\""+sql11+sql12+sql13+sql14+sql15+sql16+sql17+sql18+sql19+sql20;
	    		 		break;
	    		 	case "csj":
	    		 		sql11=" OR "+TB_NAME+".adress LIKE \"%江苏%\"";
	    		 		sql12=" OR "+TB_NAME+".adress LIKE \"%浙江%\"";
	    		 		sql13=" OR "+TB_NAME+".adress LIKE \"%安徽%\"";
	    		 		msql=sql1+"WHERE "+TB_NAME+".adress LIKE \"%上海%\""+sql11+sql12+sql13;
	    		 		break;
	    		 	case "sh":
	    		 		msql=sql1+"WHERE "+TB_NAME+".adress LIKE \"%上海%\"";
	    		 		break;
	    		 	case "qt":
	    		 	     var judge = prompt("输入一个城市或者地区");
	    		            if (judge) {
	    		            	msql=sql1+" WHERE "+TB_NAME+".adress LIKE \"%"+judge+"%\"";
	    		            	//alert(msql);
	    		            } else {
	    		                return false;
	    		            }
	    		            
	    		        break;
	    		 }
	    	
	    		 $(document).ready(function(){
 		 			$.ajax({
 		 				type:"GET",
 		 				url:"./zhw_query",
 		 				dataType:"json",
 		 				contentType : 'application/json;charset=utf-8',
 		 				data:{sql:msql},
 		 				beforeSend:function(XMLHttpRequest){
 		 					//alert("开始向服务器请求数据");
 		 					$("#loadbg").fadeIn("fast");
 		 				},
 		 				success:function(resultData){
 		 					//jObject = JSON.parse(resultData);
 		 					//alert(jObject);
 		 					//alert(resultData[0]['name']);
 		 					//清空当前点
 		 					curpoints.length=0
 		 					for(var i=0;i<resultData.length;i++){
 		 						var cor = resultData[i]['cor'];
 		 						var a = cor.split(",");
 		 			    		var x=0,y=0;
 		 			    		if(a!=null){
 		 			    			x = parseFloat(a[0]);
 		 			    			y = parseFloat(a[1]);
 		 			    		}
 		 						var point = new BMap.Point(x, y);
 		 						var _id =resultData[i]['id']; 
 		 				        point.data = _id;
 		 				        curpoints.push(point);
 		 					}
 		 					drawPoint(curpoints);
 		 					//重置热力图选项
 		 					$("#relitu").text("热力图");
 		 					heatmapOverlay=null;
 		 					
 		 					//alert(curpoints.length);
 		 					
 		 				},
 		 				complete:function(XMLHttpRequest,textStatus){
 		 					//alert("已经从服务器获得数据");
 		 					$("#loadbg").fadeOut("fast");
 		 				},
 		 				error:function(xhr, status, errMsg){
	    		 				alert("数据请求失败！");
	    		 			}
 		 				
 		 			});
 		 		});
				 
				 
	    	 //map.clearOverlays();
	    	 
    		 resetDataShowBtn();
    		 	//其他地区按钮不需要变红
	    		 if(id!='qt'){
	    			 $(this).css("color","red");
	    		 }
			 }
    	 }); 
    	  
    	 
    	 
    	 
    	 
    	 

    	 
    	 
    	 $("#queryList h5").click(function(){
    		 var id = $(this).attr("id");
    		 
    		 //当用户不是首次激活时触发
    		 if($(this).css("color")!="red"){
    			
    			switch(id){
    			case "nj":
        			$(document).ready(function(e){
        				//var html = "<iframe name='framename'  id='contentFram' src='./query.html'></iframe>";
        				
        				$.ajax({
        					type:"GET",
     		 				url:"./query.html",
     		 				dataType:"html",
     		 				
     		 				success:function(data,status){
     		 					//console.log(data);
     		 					
     		 					//!!!!!巨坑，jquery竟然不能直接解析html数据
     		 					var wrappedObj = $("<code></code>").append($(data));
     		 					var divNL = $("#queryNLDIV", wrappedObj);
     		 					var html = divNL.html();
     		 					
     		 					var title = $("#"+id).text()+"查询";
     	        				var button ="";
     	        				var win = new Window({ 
     	    					    width : 600, //宽度
     	    					    height : 400, //高度
     	    					    title : title, //标题
     	    					    content : html, //内容
     	    					    isMask : false, //是否遮罩
     	    					    buttons : button, //按钮
     	    					    isDrag:true, //是否移动
     	    					    });
     	    					
     	        				$("#queryNLDIV").height(400);
     	        				$("#queryNLDIV").width(400);
     	        				
     	        				$("#summitNL").click(function(){
     	        					
     	        					var year1 = $("#year1").val();
     	        					var year2 = $("#year2").val();
     	        					
     	        					var flag1 = false;
     	        					var flag2 = false;
     	        					if(!isNaN(year1)&& year1!=""){
     	        						  //输入为数字并且不为空
     	        						  flag1 = true;
     	        						}else{
     	        						  flag1 = false;
     	        					}
     	        					
     	        					if(!isNaN(year2)&& year2!=""){
   	        						  		flag2 = true;
     	        					}else{
     	        						flag2 = false;
     	        					}
     	        					
     	        					
     	        					
     	        					if(flag1&&flag2){
     	        						//数据合法,向请求数据
     	        						datesql = 'TIMESTAMPDIFF(YEAR, missingperson.birth, missingperson.missingdate)'
     	        	 		 			msql = 'select * from '+ TB_NAME+' where ' +datesql+' >='+year1+' and '+datesql+" <="+year2 
     	        						console.log("msql:  "+msql)
     	        						$.ajax({
     	        							type:"GET",
     	        	 		 				url:"./zhw_query",
     	        	 		 				dataType:"json",
     	        	 		 				contentType : 'application/json;charset=utf-8',
     	        	 		 				data:{sql:msql},
     	        	 		 				beforeSend:function(XMLHttpRequest){
     	        	 		 					//alert("开始向服务器请求数据");
     	        	 		 					$("#loadbg").fadeIn("fast");
     	        	 		 				},
     	        	 		 				success:function(resultData){
     	        	 		 				//清空当前点
     	        	 		 					curpoints.length=0
     	        	 		 					for(var i=0;i<resultData.length;i++){
     	        	 		 						var cor = resultData[i]['cor'];
     	        	 		 						var a = cor.split(",");
     	        	 		 			    		var x=0,y=0;
     	        	 		 			    		if(a!=null){
     	        	 		 			    			x = parseFloat(a[0]);
     	        	 		 			    			y = parseFloat(a[1]);
     	        	 		 			    		}
     	        	 		 						var point = new BMap.Point(x, y);
     	        	 		 						var _id =resultData[i]['id']; 
     	        	 		 				        point.data = _id;
     	        	 		 				        curpoints.push(point);
     	        	 		 					}
     	        	 		 					drawPoint(curpoints);
     	        	 		 					//重置热力图选项
     	        	 		 					$("#relitu").text("热力图");
     	        	 		 					heatmapOverlay=null;
     	        	 		 					
     	        	 		 				},
     	        	 		 				complete:function(XMLHttpRequest,textStatus){
     	        	 		 					//alert("已经从服务器获得数据");
     	        	 		 					$("#loadbg").fadeOut("fast");
     	        	 		 				},
     	        	 		 				error:function(xhr, status, errMsg){
     	        		    		 				alert("数据请求失败！");
     	        		    		 		}
     	        						})
     	        						
     	        					}else{
     	        						alert("请输入数字");
     	        					}
     	        					
     	        					
     	        					
     	        				})
     		 					
     		 				}
     		 				
     		 				
        				})	
        				
        		       //window.open('./index.html', 'new', 'width=800,height=600,location=no, toolbar=no ,resizable =yes');
        		       
        			});
    				
    				
    				break;

    			case "sg":
    				
        			$(document).ready(function(e){
        				//var html = "<iframe name='framename'  id='contentFram' src='./query.html'></iframe>";
        				
        				$.ajax({
        					type:"GET",
     		 				url:"./queryTall.html",
     		 				dataType:"html",
     		 				
     		 				success:function(data,status){
     		 					//console.log(data);
     		 					
     		 					//!!!!!巨坑，jquery竟然不能直接解析html数据
     		 					var wrappedObj = $("<code></code>").append($(data));
     		 					var divNL = $("#queryNLDIV", wrappedObj);
     		 					var html = divNL.html();
     		 					
     		 					var title = $("#"+id).text()+"查询";
     	        				var button ="";
     	        				var win = new Window({ 
     	    					    width : 600, //宽度
     	    					    height : 400, //高度
     	    					    title : title, //标题
     	    					    content : html, //内容
     	    					    isMask : false, //是否遮罩
     	    					    buttons : button, //按钮
     	    					    isDrag:true, //是否移动
     	    					    });
     	    					
     	        				$("#queryNLDIV").height(400);
     	        				$("#queryNLDIV").width(400);
     	        				
     	        				$("#summitNL").click(function(){
     	        					
     	        					var tall1 = $("#year1").val();
     	        					var tall2 = $("#year2").val();
     	        					
     	        					var flag1 = false;
     	        					var flag2 = false;
     	        					if(!isNaN(tall1)&& tall1!=""){
     	        						  //输入为数字并且不为空
     	        						  flag1 = true;
     	        						}else{
     	        						  flag1 = false;
     	        					}
     	        					
     	        					if(!isNaN(tall2)&& year2!=""){
   	        						  		flag2 = true;
     	        					}else{
     	        						flag2 = false;
     	        					}
     	        					
     	        					
     	        					
     	        					if(flag1&&flag2){
     	        						//数据合法,向数据库请求数据
     	        						datesql = 'TIMESTAMPDIFF(YEAR, missingperson.birth, CURDATE())'
     	        	 		 			msql = 'select * from '+ TB_NAME+' where ' +'tall'+' >'+tall1+' and '+'tall'+" <"+tall2 
     	        						console.log("msql:  "+msql)
     	        						$.ajax({
     	        							type:"GET",
     	        	 		 				url:"./zhw_query",
     	        	 		 				dataType:"json",
     	        	 		 				contentType : 'application/json;charset=utf-8',
     	        	 		 				data:{sql:msql},
     	        	 		 				beforeSend:function(XMLHttpRequest){
     	        	 		 					//alert("开始向服务器请求数据");
     	        	 		 					$("#loadbg").fadeIn("fast");
     	        	 		 				},
     	        	 		 				success:function(resultData){
     	        	 		 				//清空当前点
     	        	 		 					curpoints.length=0
     	        	 		 					for(var i=0;i<resultData.length;i++){
     	        	 		 						var cor = resultData[i]['cor'];
     	        	 		 						var a = cor.split(",");
     	        	 		 			    		var x=0,y=0;
     	        	 		 			    		if(a!=null){
     	        	 		 			    			x = parseFloat(a[0]);
     	        	 		 			    			y = parseFloat(a[1]);
     	        	 		 			    		}
     	        	 		 						var point = new BMap.Point(x, y);
     	        	 		 						var _id =resultData[i]['id']; 
     	        	 		 				        point.data = _id;
     	        	 		 				        curpoints.push(point);
     	        	 		 					}
     	        	 		 					drawPoint(curpoints);
     	        	 		 					//重置热力图选项
     	        	 		 					$("#relitu").text("热力图");
     	        	 		 					heatmapOverlay=null;
     	        	 		 					
     	        	 		 				},
     	        	 		 				complete:function(XMLHttpRequest,textStatus){
     	        	 		 					//alert("已经从服务器获得数据");
     	        	 		 					$("#loadbg").fadeOut("fast");
     	        	 		 				},
     	        	 		 				error:function(xhr, status, errMsg){
     	        		    		 				alert("数据请求失败！");
     	        		    		 		}
     	        						})
     	        						
     	        					}else{
     	        						alert("请输入数字");
     	        					}
     	        					
     	        					
     	        					
     	        				})
     		 					
     		 				}
     		 				
     		 				
        				})	
        				
        		       //window.open('./index.html', 'new', 'width=800,height=600,location=no, toolbar=no ,resizable =yes');
        		       
        			});
    				
    				break;

    				
    			case "sj":
    				$(document).ready(function(e){
        				//var html = "<iframe name='framename'  id='contentFram' src='./query.html'></iframe>";
        				
        				$.ajax({
        					type:"GET",
     		 				url:"./query.html",
     		 				dataType:"html",
     		 				
     		 				success:function(data,status){
     		 					//console.log(data);
     		 					
     		 					//!!!!!巨坑，jquery竟然不能直接解析html数据
     		 					var wrappedObj = $("<code></code>").append($(data));
     		 					var divNL = $("#queryNLDIV", wrappedObj);
     		 					var html = divNL.html();
     		 					
     		 					var title = $("#"+id).text()+"查询";
     	        				var button ="";
     	        				var win = new Window({ 
     	    					    width : 600, //宽度
     	    					    height : 400, //高度
     	    					    title : title, //标题
     	    					    content : html, //内容
     	    					    isMask : false, //是否遮罩
     	    					    buttons : button, //按钮
     	    					    isDrag:true, //是否移动
     	    					    });
     	    					
     	        				$("#queryNLDIV").height(400);
     	        				$("#queryNLDIV").width(400);
     	        				
     	        				$("#summitNL").click(function(){
     	        					
     	        					var year1 = $("#year1").val();
     	        					var year2 = $("#year2").val();
     	        					
     	        					var flag1 = false;
     	        					var flag2 = false;
     	        					if(!isNaN(year1)&& year1!=""){
     	        						  //输入为数字并且不为空
     	        						  flag1 = true;
     	        						}else{
     	        						  flag1 = false;
     	        					}
     	        					
     	        					if(!isNaN(year2)&& year2!=""){
   	        						  		flag2 = true;
     	        					}else{
     	        						flag2 = false;
     	        					}
     	        					
     	        					
     	        					
     	        					if(flag1&&flag2){
     	        						//数据合法,向请求数据
     	        						
    			 						msql = 'select * from '+ TB_NAME+' where YEAR(missingdate) ' + ' >='+year1+' and '+' year(missingdate)'+" <="+ year2
										
     	        						$.ajax({
     	        							type:"GET",
     	        	 		 				url:"./zhw_query",
     	        	 		 				dataType:"json",
     	        	 		 				contentType : 'application/json;charset=utf-8',
     	        	 		 				data:{sql:msql},
     	        	 		 				beforeSend:function(XMLHttpRequest){
     	        	 		 					//alert("开始向服务器请求数据");
     	        	 		 					$("#loadbg").fadeIn("fast");
     	        	 		 				},
     	        	 		 				success:function(resultData){
     	        	 		 				//清空当前点
     	        	 		 					curpoints.length=0
     	        	 		 					for(var i=0;i<resultData.length;i++){
     	        	 		 						var cor = resultData[i]['cor'];
     	        	 		 						var a = cor.split(",");
     	        	 		 			    		var x=0,y=0;
     	        	 		 			    		if(a!=null){
     	        	 		 			    			x = parseFloat(a[0]);
     	        	 		 			    			y = parseFloat(a[1]);
     	        	 		 			    		}
     	        	 		 						var point = new BMap.Point(x, y);
     	        	 		 						var _id =resultData[i]['id']; 
     	        	 		 				        point.data = _id;
     	        	 		 				        curpoints.push(point);
     	        	 		 					}
     	        	 		 					drawPoint(curpoints);
     	        	 		 					//重置热力图选项
     	        	 		 					$("#relitu").text("热力图");
     	        	 		 					heatmapOverlay=null;
     	        	 		 					
     	        	 		 				},
     	        	 		 				complete:function(XMLHttpRequest,textStatus){
     	        	 		 					//alert("已经从服务器获得数据");
     	        	 		 					$("#loadbg").fadeOut("fast");
     	        	 		 				},
     	        	 		 				error:function(xhr, status, errMsg){
     	        		    		 				alert("数据请求失败！");
     	        		    		 		}
     	        						})
     	        						
     	        					}else{
     	        						alert("请输入数字");
     	        					}
     	        					
     	        					
     	        					
     	        				})
     		 					
     		 				}
     		 				
     		 				
        				})	
        				
        		       //window.open('./index.html', 'new', 'width=800,height=600,location=no, toolbar=no ,resizable =yes');
        		       
        			});
    				
    				break;

    			case "wm":
    				 var judge = prompt("输入特征");
    		            if (judge) {
	        				var msql1 = 'select * from '+TB_NAME+" where "
	        				msql=msql1 + " `describe` like \"%"+judge+"%\" or `other` like \"%"+judge+"%\""
	        				console.log(msql)
	        				queryData(msql)
    		            }else{
    		            	return
    		            }
    				break;
    			case "qtsql":
    				 var judge = prompt("输入sql语句,不支持连接查询</Br>表名为"+TB_NAME+"</Br>字段有 `name` `sex` `birth` `tall` `adress` `cor` `describe` `other` `update_time` `imgurl` `id` `missingdate` ");
 		            if (judge) {
 		            	  
	        				queryData(judge)
 		            }else{
 		            	return
 		            }
    				
    				
    				break;
    			}
    			
			 }
    		 
    		 resetDataShowBtn();
    		 $(this).css("color","red");
    	 });
    	 
    	});
	
	
	function queryData(msql){
		$.ajax({
				type:"GET",
				url:"./zhw_query",
				dataType:"json",
				contentType : 'application/json;charset=utf-8',
				data:{sql:msql},
				beforeSend:function(XMLHttpRequest){
					//alert("开始向服务器请求数据");
					$("#loadbg").fadeIn("fast");
				},
				success:function(resultData){
				//清空当前点
					curpoints.length=0
					for(var i=0;i<resultData.length;i++){
						var cor = resultData[i]['cor'];
						var a = cor.split(",");
			    		var x=0,y=0;
			    		if(a!=null){
			    			x = parseFloat(a[0]);
			    			y = parseFloat(a[1]);
			    		}
						var point = new BMap.Point(x, y);
						var _id =resultData[i]['id']; 
				        point.data = _id;
				        curpoints.push(point);
					}
					drawPoint(curpoints);
					//重置热力图选项
					$("#relitu").text("热力图");
					heatmapOverlay=null;
					
				},
				complete:function(XMLHttpRequest,textStatus){
					//alert("已经从服务器获得数据");
					$("#loadbg").fadeOut("fast");
				},
				error:function(xhr, status, errMsg){
		 				alert("数据请求失败！");
		 		}
			})
	}
	
    
	//根据提供的地理区域或坐标获得最佳的地图视野
	function zoomToViewPort(points){
		//var view=map.getViewport();
		//var mapZoom = view.zoom;   
		//var centerPoint = view.center;
		//alert("mapzoom:"+mapZoom+",center:"+centerPoint.lat);
		//map.panTo(centerPoint);
		map.setViewport(points);
	}
    
	//判断浏览区是否支持canvas
    function isSupportCanvas(){
        var elem = document.createElement('canvas');
        return !!(elem.getContext && elem.getContext('2d'));
    }
	
    
		//详细的参数,可以查看heatmap.js的文档 https://github.com/pa7/heatmap.js/blob/master/README.md
		//参数说明如下:
		/* visible 热力图是否显示,默认为true
	     * opacity 热力的透明度,1-100
	     * radius 势力图的每个点的半径大小   
	     * gradient  {JSON} 热力图的渐变区间 . gradient如下所示
	     *	{
				.2:'rgb(0, 255, 255)',
				.5:'rgb(0, 110, 255)',
				.8:'rgb(100, 0, 255)'
			}
			其中 key 表示插值的位置, 0~1. 
			    value 为颜色值. 
	     */
	
	//热力图脚本
    $(document).ready(function(){
  	  $("#relitu").click(function(){
  		if(curpoints.length!=0 && heatmapOverlay==null){
  		    if(!isSupportCanvas()){
  		    	alert('热力图目前只支持有canvas支持的浏览器,您所使用的浏览器不能使用热力图功能~')
  		    }
  		    var pointss=new Array(); 
  		    //数据需要再次处理
  		    for(var i=0;i<curpoints.length;i++){
  		    	var obj={
  		    			"lng":curpoints[i].lng,
  		    			"lat":curpoints[i].lat,
  		    			"count":1
  		    	}
  		    	
  		    	pointss.push(obj);
  		    	//alert("adas"+pointss[0].count);
  		    	//pointss[i]= {"lng":116.418455,"lat":39.920921,"count":40};
  		    }
  		    
            var testData = {
                    max: 100,
                    data: pointss
                };
  		  	
            var judge = prompt("输入数据点的热力分析半径（默认80）",80);
            if (judge) {
            	if(isNaN(judge)){
            		alert("请输入数字");
            		return;
            	}
            	//alert(msql);
            }else{
            	return
            }
            
  		  	heatmapOverlay = new BMapLib.HeatmapOverlay({"radius":judge});
  		  
	  		map.addOverlay(heatmapOverlay);
	  		
	  		heatmapOverlay.setDataSet(testData);
	  		
	  		heatmapOverlay.show();
	  		$('#relitu').css('background-color','#393c4a')
	  		$("#relitu").text("关闭热力图");
  		}else if(heatmapOverlay!=null){
  			var s = $("#relitu").text();
  			if(s == '关闭热力图'){
  				heatmapOverlay.hide();
  				$("#relitu").text("清除热力图");
  			}else if(s == "热力图"){
  				heatmapOverlay.show();
  				$("#relitu").text("关闭热力图");
  			}else if(s=="清除热力图"){
  				heatmapOverlay.hide();
  				heatmapOverlay =null;
  				$("#relitu").text("热力图");
  		  		$('#relitu').css('background-color','#3889d4')

  			}
  		}
  		
  		
  	  });
  	});
	
	
	
	

	
    function setGradient(){
     	/*格式如下所示:
		{
	  		0:'rgb(102, 255, 0)',
	 	 	.5:'rgb(255, 170, 0)',
		  	1:'rgb(255, 0, 0)'
		}*/
     	var gradient = {};
     	var colors = document.querySelectorAll("input[type='color']");
     	colors = [].slice.call(colors,0);
     	colors.forEach(function(ele){
			gradient[ele.getAttribute("data-key")] = ele.value; 
     	});
        heatmapOverlay.setOptions({"gradient":gradient});
    }
	
    

	
    
  </script>



  
<script>
	
    function getMessageByLocFromDB(id,map,e){
    	
    	var xmlHttp; 
		// 处理Ajax浏览器兼容
	    if (window.ActiveXObject) {   
	        xmlHttp = new ActiveXObject("Microsoft.XMLHTTP");   
	    }   
	    else if (window.XMLHttpRequest) {   
	        xmlHttp = new XMLHttpRequest();   
	    } 
	     
	    var url = "./zhw?id="+id; // 使用JS中传给jsp    
	    xmlHttp.open("GET",url,false);   //配置XMLHttpRequest对象
	    
	    //设置回调函数
	    xmlHttp.onreadystatechange = function (){
	        if (xmlHttp.readyState == 4 && xmlHttp.status == 200) {
	            //var respText = xmlHttp.responseText.split("{")[1];
	            //respText = "{"+respText;
	            var respText = xmlHttp.responseText;
	           //解析json格式数据
	            var obj = eval("("+respText+")");
	           	//alert(obj['updateTime']);
	            //return respText;
	           
	        	var opts = {
	    				width : 0,     // 信息窗口宽度
	    				height: 0,     // 信息窗口高度
	    				title : "<h5>失踪信息</h5>" , // 信息窗口标题
	    				enableMessage:true//设置允许信息窗发送短息
	    			   };
	        	
	        	content = "姓名："+obj['name']+"<Br/>"
	        			  +"性别："+obj['sex']+"<Br/>"
	        			  +"生日："+obj['birth']+"<Br/>\n"
	        			  +"身高："+obj['tall']+"<Br/>"
	        			  +"坐标："+obj['cor']+"<Br/>"
	        			  +"走丢时间："+obj['missingdate']+"<Br/>"
	        			  +"走丢地址："+obj['adress']+"<Br/>"
	        			  +"描述：<h5>"+obj['describe']+"</h5>"
	        			  +"其他：<h5>"+obj['other']+"</h5><Br/>"
	        			  +"数据爬取时间："+obj['updateTime']+"<Br/>"
	        	img_src= obj['imgurl'];
	        	//var urls = ima_src.split(",");
	        	var urls = img_src.split(",");
	        	//alert(urls.length);
	        	var imgtb="";
	        	for(var i=0;i<urls.length;i++){
	        		imgtb+="<a href='"+urls[i]+"' target='_Blank'><img style='float:right,top;margin:4px'  src="+ urls[i]+ " width='139' height='139' title='失踪人口profile'/></a>"
	        	}
	        	
	        	//"<a href='"+img_src+"' target='_Blank'><img style='float:right,top;margin:4px' id='imgDemo' src="+ img_src+ " width='139' height='104' title='失踪人口profile'/></a>"
	        	content +=imgtb; 
	        	
	    		var point = new BMap.Point(e.point.lng, e.point.lat);
	    		//alert(e.point.lng)
	    		var infoWindow = new BMap.InfoWindow(content,opts);  // 创建信息窗口对象
	    		infoWindow.enableMaximize();
	    		
	    		map.openInfoWindow(infoWindow,point); //开启信息窗口
	            infoWindow.setMaxContent();
	           
	           }
	        else{
	        	//alert("调用失败! "+respText);
	           }
	    }
	    
	    xmlHttp.send(null);  // 发送请求
    }
	
	</script>  






<script>
        (function () {
            var oList = document.querySelectorAll('.list h2'),
                oHide = document.querySelectorAll('.hide'),
                oIcon = document.querySelectorAll('.list i'),
                lastIndex = 0;
            for(var i=0;i<oList.length;i++){
                oList[i].index = i;//自定义属性
                oList[i].isClick = false;
                oList[i].initHeight = oHide[i].clientHeight;
                oHide[i].style.height = '0';
                oList[i].onclick = function () {
                    if(this.isClick){
                        oHide[this.index].style.height = '0';
                        oIcon[this.index].className = '';
                        oList[this.index].className = '';
                        oList[this.index].isClick = false;
                    }
                    else{
                        oHide[lastIndex].style.height = '0';
                        oIcon[lastIndex].className = '';
                        oList[lastIndex].className = '';
                        oHide[this.index].style.height = '220px';
                        oIcon[this.index].className = 'on';
                        oList[this.index].className = 'on';
                        oList[lastIndex].isClick = false;
                        oList[this.index].isClick = true;
                        lastIndex = this.index;
                    }
                }
            }
        })();
    </script>


</body>
</html>







