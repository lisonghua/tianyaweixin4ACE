package ${pojo.getPackageName()}.web;
<#assign classbody>
<#assign identifier = clazz.getIdentifierProperty()>
<#assign identifierCap = identifier.getName()?cap_first>
<#assign declarationName = pojo.importType(pojo.getDeclarationName())>
<#assign entityName = declarationName?uncap_first>
@${pojo.importType("org.apache.struts2.convention.annotation.Namespace")}("/${modelName}/${subModelName}/${entityName}")
@${pojo.importType("org.apache.struts2.convention.annotation.Results")}({
	@${pojo.importType("org.apache.struts2.convention.annotation.Result")}(name = "forQuery", location = "/WEB-INF/content/${modelName}/${subModelName}/${declarationName}Query.jsp"),
	@${pojo.importType("org.apache.struts2.convention.annotation.Result")}(name = "forInsert", location = "/WEB-INF/content/${modelName}/${subModelName}/${declarationName}Edit.jsp"),
	@${pojo.importType("org.apache.struts2.convention.annotation.Result")}(name = "forUpdate", location = "/WEB-INF/content/${modelName}/${subModelName}/${declarationName}Edit.jsp")
		})
public class ${declarationName}Action extends SimpleActionSupport<${declarationName}> {
	
	private static final long serialVersionUID = 1L;
	
	private ${pojo.getJavaTypeName(identifier, jdk5)} ${identifier.getName()};
	@${pojo.importType("org.springframework.beans.factory.annotation.Autowired")}
	private ${declarationName}Manager ${entityName}Manager;
	private ${declarationName} ${entityName};

	public String search(){
		HttpServletRequest request = getRequest();
		Map<String,Object> json = new HashMap<String,Object>();
		List<Map<String,Object>> rows = new ArrayList<Map<String,Object>>();
		initPage(request, page);
		List<PropertyFilter> filters = HibernateUtils.buildPropertyFilters(request);
		${entityName}Manager.search(page, filters);
		List<${declarationName}> ${entityName}s = page.getResult();
		for(${declarationName} ${entityName}:${entityName}s){
			Map<String,Object> row = new HashMap<String,Object>();
			<#foreach field in pojo.getAllPropertiesIterator()>
			<#assign capfName = field.name?cap_first>
			<#assign capName = field.name?upper_case>
			row.put(${declarationName}Constant._DATA_MODEL_FIELD_NAME_${capName},${entityName}.get${capfName}());
			</#foreach>
			rows.add(row);
		}
		json.put("rows", rows);
		json.put("total",page.getTotalCount());
		Struts2Utils.renderJson(json);
		return null;
	}
	
	public String save(){
		Map<String,Object> result = new HashMap<String,Object>();
		try {
			${entityName}Manager.save${declarationName}(this.getModel());
			result.put("success", true);
			result.put("message", getText("message.common.save.success"));
		} catch (Exception e) {
			logger.error("save unsuccessfully!",e);
			result.put("success", false);
			result.put("message", getText("message.common.save.failure"));
		}
		Struts2Utils.renderJson(result);
		return null;
	}
	
	public String delete(){
		Map<String,Object> result = new HashMap<String, Object>();
		try {
			${entityName}Manager.delete${declarationName}(${identifier.getName()});
			result.put("success", true);
			result.put("message",getText("message.sm.server.delete.success"));
		} catch (Exception e) {
			logger.error("delete unsuccessfully!",e);
			result.put("success", false);
			result.put("message",getText("message.sm.server.delete.failure"));
		}
		Struts2Utils.renderJson(result);
		return null;
	}
	
	public String forQuery(){
		return "forQuery";
	}
	
	public String forUpdate(){
		return "forUpdate";
	}
	
	public String forInsert(){
		return "forInsert";
	}
	
	@Override
	protected void prepareModel() throws Exception {
		if(${identifier.getName()} != null){
			${entityName} = ${entityName}Manager.get${declarationName}(${identifier.getName()});
		}else{
			${entityName} = new ${declarationName}();
		}
	}

	public ${declarationName} getModel() {
		return ${entityName};
	}
	
	public ${pojo.getJavaTypeName(identifier, jdk5)} get${identifierCap}() {
		return ${identifier.getName()};
	}

	public void set${identifierCap}(${pojo.getJavaTypeName(identifier, jdk5)} ${identifier.getName()}) {
		this.${identifier.getName()} = ${identifier.getName()};
	}
}
</#assign>

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.apache.log4j.Logger;

import org.springside.modules.orm.PropertyFilter;
import org.springside.modules.orm.hibernate.HibernateUtils;
import org.springside.modules.web.struts2.Struts2Utils;

import net.sf.json.JSONArray;
import net.sf.json.JSONObject;

import com.dalian.genpact.framework.service.exception.ServiceException;
import com.dalian.genpact.framework.web.SimpleActionSupport;
${pojo.generateImports()}
import ${pojo.getPackageName()}.persistence.entity.${pojo.getDeclarationName()};
import ${pojo.getPackageName()}.service.${declarationName}Manager;

${classbody}
