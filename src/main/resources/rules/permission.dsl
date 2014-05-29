[condition][]I am administrator,my id is "{userId}"=$user: User(userId=={userId})
[consequence][]I can access all modules=permissionService.getAllModules($nodeId);
[condition][]I am accessing a module=$moduleId:Integer()
[condition][]and=and
