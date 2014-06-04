package com.dalian.genpact.tianyaweixin.message.req;

import java.util.Map;

public class ImageMessage extends BaseMessage {
	// 图片链接  
	private String PicUrl;

	@Override
	public void parseMessage(Map<String, String> msgMap) {
		this.PicUrl = msgMap.get("PicUrl");
	}

	public String getPicUrl() {
		return PicUrl;
	}

	public void setPicUrl(String picUrl) {
		PicUrl = picUrl;
	}
}
