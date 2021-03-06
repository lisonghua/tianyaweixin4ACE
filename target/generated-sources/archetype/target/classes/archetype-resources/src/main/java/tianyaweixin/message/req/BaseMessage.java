#set( $symbol_pound = '#' )
#set( $symbol_dollar = '$' )
#set( $symbol_escape = '\' )
package ${package}.${artifactId}.message.req;

import java.util.Map;

/**
 * 消息基类（普通用户 -> 公众帐号）
 * 
 * @author lisonghua
 * @date 2014-06-03
 */
public class BaseMessage implements ReqMessage {
	// 开发者微信号
	private String ToUserName;
	// 发送方帐号（一个OpenID）
	private String FromUserName;
	// 消息创建时间 （整型）
	private long CreateTime;
	// 消息类型（text/image/location/link）
	private String MsgType;
	// 消息id，64位整型
	private long MsgId;

	public void parseMessage(Map<String, String> msgMap) {
		this.ToUserName = msgMap.get("ToUserName");
		this.FromUserName = msgMap.get("FromUserName");
		this.MsgType = msgMap.get("MsgType");
		this.CreateTime = Long.parseLong(msgMap.get("CreateTime"));
		this.MsgId = Long.parseLong(msgMap.get("MsgId"));
	}

	public String getToUserName() {
		return ToUserName;
	}

	public void setToUserName(String toUserName) {
		ToUserName = toUserName;
	}

	public String getFromUserName() {
		return FromUserName;
	}

	public void setFromUserName(String fromUserName) {
		FromUserName = fromUserName;
	}

	public long getCreateTime() {
		return CreateTime;
	}

	public void setCreateTime(long createTime) {
		CreateTime = createTime;
	}

	public String getMsgType() {
		return MsgType;
	}

	public void setMsgType(String msgType) {
		MsgType = msgType;
	}

	public long getMsgId() {
		return MsgId;
	}

	public void setMsgId(long msgId) {
		MsgId = msgId;
	}
}
