package com.dalian.genpact.tianyaweixin.message.req;

/**
 * 文本消息
 * 
 * @author lisonghua
 * @date 2014-06-03
 */
public class TextMessage extends BaseMessage {
	// 消息内容
	private String Content;

	public String getContent() {
		return Content;
	}

	public void setContent(String content) {
		Content = content;
	}
}
