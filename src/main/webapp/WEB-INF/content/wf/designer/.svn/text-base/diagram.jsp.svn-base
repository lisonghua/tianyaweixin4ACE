<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/common/taglibs.jsp" %>
<%@ include file="parser.jsp" %>
<div id="process-definition-tab">
			<div id="designer-area" title="Diagram" style="POSITION: absolute;width:100%;height:100%;padding: 0;border: none;overflow:auto;">
				<div id="paintarea" style="POSITION: absolute;WIDTH: 3000px; HEIGHT: 3000px" ></div>
			</div>
			<div id="xml-area" title="XML" style="width:100%;height:100%;overflow:hidden;overflow-x:hidden;overflow-y:hidden;">
				<textarea id="descriptorarea" rows="38" style="width: 100%;height:100%;padding: 0;border: none;" readonly="readonly"></textarea>
			</div>
</div>
<script type="text/javascript">
	<!--
	var workflow;
	jq('#process-definition-tab').tabs({
		fit:true,
		onSelect:function(title){
			if(title=='Diagram'){
				
			}else if(title=='XML'){
				jq('#descriptorarea').val(workflow.toXML());
				/*
				if(document.body.innerText)
					jq('#xml-area').get(0).innerText=workflow.toXML();
				else if(document.body.textContent)
					jq('#xml-area').get(0).textContent=workflow.toXML();
				*/
			}
		}
	});
	function openProcessDef(){
		jq.ajax({
			url:"${ctx}/wf/procdef/procdef!getProcessDefXML.action?procdefId="+processDefinitionId,
			type: 'POST',
			/*
			data:{
						moduleId:"${moduleId}",
						_request_json_fields:json4params
				},
			*/
			dataType:'xml',
			error:function(){
				$.messager.alert("<s:text name='label.common.error'></s:text>","System Error","error");
				return "";
			},
			success:parseProcessDescriptor	
		}); 
	}

	function createCanvas(disabled){
		//try{
			//initCanvas();
			//alert(1);
			workflow  = new draw2d.MyCanvas("paintarea");
			//alert(10);
			workflow.scrollArea=document.getElementById("designer-area");
			//alert(11);
			if(disabled)
				workflow.setDisabled();
			if(typeof processDefinitionId != "undefined" && processDefinitionId != null &&  processDefinitionId != "null" && processDefinitionId != "" && processDefinitionId != "NULL"){
				openProcessDef();
			}else{
				//alert(2);
					var id = "process"+Sequence.create();
					//var id = workflow.getId();
					workflow.process.category='lish_wf_process_def';
					workflow.process.id=id;
					workflow.process.name=id;
				// Add the start,end,connector to the canvas
				  var startObj = new draw2d.Start("${ctx}/js/designer/icons/type.startevent.none.png");
				  //startObj.setId("start");
				  //alert(3);
				  workflow.addFigure(startObj, 200,50);
				  
				  var endObj   = new draw2d.End("${ctx}/js/designer/icons/type.endevent.none.png");
				  //endObj.setId("end");
				  //alert(4);
				  workflow.addFigure(endObj,200,400);
				  
			} 
		//}catch(e){
			//alert(e.message);
		//}
	}
	//-->
</script>