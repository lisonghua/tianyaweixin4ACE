<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/common/taglibs.jsp" %>
<script type="text/javascript">
<!--
jq(function(){
		loadTaskMultiInstance();
});
function saveTaskMultiInstance(){
	if(jq('#sequentialYes').attr('checked')){
		task.isSequential=true;
	}
	if(jq('#sequentialNo').attr('checked')){
		task.isSequential=false;
	}
	task._loopCardinality=jq("#loopCardinality").val();
	task._collection=jq("#collection").val();
	task._elementVariable=jq("#elementVariable").val();
	task._completionCondition=jq("#completionCondition").val();
}
function loadTaskMultiInstance(){
	//alert(task.isSequential);
	if(task.isSequential){
		jq('#sequentialYes').attr('checked',true);
	}else{
		jq('#sequentialNo').attr('checked',true);
	}
	
	jq("#loopCardinality").val(task._loopCardinality);
	jq("#collection").val(task._collection);
	jq("#elementVariable").val(task._elementVariable);
	jq("#completionCondition").val(task._completionCondition);
}
//-->
</script>
<table>
	<tr>
			<td align="right">Sequential:</td>
			<td>
				<input type="radio" id="sequentialYes" name="sequential"  value="true"/>Yes
				<input type="radio" id="sequentialNo" name="sequential"  value="false" checked/>No
			</td>
	</tr>
	<tr>
			<td align="right">Loop Cardinality:</td>
			<td>
				<input type="text" id="loopCardinality" name="loopCardinality"  value="" size="50"/>
			</td>
	</tr>
	<tr>
			<td align="right">Collection:</td>
			<td>
				<input type="text" id="collection" name="collection"  value="" size="50"/>
			</td>
	</tr>
	<tr>
			<td align="right">Element Variable:</td>
			<td>
				<input type="text" id="elementVariable" name="elementVariable"  value="" size="50"/>
			</td>
	</tr>
	<tr>
			<td align="right">Completion Condition:</td>
			<td>
				<input type="text" id="completionCondition" name="completionCondition"  value="" size="50"/>
			</td>
	</tr>
</table>