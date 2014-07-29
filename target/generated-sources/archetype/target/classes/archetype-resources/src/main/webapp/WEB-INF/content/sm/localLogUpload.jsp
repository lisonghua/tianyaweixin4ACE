#set( $symbol_pound = '#' )
#set( $symbol_dollar = '$' )
#set( $symbol_escape = '\' )
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/common/taglibs.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML ${version} Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<title></title>
<%@ include file="/common/header.jsp"%>
<link href="${symbol_dollar}{ctx}/js/uploadify/themes/default.css" type="text/css"
	rel="stylesheet" />
<link href="${symbol_dollar}{ctx}/js/uploadify/themes/uploadify.css" type="text/css"
	rel="stylesheet" />
<script src="${symbol_dollar}{ctx}/js/uploadify/jquery.uploadify.v2.1.4.js"
	type="text/javascript"></script>
<script src="${symbol_dollar}{ctx}/js/uploadify/swfobject.js" type="text/javascript"></script> 
</head>
<script type="text/javascript">
var serverId=${symbol_dollar}{serverId};
	${symbol_dollar}(function() {
		/*
		_files_panel_obj = ${symbol_dollar}('${symbol_pound}fileQueue').panel( {
			width: 400,
			height: 300
		});
		*/
		${symbol_dollar}("${symbol_pound}uploadify").uploadify( {
			id : 'uploadify',
			uploader : '${symbol_dollar}{ctx}/js/uploadify/uploadify.swf',
			script : '${symbol_dollar}{ctx}/upload',
			buttonText:"<s:text name='button.sm.ds.browse'></s:text>",
			cancelImg : '${symbol_dollar}{ctx}/js/uploadify/images/cancel.png',
			//buttonImg : '${symbol_dollar}{ctx}/image/browseButton.png',   
			//folder : 'local-log/${symbol_dollar}{serverId}',
			//scriptData:{parentDir:'local-log',subDir:'${symbol_dollar}{serverId}'},
			method:'GET',
			queueID : 'fileQueue',
			auto : false,
			//multi : true,
			wmode : 'transparent',
			//simUploadLimit : 3,
			//sizeLimit:,
			fileExt : '*.xml;*.zip',
			fileDesc : "<s:text name='lable.sm.ds.upload.fileFormat'></s:text>(*.xml;*.zip)",
			//hideButton : true,
			//displayData:'speed',
			onSelect:function(event, ID, fileObj){
				return true;
			},
			onAllComplete : function(event, data) {
				${symbol_dollar}('${symbol_pound}result').html(data.filesUploaded + "<s:text name='message.sm.ds.upload.fileCount'></s:text>");
			}
		});
		dirTreeObj=${symbol_dollar}('${symbol_pound}dirTree').tree({
			url:'${symbol_dollar}{ctx}/sm/appserver/appserver!createDirTree.action',
			animate:true,
			onClick:function(node){
				//alert(${symbol_dollar}(this).tree('isLeaf',node.target));
			},
			onDblClick:function(node){
			}
		});
		dirTreeObj.bind('contextmenu',function(e){
			//dirTreeObj.tree('select',e.target);
			var node = dirTreeObj.tree('getSelected');
			if(node!=null){
				${symbol_dollar}('${symbol_pound}treeContextMenu').menu('show', {
					left: e.pageX,
					top: e.pageY
				});
			}
			return false;
		});
	});
function uploadFile(){
	${symbol_dollar}('${symbol_pound}uploadify').uploadifySettings('scriptData',{parentDir:'local-log',subDir:'${symbol_dollar}{serverId}'});
	${symbol_dollar}('${symbol_pound}uploadify').uploadifyUpload();
}
function cancelUpload(){
	${symbol_dollar}('${symbol_pound}uploadify').uploadifyClearQueue();
}
function browseFile(){
	//${symbol_dollar}('${symbol_pound}uploadify').trigger('click');
	//${symbol_dollar}('${symbol_pound}uploadify').trigger('uploadifySelect');
}
function deleteNode(){
	var node = dirTreeObj.tree('getSelected');
	if(!dirTreeObj.tree('isLeaf',node.target)){
		${symbol_dollar}.messager.alert("<s:text name='label.common.error'></s:text>","<s:text name='message.sm.ds.tree.deleteLeaf'></s:text>","error");
	}else{
		${symbol_dollar}.ajax({
  			url:"${symbol_dollar}{ctx}/sm/appserver/appserver!deleteLog.action",
			type: 'POST',
			data:{
  					path:node.id
    		},
			dataType:'json',
			error:function(){
    			${symbol_dollar}.messager.alert("<s:text name='label.common.error'></s:text>","<s:text name='message.common.save.failure'></s:text>","error");
				return "";
			},
			success:function(data){
    			if(data.result){
    				var node = dirTreeObj.tree('getSelected');
    				var parent = dirTreeObj.tree('getParent',node.target);
    				dirTreeObj.tree('reload',parent.target);
                    ${symbol_dollar}.messager.alert("<s:text name='label.common.success'></s:text>","<s:text name='message.common.delete.success'></s:text>","info");
            	}else{
            		${symbol_dollar}.messager.alert("<s:text name='label.common.error'></s:text>","<s:text name='message.common.delete.failure'></s:text>","error");
                }
			}	
    	});
	}
}
function refreshNode(){
	var node = dirTreeObj.tree('getSelected');
	if(!dirTreeObj.tree('isLeaf',node.target)){
		dirTreeObj.tree('reload',node.target);
	}else{
		${symbol_dollar}.messager.alert("<s:text name='label.common.error'></s:text>","<s:text name='message.sm.ds.tree.refreshLeaf'></s:text>","error");
	}
}
function goBack(){
	window.location='${symbol_dollar}{ctx}/sm/appserver/appserver!forQuery.action';
}
function analyzeLog(){
	window.location='${symbol_dollar}{ctx}/sm/appserver/appserver!forAnalyze.action?serverId=${symbol_dollar}{serverId}';
}
	//-->
</script>
<body class="easyui-layout" style="overflow-y: hidden" scroll="no">
	<div region="west" split="true" title="" style="width:750px;padding:5px">
		<table style="width: 100%;">
			<tr>
				<td align="center"><input type="file" name="uploadify" id="uploadify" /></td>
			</tr>
			<tr>
			<td align="center"><div id="fileQueue" style="width: 700px;height: 200px;padding:5px;border:1px solid ${symbol_pound}99BBE8;"></div></td>
			</tr>
			<tr>
				<td align="center">
					<!-- <a class="easyui-linkbutton" href="javascript:browseFile()">浏览</a> -->
					<a class="easyui-linkbutton" href="javascript:uploadFile()"><s:text name='button.sm.ds.start.upload'></s:text></a>
					<a class="easyui-linkbutton" href="javascript:cancelUpload()"><s:text name='button.sm.ds.cancel.upload'></s:text></a>
					<a class="easyui-linkbutton" href="javascript:analyzeLog()"><s:text name='button.sm.ds.analyze.log'></s:text></a>
					<a class="easyui-linkbutton" href="javascript:goBack()"><s:text name='button.common.return'></s:text></a>
				</td>
			</tr>
			<tr>
				<td align="center"><span id="result" style="font-size: 13px; color: red"></span></td>
			</tr>
		</table>
		<!-- <div id="fileQueue" class="easyui-panel" style="padding:5px"></div> -->
	</div>
	<div region="center" split="true" title="" style="padding:5px;text-align: left;">
		<ul id="dirTree"></ul>
	</div>
	<div id="treeContextMenu" class="easyui-menu" style="width:120px;">
		<div iconCls="icon-cancel" onclick="deleteNode()">Delete</div>
		<div iconCls="icon-reload" onclick="refreshNode()">Refresh</div>
	</div>
</body>
</html>
