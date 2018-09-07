#!/bin/bash
set -e

LDAP_URL=${LDAP_URL}
BIND_DN=${BIND_DN}
BIND_PASSWORD=${BIND_PASSWORD}
BASE_DN=${BASE_DN}
GROUP_BASE_DN=${GROUP_BASE_DN}
CONF_HOME=${SONARQUBE_HOME}/conf/sonar.properties

CHECK_CONF=$(cat ${CONF_HOME} |grep sonar.security.realm= | wc -l)
if [[ ${LDAP_URL} && ${CHECK_CONF} -eq 0 ]]; then
    echo " " >> ${CONF_HOME}
    echo "# LDAP configuration" >> ${CONF_HOME}
    echo "# General Configuration" >> ${CONF_HOME}
    echo "sonar.security.realm=LDAP" >> ${CONF_HOME}
    echo "ldap.url=${LDAP_URL}" >> ${CONF_HOME}
    echo "ldap.bindDn=${BIND_DN}" >> ${CONF_HOME}
    echo "ldap.bindPassword=${BIND_PASSWORD}" >> ${CONF_HOME}
    echo " " >> ${CONF_HOME}
    echo "# User Configuration" >> ${CONF_HOME}
    echo "ldap.user.baseDn=${BASE_DN}" >> ${CONF_HOME}
    echo "ldap.user.request=(&(objectClass=inetOrgPerson)(uid={login}))" >> ${CONF_HOME}
    echo "ldap.user.realNameAttribute=cn" >> ${CONF_HOME}
    echo "ldap.user.emailAttribute=mail" >> ${CONF_HOME}
    echo " " >> ${CONF_HOME}
    echo "# Group Configuration" >> ${CONF_HOME}
    echo "ldap.group.baseDn=${GROUP_BASE_DN}" >> ${CONF_HOME}
    echo "ldap.group.request=(&(objectClass=posixGroup)(memberUid={uid}))" >> ${CONF_HOME}
elif [[ ${CHECK_CONF} -eq 0 ]]; then
    echo "# LDAP configuration" >> ${CONF_HOME}
    echo "sonar.security.realm=" >> ${CONF_HOME}
fi

${SONARQUBE_HOME}/bin/run.sh
