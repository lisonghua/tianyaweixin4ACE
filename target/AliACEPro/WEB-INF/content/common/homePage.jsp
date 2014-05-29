<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/common/taglibs.jsp"%>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
	<title>Home Page</title>
	<%@ include file="/common/header.jsp" %>
	<link rel="stylesheet" type="text/css" href="${ctx}/js/jquery-easyui/extend/portal/portal.css">
	<script type="text/javascript" src="${ctx}/js/jquery-easyui/extend/portal/jquery.portal.js"></script>
</head>
<script>
		$(function(){
			$('#pp').portal({
				border:false,
				fit:true
				//height:600,
				//width:'auto'
			});
			$('#myCalender').calendar({   
			    fit:true,  
			    current:new Date()   
			});
			_my_message_list_grid=$('#_my_message_list').datagrid({
				//url:'${ctx}/wf/procdef/procdef!search.action',//加载表格数据的URL
				singleSelect:true,
				//height:300,
				fit:true,
				idField:'id',
				pagination:true,
				pageSize:10,
				pageNumber:1,
				pageList:[10,15],
				rownumbers:true,
				//sortName:'key,version',
			    //sortOrder:'asc,desc',
			    striped:true
			});
		});
		
		function myMessageActionFormatter(){
			return "";
		}
</script>
<body class="easyui-layout">
	<div region="center" split="true" border="false">
		<div class="homepage-bg">
		<div id="pp" style="position:relative">
			<div style="width:30%">
				<div id="panel1" title="Calendar" style="width:100%;height:180px;padding:0px;background:#fafafa;"  
				        iconCls="portlet-calendar-icon"  closable="true"  
				        collapsible="true" minimizable="false" maximizable=false>  
					<div id="myCalender"></div> 
				</div>
				<div id="panel2" title="Clock" style="text-align:center;background:#ECF9F9;width:auto;height:250px;padding:0px"  
				        iconCls="portlet-clock-icon"  closable="true"  
				        collapsible="true" minimizable="false" maximizable=false>  
				    	<embed src="http://www.respectsoft.com/onlineclock/ballclock.swf" style="width:auto;height: auto;"
						wmode="transparent"
						quality=high 
						pluginspage="http://www.macromedia.com/shockwave/download/index.cgi?P1_Prod_Version=ShockwaveFlash" 
						type="application/x-shockwave-flash" wmode="transparent"></embed>
			    </div>  
				<div id="myWeather" title="Weather" style="width:auto;height:250px;padding:0px;background:#fafafa;"  
				        iconCls="portlet-weather-icon"  closable="true"  
				        collapsible="true" minimizable="false" maximizable=false>
					<iframe src=http://weather.china.com.cn/city/54662.html 
					id=city_frame_weather 
					height=100% width=100% 
					scrolling=no 
					marginheight=0 
					frameborder=0>
					</iframe> 
<!--						<iframe src="http://m.weather.com.cn/m/pn12/weather.htm " width="100%" height="100%" marginwidth="0" marginheight="0" hspace="0" vspace="0" frameborder="0" scrolling="no"></iframe>-->
				</div>
			</div>
			<div style="width:70%">
				<div id="myTask" title="My Task" style="width:auto;height:300px;padding:0px;background:#fafafa;"  
				        iconCls="portlet-task-icon"  closable="true"  
				        collapsible="true" minimizable="false" maximizable=false>
					<%@ include file="portlet/myTask.jsp" %>
				</div>
			    <div id="myMessage" title="My Massage" style="width:auto;height:300px;padding:0px;background:#fafafa;"  
				        iconCls="portlet-message-icon"  closable="true"  
				        collapsible="true" minimizable="false" maximizable=false>
				      <table id="_my_message_list">
						<thead>
							<tr>
								<th field="subject" width="100" align="middle" sortable="true">Subject</th>
								<th field="sendDate" width="100" align="middle" sortable="true">Date</th>
								<th field="sender" width="100" align="middle" sortable="true">Sender</th>
								<th field="action" width="100" align="middle" formatter="myMessageActionFormatter"><s:text name='label.sm.common.action'></s:text></th>
							</tr>
						</thead>
					</table>  
				</div>
			</div> 
			</div>
		</div>
		</div>
	</div>
</body>
</html>