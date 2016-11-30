node default {
	include java
	include git
}

node 'jenkinsAgent' {
	include jenkins
	include maven
}

node 'nexusAgent' {
	include nexus
}

node 'jiraAgent' {
	include jira
}

node 'bambooAgent' {
	include bamboo
}

node 'mysqlAgent' {
	include mysql
}