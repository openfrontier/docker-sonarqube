FROM sonarqube:5.6.7

MAINTAINER "xing.jiudong@trans-cosmos.com.cn"

ENV JAVA_PLUGIN_VERSION=4.0 \
    JAVASCRIPT_PLUGIN_VERSION=2.14 \
    WEB_PLUGIN_VERSION=2.4 \
    XML_PLUGIN_VERSION=1.4.1 \
    CSHARP_PLUGIN_VERSION=5.3.1 \
    ZH_PLUGIN_VERSION=1.11 \
    JA_PLUGIN_VERSION=1.3 \
    LDAP_PLUGIN_VERSION=2.0 \
    MOTION_CHART_PLUGIN_VERSION=1.7 \
    GIT_PLUGIN_VERSION=1.2 \
    SVN_PLUGIN_VERSION=1.3 \
    WIDGET_LAB_PLUGIN_VERSION=1.8.1 \
    CSS_PLUGIN_VERSION=2.0 \
    TS_PLUGIN_VERSION=0.98

# Install plugins
RUN set -x && rm -rf $SONARQUBE_HOME/lib/bundled-plugins/*.jar && \
  cd $SONARQUBE_HOME/lib/bundled-plugins/ && \
  curl -sSOL https://sonarsource.bintray.com/Distribution/sonar-java-plugin/sonar-java-plugin-${JAVA_PLUGIN_VERSION}.jar && \
  curl -sSOL https://sonarsource.bintray.com/Distribution/sonar-javascript-plugin/sonar-javascript-plugin-${JAVASCRIPT_PLUGIN_VERSION}.jar && \
  curl -sSOL https://repox.sonarsource.com/sonarsource/org/sonarsource/sonar-web-plugin/sonar-web-plugin/${WEB_PLUGIN_VERSION}/sonar-web-plugin-${WEB_PLUGIN_VERSION}.jar && \
  curl -sSOL https://repox.sonarsource.com/sonarsource/org/sonarsource/xml/sonar-xml-plugin/${XML_PLUGIN_VERSION}/sonar-xml-plugin-${XML_PLUGIN_VERSION}.jar && \
  curl -sSOL https://sonarsource.bintray.com/Distribution/sonar-csharp-plugin/sonar-csharp-plugin-${CSHARP_PLUGIN_VERSION}.jar && \
  curl -sSOL http://downloads.sonarsource.com/plugins/org/codehaus/sonar-plugins/l10n/sonar-l10n-ja-plugin/${JA_PLUGIN_VERSION}/sonar-l10n-ja-plugin-${JA_PLUGIN_VERSION}.jar && \
  curl -sSOL https://sonarsource.bintray.com/Distribution/sonar-ldap-plugin/sonar-ldap-plugin-${LDAP_PLUGIN_VERSION}.jar && \
  curl -sSOL http://downloads.sonarsource.com/plugins/org/codehaus/sonar-plugins/sonar-motion-chart-plugin/${MOTION_CHART_PLUGIN_VERSION}/sonar-motion-chart-plugin-${MOTION_CHART_PLUGIN_VERSION}.jar && \
  curl -sSOL https://sonarsource.bintray.com/Distribution/sonar-scm-git-plugin/sonar-scm-git-plugin-${GIT_PLUGIN_VERSION}.jar && \
  curl -sSOL https://sonarsource.bintray.com/Distribution/sonar-scm-svn-plugin/sonar-scm-svn-plugin-${SVN_PLUGIN_VERSION}.jar && \
  curl -sSOL http://sonarsource.bintray.com/Distribution/sonar-widget-lab-plugin/sonar-widget-lab-plugin-${WIDGET_LAB_PLUGIN_VERSION}.jar && \
  curl -sSOL https://github.com/SonarQubeCommunity/sonar-l10n-zh/releases/download/sonar-l10n-zh-plugin-${ZH_PLUGIN_VERSION}/sonar-l10n-zh-plugin-${ZH_PLUGIN_VERSION}.jar && \
  curl -sSOL https://github.com/SonarQubeCommunity/sonar-css/releases/download/${CSS_PLUGIN_VERSION}/sonar-css-plugin.jar && \
  curl -sSOL https://github.com/Pablissimo/SonarTsPlugin/releases/download/v${TS_PLUGIN_VERSION}/sonar-typescript-plugin-${TS_PLUGIN_VERSION}-SNAPSHOT.zip && \
  unzip sonar-typescript-plugin-${TS_PLUGIN_VERSION}-SNAPSHOT.zip && \
  rm -rf sonar-typescript-plugin-${TS_PLUGIN_VERSION}-SNAPSHOT.zip

RUN sed -i '/java -jar lib/a \
    -Dsonar.web.context="$SONAR_WEB_CONTEXT" \ 
    -Dsonar.security.realm="$SONAR_SECURITY_REALM" \
    -Dldap.bindDn="$LDAP_BINDDN" \
    -Dldap.bindPassword="$LDAP_BINDPASSWORD" \
    -Dldap.url="$LDAP_URL" \
    -Dldap.user.baseDn="$LDAP_USER_BASEDN" \
    -Dldap.user.request="$LDAP_USER_REQUEST" \
    -Dldap.user.realNameAttribute="$LDAP_USER_REALNAMEATTRIBUTE" \
    -Dldap.user.emailAttribute="$LDAP_USER_EMAILATTRIBUTE" \
    -Dldap.group.baseDn="$LDAP_GROUP_BASEDN" \
    -Dldap.group.request="$LDAP_GROUP_REQUEST" \\' $SONARQUBE_HOME/bin/run.sh
