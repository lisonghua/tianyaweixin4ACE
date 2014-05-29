<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/common/taglibs.jsp" %>
	<script language="javascript" type="text/javascript" src="${ctx}/js/jqplot/plugins/jqplot.logAxisRenderer.js"></script>
	<script language="javascript" type="text/javascript" src="${ctx}/js/jqplot/plugins/jqplot.canvasTextRenderer.js"></script>
	<script language="javascript" type="text/javascript" src="${ctx}/js/jqplot/plugins/jqplot.canvasAxisLabelRenderer.js"></script>
	<script language="javascript" type="text/javascript" src="${ctx}/js/jqplot/plugins/jqplot.canvasAxisTickRenderer.js"></script>
	<script language="javascript" type="text/javascript" src="${ctx}/js/jqplot/plugins/jqplot.dateAxisRenderer.js"></script>
	<script language="javascript" type="text/javascript" src="${ctx}/js/jqplot/plugins/jqplot.categoryAxisRenderer.js"></script>
	<script language="javascript" type="text/javascript" src="${ctx}/js/jqplot/plugins/jqplot.barRenderer.js"></script>
<script type="text/javascript">
<!--
	var _everyday_permonth_report_data=<%=request.getAttribute("_everyday_permonth_report_data")%>;
	<%
		String applicationName = request.getParameter("application")==null?"":request.getParameter("application");
		applicationName = applicationName.replace("/","");
	%>
	var applicationName = "<%=applicationName%>";
	try{
		$.jqplot.config.enablePlugins = true;
		everyday_chart_obj=$.jqplot('chartdiv',  
				[_everyday_permonth_report_data],
				{
				title: applicationName+" <s:text name='label.sm.ds.report.everydayUserCount'></s:text>",
				//dataRenderer: $.jqplot.ciParser,
			    series:[{renderer:$.jqplot.BarRenderer}],
			    axes: {
			      xaxis: {
					//renderer:$.jqplot.DateAxisRenderer,
					//tickInterval: '1 day',
			        renderer: $.jqplot.CategoryAxisRenderer,
			          label: "<s:text name='label.sm.ds.report.everydayUserCount.X'></s:text>",
			        // labelRenderer: $.jqplot.CanvasAxisLabelRenderer,
			        tickRenderer: $.jqplot.CanvasAxisTickRenderer,
			        tickOptions: {
					  //formatString:'%Y-%m-%d',
			          enableFontSupport: true,
			          angle: -30
			        }
			        
			      },
			      yaxis: {
			        autoscale:true,
			          label: "<s:text name='label.sm.ds.report.everydayUserCount.Y'></s:text>",
			        // labelRenderer: $.jqplot.CanvasAxisLabelRenderer,
			        tickRenderer: $.jqplot.CanvasAxisTickRenderer,
			        tickOptions: {
			          enableFontSupport: true,
			            angle: -30
			        }
			      }
			    }
			}
		);
	}catch(e){
			alert(e.message);
	};
//-->
</script>
