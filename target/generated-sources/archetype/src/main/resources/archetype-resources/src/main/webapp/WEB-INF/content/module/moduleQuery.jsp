#set( $symbol_pound = '#' )
#set( $symbol_dollar = '$' )
#set( $symbol_escape = '\' )
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/common/taglibs.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML ${version} Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
	<title>Home Page</title>
	<%@ include file="/common/header.jsp" %>
</head>
<script type="text/javascript">
	${symbol_dollar}(function() {
		_function_panel_obj=${symbol_dollar}('${symbol_pound}_function_panel').panel({
			//height:600,
			border:false,
			noheader:true,
			top:0,
			left:0
		});
		_menu_table_obj = ${symbol_dollar}('${symbol_pound}_menu_table').treegrid(
						{
							title:"<s:text name='label.pm.module.list'></s:text>",
							//width:980,
							height:500,
							iconCls:'icon-save',
							url : '${symbol_dollar}{ctx}/pm/module/module!getNodes.action',
							animate : true,
							nowrap : false,
							rownumbers : true,
							collapsible : true,
							idField : 'id',
							treeField : 'id',
							frozenColumns:[[
							                {field:'id',width:150,align:'center'},
							                {field:'text',title:"<s:text name='label.pm.module.name'></s:text>",width:200,align:'center'}
							]],
							columns:[[
							          
							          {field:'path',title:"<s:text name='label.pm.module.url'></s:text>",width:200,align:'center'},
							          {field:'isLeaf',title:"<s:text name='label.pm.module.isFunctionOrModule'></s:text>",width:100,align:'center'},
							          {field:'indexPage',title:"<s:text name='label.pm.module.homepage'></s:text>",width:200,align:'center'},
							          {field:'order',title:"<s:text name='label.pm.module.order'></s:text>",width:50,align:'center'},
							          {field:'moduleStatus',title:"<s:text name='label.pm.module.status'></s:text>",width:50,align:'center'},
							          {field:'action',title:"<s:text name='label.pm.module.action'></s:text>",width:100,align:'right',
							        	  formatter:function (value,rowData,rowIndex){
							        	  		var id = rowData.id;
							        	  		var text = rowData.text;
							        	  		var funOrMod = rowData.attributes.isLeaf;   
		//							            if (row.editing){   
		//							                var s = '<a href="${symbol_pound}" onclick="saverow('+index+')">Save</a> ';   
		//							            	var c = '<a href="${symbol_pound}" onclick="cancelrow('+index+')">Cancel</a>';   
		//							            	return s+c;   
		//							    	    } else {
													//root can't be deleted or updated.
													if(id!=0){
														var e = '<img onclick="editrow('+id+')" src="${symbol_dollar}{ctx}/image/edit.gif" title="'+"<s:text name='button.common.modify'></s:text>"+'" style="cursor:hand;"/>';   
										    	        var d = '<img onclick="deleterow('+id+')" src="${symbol_dollar}{ctx}/image/delete.gif" title="'+"<s:text name='button.common.delete'></s:text>"+'" style="cursor:hand;"/>';
										    	        var a = '<img onclick="addfields('+id+')" src="${symbol_dollar}{ctx}/image/delegate.gif" title="'+"<s:text name='label.pm.module.add.field'></s:text>"+'" style="cursor:hand;"/>';
										    	        var p = '<img onclick="assignPrivilege('+id+',${symbol_escape}''+text+'${symbol_escape}')" src="${symbol_dollar}{ctx}/image/permissions.gif" title="'+"<s:text name='label.pm.module.privilege'></s:text>"+'" style="cursor:hand;"/>';
														if(funOrMod==1)
										    	        	return e+'&nbsp;'+a+'&nbsp;'+p+'&nbsp;'+d;
										    	        else
										    	        	return e+'&nbsp;'+d;
													}				   
		//							    	    }
							        	 }
								       }
							]],
							toolbar:[
							         {
							        	text:"<s:text name='button.common.add'></s:text>",
							 	        iconCls:'icon-add',
							 	        handler:function(){
							 	    		window.location='${symbol_dollar}{ctx}/pm/module/module!forInsert.action';
							 	    		return false;
							 	        }
								     }	
							]	
						});
		_field_win_obj = ${symbol_dollar}('${symbol_pound}_field_win').window({   
		    closed:true,
		    draggable:false,
		    collapsible:false,
		    minimizable:false,
		    maximizable:false,
		    modal:true,
		    shadow:true,
		    onClose:clearForm
		});
		_field_frame_obj = document.getElementById('_field_frame');
	});
	
    function  editrow(id){
    	window.location='${symbol_dollar}{ctx}/pm/module/module!forInsert.action?moduleId='+id;
    }
	function  deleterow(id){
		${symbol_dollar}.messager.confirm("Confirm","<s:text name='message.common.delete.confirm'></s:text>",function(flag){
			if(flag){
				${symbol_dollar}.ajax({
						url:'${symbol_dollar}{ctx}/pm/module/module!delete.action?moduleId='+id,
						type: 'GET',
						dataType:'json',
						error:function(){
							${symbol_dollar}.messager.alert('Error',"<s:text name='message.common.delete.failure'></s:text>",'error');
						},
						success:function(data){
							if(data.success){
								${symbol_dollar}.messager.alert('Success',data.message,'info');
								_menu_table_obj.treegrid('remove',id);
							}else{
								${symbol_dollar}.messager.alert('Error',data.message,'error');
							}
						}
					}
				);
			}
		});
    }
    function addfields(id){
    	_field_win_obj.window('open');
    	_field_frame_obj.src='${symbol_dollar}{ctx}/pm/field/field!forQuery.action?moduleId='+id;
    }
    function assignPrivilege(id,name){
        //alert('${symbol_dollar}{ctx}/pm/module/module!forAssignPrivilege.action?moduleId='+id+'&moduleName='+name);
    	window.location='${symbol_dollar}{ctx}/pm/module/module!forAssignPrivilege.action?moduleId='+id;
    }
    function getDicValueByCode(parent,code){
    	${symbol_dollar}.ajax({
  			url:'${symbol_dollar}{ctx}/common/dic/dic!getValueByCode.action?_dic_parent='+parent+'&_dic_code='+code,
			type: 'GET',
			dataType:'json',
			error:function(){
				//${symbol_dollar}.messager.alert('Error',"删除失败！",'error');
				return "";
			},
			success:function(data){
				return data._dic_value;
			}	
    	});
    }
    function clearForm(){
    	_field_frame_obj.src="about:blank";
	}
    function closeWin(){
    	_field_win_obj.window('close');
    }
	//-->
</script>
<body>
<div id="_function_panel" style="padding:5px;">
<table id="_menu_table">
</table>
</div>
<div id="_field_win" title="<s:text name='label.pm.module.field.list'></s:text>" style="width:650px;height:400px;">  
    <iframe id="_field_frame" name="_field_frame" frameborder="0" width="100%" height="100%" marginheight="0" marginwidth="0" scrolling="no"></iframe>
</div> 
</body>
</html>