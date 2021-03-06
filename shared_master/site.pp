node default {
	include java
	include git
}

node 'jenkinsAgent.qac.local' {
	include jenkins
	include maven
}

node 'nexusAgent.qac.local' {
	include nexus
}

node 'jiraAgent.qac.local' {
	include jira
}

node 'bambooAgent.qac.local' {
	include bamboo
}

node 'mysqlAgent.qac.local' {
	include mysql
}