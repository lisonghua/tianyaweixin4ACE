package ${pojo.getPackageName()}.web;
<#assign classbody>
<#assign identifier = clazz.getIdentifierProperty()>
<#assign declarationName = pojo.importType(pojo.getDeclarationName())>
<#assign entityName = declarationName?uncap_first>

public class ${declarationName}Constant {

	<#foreach field in pojo.getAllPropertiesIterator()>
			<#assign capName = field.name?upper_case>
			public static final String _DATA_MODEL_FIELD_NAME_${capName} = "${field.name}";
	</#foreach>
}
</#assign>

${classbody}
