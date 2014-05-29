<%@ page language="java" pageEncoding="UTF-8" %>
<%@page import="java.util.Locale" %>
<%@page import="com.opensymphony.xwork2.interceptor.I18nInterceptor" %>
<%@ page import="org.springside.modules.security.springsecurity.SpringSecurityUtils" %>
<%@ page import="com.dalian.genpact.framework.service.login.LogonUser" %>
<%@ page import="com.dalian.genpact.framework.common.constants.CommonConstant" %>
<%@ page import="com.dalian.genpact.framework.extend.security.SsoAuthenticationProcessingFilter" %>
<%@ include file="/common/meta.jsp" %>
<!-- framework CSS -->
<link href="${ctx}/css/style.css" type="text/css" rel="stylesheet"/>
<link href="${ctx}/themes/gray/css/style.css" type="text/css" rel="stylesheet" title="gray"/>
<link href="${ctx}/themes/green/css/style.css" type="text/css" rel="stylesheet" title="green"/>
<link href="${ctx}/themes/orange/css/style.css" type="text/css" rel="stylesheet" title="orange"/>
<link href="${ctx}/themes/pink/css/style.css" type="text/css" rel="stylesheet"/ title="pink">
<link href="${ctx}/themes/default/css/style.css" type="text/css" rel="stylesheet" title="blue"/>

<!-- JQuery EasyUi CSS-->
<link type="text/css" href="${ctx}/js/jquery-easyui/themes/gray/easyui.css" rel="stylesheet" title="gray">
<link type="text/css" href="${ctx}/js/jquery-easyui/themes/green/easyui.css" rel="stylesheet" title="green">
<link type="text/css" href="${ctx}/js/jquery-easyui/themes/orange/easyui.css" rel="stylesheet" title="orange">
<link type="text/css" href="${ctx}/js/jquery-easyui/themes/pink/easyui.css" rel="stylesheet" title="pink">
<link type="text/css" href="${ctx}/js/jquery-easyui/themes/default/easyui.css" rel="stylesheet" title="blue">
<link href="${ctx}/js/jquery-easyui/themes/icon.css" type="text/css" rel="stylesheet"/>

<!-- JQuery validate CSS-->
<link href="${ctx}/js/validate/jquery.validate.extend.css" type="text/css" rel="stylesheet"/>

<!-- JQuery AutoComplete -->
<link rel="stylesheet" type="text/css" href="${ctx}/js/jquery-autocomplete/jquery.autocomplete.css" />
<!--<link rel="stylesheet" type="text/css" href="${ctx}/js/jquery-autocomplete/lib/thickbox.css" />-->

<!-- jqplot -->
<link rel="stylesheet" type="text/css" href="${ctx}/js/jqplot/themes/jquery.jqplot.css" />

<!-- JQuery-->
<script src="${ctx}/js/jquery-1.4.4.min.js" type="text/javascript"></script>
<!--<script src="${ctx}/js/jquery-1.6.min.js" type="text/javascript"></script>-->

<!-- JQuery EasyUi JS-->
<script src="${ctx}/js/jquery-easyui/jquery.easyui.min.js" type="text/javascript"></script>
<!-- JQuery validate JS-->
<script src="${ctx}/js/validate/jquery.validate.js" type="text/javascript"></script>
<script src="${ctx}/js/validate/jquery.metadata.js" type="text/javascript"></script>
<script src="${ctx}/js/validate/jquery.validate.method.js" type="text/javascript"></script>
<script src="${ctx}/js/validate/jquery.validate.extend.js" type="text/javascript"></script>

<!-- JQuery form Plugin -->
<script src="${ctx}/js/jquery.form.js" type="text/javascript"></script>

<!-- JSON JS-->
<script src="${ctx}/js/json2.js" type="text/javascript"></script>

<!-- jqplot -->
<script src="${ctx}/js/jqplot/jquery.jqplot.js" type="text/javascript"></script>

<!-- JQuery AutoComplete -->
<script type='text/javascript' src='${ctx}/js/jquery-autocomplete/lib/jquery.bgiframe.min.js'></script>
<script type='text/javascript' src='${ctx}/js/jquery-autocomplete/lib/jquery.ajaxQueue.js'></script>
<!--<script type='text/javascript' src='${ctx}/js/jquery-autocomplete/lib/thickbox-compressed.js'></script>-->
<script type='text/javascript' src='${ctx}/js/jquery-autocomplete/jquery.autocomplete.min.js'></script>

<!-- framework JS -->
<script src="${ctx}/js/skin.js" type="text/javascript"></script>

<!--[if IE]><script src="${ctx}/js/jqplot/excanvas.js" type="text/javascript"></script><![endif]-->
<%
	Locale locale = (Locale)session.getAttribute(I18nInterceptor.DEFAULT_SESSION_ATTRIBUTE);
	if(locale == null){
	//default
%>
	<script src="${ctx}/js/jquery-easyui/locale/easyui-lang-en.js" type="text/javascript"></script>
	<script src="${ctx}/js/validate/messages_en.js" type="text/javascript"></script>
<%	//chinese	
	}else if(locale.getLanguage().equals(new Locale("zh", "", "").getLanguage())){
%>
	<script src="${ctx}/js/jquery-easyui/locale/easyui-lang-zh_CN.js" type="text/javascript"></script>
	<script src="${ctx}/js/validate/messages_cn.js" type="text/javascript"></script>
<%	//english	
	}else if(locale.getLanguage().equals(new Locale("en", "", "").getLanguage())){
%>
	<script src="${ctx}/js/jquery-easyui/locale/easyui-lang-en.js" type="text/javascript"></script>
	<script src="${ctx}/js/validate/messages_en.js" type="text/javascript"></script>
<%		
	}else{
	//other
%>
	<script src="${ctx}/js/jquery-easyui/locale/easyui-lang-en.js" type="text/javascript"></script>
	<script src="${ctx}/js/validate/messages_en.js" type="text/javascript"></script>
<%		
	}
%>