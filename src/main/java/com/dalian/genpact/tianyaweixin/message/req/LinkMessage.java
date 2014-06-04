package com.dalian.genpact.tianyaweixin.message.req;

import java.util.Map;

public class LinkMessage extends BaseMessage {
	// 消息标题  
	private String Title;
	// 消息描述  
	private String Description;
	// 消息链接  
	private String Url;

	@Override
	public void parseMessage(Map<String, String> msgMap) {
		this.Title = msgMap.get("Title");
		this.Description = msgMap.get("Description");
		this.Url = msgMap.get("Url");
	}

	public String getTitle() {
		return Title;
	}

	public void setTitle(String title) {
		Title = title;
	}

	public String getDescription() {
		return Description;
	}

	public void setDescription(String description) {
		Description = description;
	}

	public String getUrl() {
		return Url;
	}

	public void setUrl(String url) {
		Url = url;
	}
}
