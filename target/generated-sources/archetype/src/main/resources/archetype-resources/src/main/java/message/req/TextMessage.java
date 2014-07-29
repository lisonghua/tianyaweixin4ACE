#set( $symbol_pound = '#' )
#set( $symbol_dollar = '$' )
#set( $symbol_escape = '\' )
package ${package}.message.req;

import java.util.Map;

/**
 * 文本消息
 * 
 * @author lisonghua
 * @date 2014-06-03
 */
public class TextMessage extends BaseMessage {
	// 消息内容
	private String Content;

	@Override
	public void parseMessage(Map<String, String> msgMap) {
		this.Content = msgMap.get("Content");
	}

	public String getContent() {
		return Content;
	}

	public void setContent(String content) {
		Content = content;
	}
}
