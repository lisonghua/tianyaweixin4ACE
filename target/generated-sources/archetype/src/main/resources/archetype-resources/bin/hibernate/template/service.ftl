package ${pojo.getPackageName()}.service;
<#assign classbody>
<#assign declarationName = pojo.importType(pojo.getDeclarationName())>
<#assign entityName = declarationName?uncap_first>
@${pojo.importType("org.springframework.stereotype.Service")}
@${pojo.importType("org.springframework.transaction.annotation.Transactional")}
public class ${declarationName}Service extends ${declarationName}{
	@${pojo.importType("org.springframework.beans.factory.annotation.Autowired")}
	private ${declarationName}Dao ${entityName}Dao;
}
</#assign>

import org.springside.modules.orm.Page;
import org.springside.modules.orm.PropertyFilter;

${pojo.generateImports()}
import ${pojo.getQualifiedDeclarationName()};

${classbody}
