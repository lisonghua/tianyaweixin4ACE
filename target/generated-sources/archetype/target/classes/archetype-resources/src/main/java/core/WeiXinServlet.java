#set( $symbol_pound = '#' )
#set( $symbol_dollar = '$' )
#set( $symbol_escape = '\' )
package ${package}.core;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import ${package}.service.MessageService;
import ${package}.utils.WeiXinSignUtil;

public class WeiXinServlet extends HttpServlet {

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	protected Logger logger = LoggerFactory.getLogger(getClass());

	@Override
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// 微信加密签名  
		String signature = request.getParameter("signature");
		logger.debug("signature=" + signature);
		// 时间戳  
		String timestamp = request.getParameter("timestamp");
		logger.debug("timestamp=" + timestamp);
		// 随机数  
		String nonce = request.getParameter("nonce");
		logger.debug("nonce=" + nonce);
		// 随机字符串  
		String echostr = request.getParameter("echostr");
		logger.debug("echostr=" + echostr);

		PrintWriter out = response.getWriter();
		// 通过检验signature对请求进行校验，若校验成功则原样返回echostr，表示接入成功，否则接入失败  
		if (WeiXinSignUtil.checkSignature(signature, timestamp, nonce)) {
			logger.debug("checkSignature start!");
			out.print(echostr);
			logger.debug("checkSignature end!");
		}
		out.close();
		out = null;
	}

	@Override
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException,
			IOException {
		// 将请求、响应的编码均设置为UTF-8（防止中文乱码）  
		request.setCharacterEncoding("UTF-8");
		response.setCharacterEncoding("UTF-8");

		// 调用核心业务类接收消息、处理消息  
		String respMessage = MessageService.processRequest(request);

		// 响应消息  
		PrintWriter out = response.getWriter();
		out.print(respMessage);
		out.close();
	}

}
