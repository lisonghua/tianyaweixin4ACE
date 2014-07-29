#set( $symbol_pound = '#' )
#set( $symbol_dollar = '$' )
#set( $symbol_escape = '\' )
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/common/taglibs.jsp" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML ${version} Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
	<title></title>
	<%@ include file="/common/header.jsp" %>
</head>
<script type="text/javascript">
<!--
${symbol_dollar}(function(){
	_list_panel_obj=${symbol_dollar}('${symbol_pound}_list_panel').panel({
			//height:600,
			border:false,
			noheader:true,
			top:0,
			left:0
		});
	_list_grid_obj=${symbol_dollar}('${symbol_pound}_list_table').datagrid({
		title:"<s:text name='lable.wf.process.definition.table.title'></s:text>",
		url:'${symbol_dollar}{ctx}/wf/procdef/procdef!search.action',//加载表格数据的URL
		singleSelect:true,
		height:500,
		idField:'id',
		pagination:true,
		pageSize:15,
		pageNumber:1,
		pageList:[10,15],
		rownumbers:true,
		sortName:'key,version',
	    sortOrder:'asc,desc',
	    striped:true,
	    toolbar:[{
	        text:'<s:text name="button.common.add"></s:text>',
	        iconCls:'icon-add',
	        handler:function(){
				window.open("${symbol_dollar}{ctx}/wf/procdef/procdef!forDefinition.action","designer","top=0,left=0,width=1450px,height=750px,directories=0,menubar=0,resizable=0,status=0,titlebar=0,toolbar=0");
		    }
	    },'-',{
	    	text:"<s:text name='lable.wf.process.definition.export.bt.title'></s:text>",
	        iconCls:'icon-upload',
	        handler:function(){
	    		_wf_diagram_win_obj.window('open');
		    }
		}]
	});
	_wf_diagram_win_obj = ${symbol_dollar}('${symbol_pound}_wf_diagram_win').window({   
	    closed:true,
	    draggable:false,
	    collapsible:false,
	    minimizable:false,
	    maximizable:false,
	    modal:true,
	    shadow:true,
	    resizable:true
	});
	${symbol_dollar}('${symbol_pound}importProcessDefXmlForm').ajaxForm({
		dataType:'xml',
		resetForm:true,
		success:function(responseText, statusText, xhr, jqForm){
			var result = ${symbol_dollar}(responseText);
			var success = result.find("body").find("pre").text();
			if(success == "true"){
				_list_grid_obj.datagrid('reload');
	            ${symbol_dollar}.messager.alert("<s:text name='label.common.success'></s:text>","<s:text name='message.wf.process.definition.import.success'></s:text>","info");
	    	}else{
	    		${symbol_dollar}.messager.alert("<s:text name='label.common.error'></s:text>","<s:text name='message.wf.process.definition.import.fail'></s:text>","error");
	        }
		}
		
	});
});

function  editProcessDef(id,name){
	//window.showModalDialog("${symbol_dollar}{ctx}/wf/procdef/procdef!forDefinition.action?procDefId="+id,window,"dialogHeight:600px;dialogWidth:800px;center:yes;help:no;scroll:no;");
	window.open("${symbol_dollar}{ctx}/wf/procdef/procdef!forDefinition.action?procDefId="+id+"&procDefName="+name,"designer","top=0,left=0,width=1450px,height=750px,directories=0,menubar=0,resizable=0,status=0,titlebar=0,toolbar=0");
}

function  viewProcDiag(id,name){
	//_wf_diagram_win_obj.window('open');
	//_wf_diagram_win_obj.window('refresh','${symbol_dollar}{ctx}/wf/procdef/procdef!forDiagram.action?id='+id);
}
function exportProceDef(id,obj){
	obj.href="${symbol_dollar}{ctx}/wf/procdef/procdef!exportProcessDef.action?procdefId="+id;
}
//输出每一行末尾的操作按钮
function actionFormatter(value,rowData,rowIndex){
	var id = rowData.id;
	var name = rowData.name;
	var e = '<img onclick="editProcessDef(${symbol_escape}''+id+'${symbol_escape}',${symbol_escape}''+name+'${symbol_escape}')" src="${symbol_dollar}{ctx}/image/edit.gif" title="'+"<s:text name='button.common.modify'></s:text>"+'" style="cursor:hand;"/>';   
    var exp = '<a href="${symbol_pound}" onclick="exportProceDef(${symbol_escape}''+id+'${symbol_escape}',this)"><img border="0px" src="${symbol_dollar}{ctx}/image/download.png" title="'+"<s:text name='lable.wf.process.definition.export.bt.title'></s:text>"+'" style="cursor:hand;"/></a>';
    return e+'&nbsp;'+exp;
}
//点击查询按钮的操作函数
function searchByFilter(){
	var name=document.getElementById("filter_EQS_name").value;
	var version=document.getElementById("filter_EQS_version").value;
	_list_grid_obj.datagrid('reload',{
		filter_EQS_name:name,
		filter_EQI_version:version
	});
}
//-->
</script>
<body>
<div id="_list_panel" style="padding:5px;">
<!--***************************查询部分开始*************************************-->
<!--
查询操作符规则如下：
	属性比较类型：EQ(=), LIKE(like), LT(<), GT(>), LE(<=), GE(>=)
	属性数据类型：S(String.class), I(Integer.class), L(Long.class), N(Double.class), D(Date.class), B(Boolean.class)
-->
	<div id="filter">
	<table border="0">
		<tr>
			<td><s:text name='lable.wf.process.definition.name'></s:text>:</td>
			<td><input type="text" name="filter_EQS_name" value="" size="9"/></td>
			<td><s:text name='lable.wf.process.definition.version'></s:text>:</td>
			<td><input type="text" name="filter_EQS_version" value="" size="9"/></td>
			<td><a href="${symbol_pound}" class="easyui-linkbutton" iconCls="icon-search" onclick="searchByFilter();"><s:text name='button.common.search'></s:text></a></td>
		</tr>
	</table>
	</div>
<!--***************************查询部分结束*************************************-->
<!--***************************表格部分开始*************************************-->
<div id="content">
<table id="_list_table">
	<thead>
		<tr>
			<th field="category" width="200" align="middle" sortable="true"><s:text name='lable.wf.process.definition.category'></s:text></th>
			<th field="name" width="200" align="middle" sortable="true"><s:text name='lable.wf.process.definition.name'></s:text></th>
			<th field="key" width="200" align="middle" sortable="true"><s:text name='lable.wf.process.definition.key'></s:text></th>
			<th field="version" width="50" align="middle" ><s:text name='lable.wf.process.definition.version'></s:text></th>
			<th field="action" width="100" align="middle" formatter="actionFormatter"><s:text name='label.sm.common.action'></s:text></th>
		</tr>
	</thead>
</table>
</div>
<!--***************************表格部分结束*************************************-->
</div>
<div id="_wf_diagram_win" href="" title="<s:text name='lable.wf.process.definition.import.window.title'></s:text>" style="width:700px;height:100px;">  
   	<form id="importProcessDefXmlForm" action="${symbol_dollar}{ctx}/wf/procdef/procdef!importProcessDef.action" method="post" enctype="multipart/form-data">
   		<table>
   			<tr>
   				<td align="center"><input id="processDefXmlFile" size="80" type="file" name="processDefXmlFile"/><input type="submit" value="<s:text name='button.wf.process.definition.import'></s:text>"/></td>
   			</tr>
   		</table>
   	</form>
</div> 
</body>
</html>
