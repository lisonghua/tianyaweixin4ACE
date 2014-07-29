#set( $symbol_pound = '#' )
#set( $symbol_dollar = '$' )
#set( $symbol_escape = '\' )
package ${package}.message.req;

import java.util.Map;

public class VoiceMessage extends BaseMessage {
	// 媒体ID  
	private String MediaId;
	// 语音格式  
	private String Format;

	@Override
	public void parseMessage(Map<String, String> msgMap) {
		this.MediaId = msgMap.get("PicUrl");
		this.Format = msgMap.get("Format");
	}

	public String getMediaId() {
		return MediaId;
	}

	public void setMediaId(String mediaId) {
		MediaId = mediaId;
	}

	public String getFormat() {
		return Format;
	}

	public void setFormat(String format) {
		Format = format;
	}
}
