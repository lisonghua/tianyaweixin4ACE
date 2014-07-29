#set( $symbol_pound = '#' )
#set( $symbol_dollar = '$' )
#set( $symbol_escape = '\' )
package ${package}.${artifactId}.web;

import org.springframework.beans.factory.annotation.Autowired;
import org.springside.modules.web.struts2.Struts2Utils;

import ${package}.framework.web.SimpleActionSupport;
import ${package}.${artifactId}.model.Authentication;
import ${package}.${artifactId}.service.MessageService;
import ${package}.${artifactId}.utils.WeiXinSignUtil;

//@Namespace("/weixin/security")
public class AuthenticationAction extends SimpleActionSupport<Authentication> {

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	@Autowired
	private MessageService messageService;

	public String authenticate() {
		// 微信加密签名  
		String signature = getRequest().getParameter("signature");
		logger.debug("signature=" + signature);
		// 时间戳  
		String timestamp = getRequest().getParameter("timestamp");
		logger.debug("timestamp=" + timestamp);
		// 随机数  
		String nonce = getRequest().getParameter("nonce");
		logger.debug("nonce=" + nonce);
		// 随机字符串  
		String echostr = getRequest().getParameter("echostr");
		logger.debug("echostr=" + echostr);

		try {
			// 通过检验signature对请求进行校验，若校验成功则原样返回echostr，表示接入成功，否则接入失败  
			if (WeiXinSignUtil.checkSignature(signature, timestamp, nonce)) {
				logger.debug("checkSignature start!");
				//				Struts2Utils.renderText(echostr, new String[] { "Content" });
				Struts2Utils.getResponse().getWriter().print(echostr);
				Struts2Utils.getResponse().getWriter().flush();
				logger.debug("checkSignature end!");
			}
			return null;
		} catch (Exception e) {
			throw new RuntimeException(e);
		}
	}

	@Override
	protected void prepareModel() throws Exception {
		// TODO Auto-generated method stub

	}

}
