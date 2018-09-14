#!/bin/bash
set -e

CONF_HOME=${SONARQUBE_HOME}/conf/sonar.properties

CHECK_CONF=$(cat ${CONF_HOME} |grep sonar.security.realm= | wc -l)
if [[ ${LDAP_URL} && ${CHECK_CONF} -eq 0 ]]; then
    echo " " >> ${CONF_HOME}
    echo "# LDAP configuration" >> ${CONF_HOME}
    echo "sonar.security.realm=LDAP" >> ${CONF_HOME}
    echo "ldap.url=${LDAP_URL}" >> ${CONF_HOME}
    echo "ldap.bindDn=${LDAP_BINDDN}" >> ${CONF_HOME}
    echo "ldap.bindPassword=${LDAP_BINDPASSWORD}" >> ${CONF_HOME}
    echo "ldap.user.baseDn=${LDAP_USER_BASEDN}" >> ${CONF_HOME}
    echo "ldap.user.request=${LDAP_USER_REQUEST}" >> ${CONF_HOME}
    echo "ldap.user.realNameAttribute=displayName" >> ${CONF_HOME}
    echo "ldap.user.emailAttribute=mail" >> ${CONF_HOME}
    echo "ldap.group.baseDn=${LDAP_GROUP_BASEDN}" >> ${CONF_HOME}
    echo "ldap.group.request=${LDAP_GROUP_REQUEST}" >> ${CONF_HOME}

elif [[ ${CHECK_CONF} -eq 0 ]]; then
    echo " " >> ${CONF_HOME}
    echo "# LDAP configuration" >> ${CONF_HOME}
    echo "sonar.security.realm=" >> ${CONF_HOME}
fi

if [[ ${SONAR_WEB_CONTEXT} ]]; then
    echo "sonar.web.context=${SONAR_WEB_CONTEXT}" >> ${CONF_HOME}
fi

${SONARQUBE_HOME}/bin/run.sh
