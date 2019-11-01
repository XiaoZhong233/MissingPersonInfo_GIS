<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
 <%@page import="java.io.PrintWriter"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">

<%
request.setCharacterEncoding("utf-8");
String TB_NAME = request.getParameter("tbname");
%>

    <!-- 引入 ECharts 文件 -->
<script src="https://cdn.bootcss.com/echarts/4.2.1-rc1/echarts-en.common.js"></script>

<style>
    #loadbg{
    	position: absolute;
        width:100%;
        height:100%;
        opacity:.5;
        z-index:10;
        display:none;
    }
    
     style="width: 600px;height:400px;"

</style>

<script type="text/javascript" src="http://ajax.microsoft.com/ajax/jquery/jquery-1.4.min.js"></script>

<script>
function query(url,msql,callback){
	$.ajax({
		type:"GET",
		url:"./"+url,
		dataType:"json",
		contentType : 'application/json;charset=utf-8',
		data:{sql:msql},
		beforeSend:function(XMLHttpRequest){
			//alert("开始向服务器请求数据");
			$("#loadbg").fadeIn("fast");
		},
		success:function(resultData){	
			callback(resultData)
		},
		complete:function(XMLHttpRequest,textStatus){
			//alert("已经从服务器获得数据");
			$("#loadbg").fadeOut("fast");
		},
		error:function(xhr, status, errMsg){
 			alert("数据请求失败！");
 		}
	}
	)
	
}

</script>

<title>图表</title>
</head>
<body>

<div>
<select id="mySelect">  
　　<option value="1" selected="selected">各省失踪人口数量汇总</option>  
　　<option value="2" >各省男性失踪人口汇总</option>  
　　<option value="3">各省女性失踪人口汇总</option>
	<option value="4">各省儿童失踪人口汇总（按出生日期到失踪日期）</option>  
		<option value="5">各省上个世纪90年代失踪人口汇总</option> 
			<option value="6">各省2000年到2010年失踪人口汇总</option>
			<option value="7">各省2010年到现在失踪人口汇总</option>
</select>


<select id="chartType">  
　　<option value="条形图" selected="selected" >条形图</option>  
　　<option value="折线图">折线图</option>  
　　<option value="饼图">饼图</option>  
</select>


	<button id='submit'>显示到地图上</button>

</div>


<div id='loadbg'><h1 style='line-height:700px;text-align:center'>正在向服务器请求数据....</h1></div>


<div id="main" style="width: 100%;height:700px;"></div>

<script type="text/javascript">

var tb_name = '<%=TB_NAME%>'
var myChart = echarts.init(document.getElementById('main'));
</script>


<script>

var msql="select province, COUNT(*) from "+tb_name+" GROUP BY province ";
drawProvinceData(msql);


$(document).ready(function(){
	$('#submit').click(function(){
		$.ajax({
				
		}
		
		)
	})
})


//生成数据图
function genProvincedata(type,data){
	
	myChart.setOption({
	    title: {
	        text: '各省失踪人口汇总',
	        subtext:'人数'
	    },
	    tooltip: {},
	    legend: {
	    	 orient: 'vertical',
             x: 'right',
             icon:"circle",
	        data:['数量']
	    },
	    xAxis: {
	        data: []
	    },
	    yAxis: {},
	    series: [{
	        name: '数量',
	        type: 'bar',
	        data: []
	    }]
	});
	
	var provinces = new Array();
	var counts = new Array();
	
	for(var i=0;i<data.length;i++){
		var province = data[i]['province'];
		var count = data[i]['count'];
		provinces.push(province);
		counts.push(count);
	}
	
	switch(type){
		case "条形图":
			   // 填入数据
		    myChart.setOption({
		        xAxis: {
		            data: provinces
		        },
		        series: [{
		            // 根据名字对应到相应的系列
		            name: '数量',
		            type:'bar',
		            data: counts 
		        }
		        
		        ]
		    });
			break;
		case "折线图":
			   // 填入数据
		    myChart.setOption({
		        xAxis: {
		            data: provinces
		        },
		        series: [{
		            // 根据名字对应到相应的系列
		            name: '数量',
		            type:'line',
		            data: counts 
		        }
		        
		        ]
		    });
			
			break;
		case "饼图":
			
			pieData = new Array()
			
			for(var i=0;i<data.length;i++){
				var o = {'name':provinces[i],'value':counts[i]}
				pieData.push(o);
			}
			
		    myChart.setOption({
		 
		        series: [{
		            // 根据名字对应到相应的系列
		            name: '数量',
		            type:'pie',
		            data: pieData ,
	       
		        },
		        
		        ]
		    });
			
			break;
	}
}

function drawProvinceData(msql){
		
	query('QueryProvinceGroup',msql,function(data){
		//alert("success");
		//console.log(msql)
		console.log(data);
		var chartType=$("#chartType").children('option:selected').val();//这就是selected的值
		genProvincedata(chartType,data);
	});
	
}

$(document).ready(function(){
	$('#chartType').change(function(){
		var selectValue = $('#mySelect').children('option:selected').val()
		switch(selectValue){
		case "1":
			drawProvinceData(msql)
			break;
		case "2":
			drawProvinceData(msql)
			break;
		case "3":
			drawProvinceData(msql)
			break;
		case "4":
			drawProvinceData(msql)
			break;
		case "5":
			drawProvinceData(msql)
			break;
		case "6":
			drawProvinceData(msql)
			break;
		case "7":
			drawProvinceData(msql)
			break;
		}
	})
})

$(document).ready(function(){
	$('#mySelect').change(function(){
	　　var selectValue=$(this).children('option:selected').val();//这就是selected的值
		if(selectValue == 1){
            //myChart.clear();            //清空原来的图表
			msql = "select province, COUNT(*) from "+tb_name+" GROUP BY province "
			drawProvinceData(msql)
			
		}
	
		if(selectValue == 2){
			msql = "select province, COUNT(*) from "+tb_name+ " where sex like '%男%' " +" GROUP BY province "
			drawProvinceData(msql)
		}
		
		if(selectValue == 3){
			msql = "select province, COUNT(*) from "+tb_name+ " where sex like '%女%' " +" GROUP BY province "
			drawProvinceData(msql)
		}
		
		if(selectValue == 4){
			datesql = 'TIMESTAMPDIFF(YEAR, missingperson.birth, missingperson.missingdate)'
		 	msql = 'select province, COUNT(*) from '+ tb_name+' where ' +datesql+' >'+0+' and '+datesql+" <"+15 +" GROUP BY province "
		 	console.log(msql);
		 	drawProvinceData(msql)
		}
		
		if(selectValue == 5){
		 	msql = 'select province, COUNT(*) from '+ tb_name+' where YEAR(missingdate) ' + ' >='+1000+' and '+' year(missingdate)'+" <="+ 2000 +" GROUP BY province "
		 	console.log(msql);
		 	drawProvinceData(msql)
		}
		
		if(selectValue == 6){
		 	msql = 'select province, COUNT(*) from '+ tb_name+' where YEAR(missingdate) ' + ' >='+2000+' and '+' year(missingdate)'+" <="+ 2010 +" GROUP BY province "
		 	console.log(msql);
		 	drawProvinceData(msql)
		}
		
		if(selectValue == 7){
		 	msql = 'select province, COUNT(*) from '+ tb_name+' where YEAR(missingdate) ' + ' >='+2010+' and '+' year(missingdate)'+ " <=" + ' YEAR(NOW()) ' +" GROUP BY province "
		 	console.log(msql);
		 	drawProvinceData(msql)
		}
	})
})
</script>






</body>
</html>