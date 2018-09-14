FROM sonarqube:5.6.7

MAINTAINER "xing.jiudong@trans-cosmos.com.cn"

ENV LDAP_URL= \
    LDAP_BINDDN= \
    LDAP_BINDPASSWORD= \
    LDAP_USER_BASEDN= \
    LDAP_USER_REQUEST= \
    LDAP_GROUP_BASEDN= \
    LDAP_GROUP_REQUEST= \
    SONAR_WEB_CONTEXT=

ENV PLUGIN_HOME=$SONARQUBE_HOME/extensions/plugins \
    JAVA_PLUGIN_VERSION=4.0 \
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
    CSS_PLUGIN_VERSION=2.0

# Plugins
RUN curl -sLo ${PLUGIN_HOME}/sonar-java-plugin-${JAVA_PLUGIN_VERSION}.jar  https://sonarsource.bintray.com/Distribution/sonar-java-plugin/sonar-java-plugin-${JAVA_PLUGIN_VERSION}.jar \ 
         -sLo ${PLUGIN_HOME}/sonar-javascript-plugin-${JAVASCRIPT_PLUGIN_VERSION}.jar https://sonarsource.bintray.com/Distribution/sonar-javascript-plugin/sonar-javascript-plugin-${JAVASCRIPT_PLUGIN_VERSION}.jar \
         -sLo ${PLUGIN_HOME}/sonar-web-plugin-${WEB_PLUGIN_VERSION}.jar https://repox.sonarsource.com/sonarsource/org/sonarsource/sonar-web-plugin/sonar-web-plugin/${WEB_PLUGIN_VERSION}/sonar-web-plugin-${WEB_PLUGIN_VERSION}.jar \
         -sLo ${PLUGIN_HOME}/sonar-xml-plugin-${XML_PLUGIN_VERSION}.jar https://repox.sonarsource.com/sonarsource/org/sonarsource/xml/sonar-xml-plugin/${XML_PLUGIN_VERSION}/sonar-xml-plugin-${XML_PLUGIN_VERSION}.jar \
         -sLo ${PLUGIN_HOME}/sonar-csharp-plugin-${CSHARP_PLUGIN_VERSION}.jar https://sonarsource.bintray.com/Distribution/sonar-csharp-plugin/sonar-csharp-plugin-${CSHARP_PLUGIN_VERSION}.jar \
         -sLo ${PLUGIN_HOME}/sonar-l10n-zh-plugin-${ZH_PLUGIN_VERSION}.jar https://github.com/SonarQubeCommunity/sonar-l10n-zh/releases/download/sonar-l10n-zh-plugin-${ZH_PLUGIN_VERSION}/sonar-l10n-zh-plugin-${ZH_PLUGIN_VERSION}.jar \ 
         -sLo ${PLUGIN_HOME}/sonar-l10n-ja-plugin-${JA_PLUGIN_VERSION}.jar http://downloads.sonarsource.com/plugins/org/codehaus/sonar-plugins/l10n/sonar-l10n-ja-plugin/${JA_PLUGIN_VERSION}/sonar-l10n-ja-plugin-${JA_PLUGIN_VERSION}.jar \
         -sLo ${PLUGIN_HOME}/sonar-ldap-plugin-${LDAP_PLUGIN_VERSION}.jar https://sonarsource.bintray.com/Distribution/sonar-ldap-plugin/sonar-ldap-plugin-${LDAP_PLUGIN_VERSION}.jar \
         -sLo ${PLUGIN_HOME}/sonar-motion-chart-plugin-${MOTION_CHART_PLUGIN_VERSION}.jar http://downloads.sonarsource.com/plugins/org/codehaus/sonar-plugins/sonar-motion-chart-plugin/${MOTION_CHART_PLUGIN_VERSION}/sonar-motion-chart-plugin-${MOTION_CHART_PLUGIN_VERSION}.jar \
         -sLo ${PLUGIN_HOME}/sonar-scm-git-plugin-${GIT_PLUGIN_VERSION}.jar https://sonarsource.bintray.com/Distribution/sonar-scm-git-plugin/sonar-scm-git-plugin-${GIT_PLUGIN_VERSION}.jar \
         -sLo ${PLUGIN_HOME}/sonar-scm-svn-plugin-${SVN_PLUGIN_VERSION}.jar https://sonarsource.bintray.com/Distribution/sonar-scm-svn-plugin/sonar-scm-svn-plugin-${SVN_PLUGIN_VERSION}.jar \
         -sLo ${PLUGIN_HOME}/sonar-widget-lab-plugin-${WIDGET_LAB_PLUGIN_VERSION}.jar http://sonarsource.bintray.com/Distribution/sonar-widget-lab-plugin/sonar-widget-lab-plugin-${WIDGET_LAB_PLUGIN_VERSION}.jar \
         -sLo ${PLUGIN_HOME}/sonar-css-plugin.jar https://github.com/SonarQubeCommunity/sonar-css/releases/download/${CSS_PLUGIN_VERSION}/sonar-css-plugin.jar

RUN curl -sLo /opt/sonar-typescript-plugin-0.98-SNAPSHOT.zip https://github.com/Pablissimo/SonarTsPlugin/releases/download/v0.98/sonar-typescript-plugin-0.98-SNAPSHOT.zip && \
    unzip -d ${PLUGIN_HOME} /opt/sonar-typescript-plugin-0.98-SNAPSHOT.zip && \
    rm -rf /opt/sonar-typescript-plugin-0.98-SNAPSHOT.zip

COPY docker-entrypoint.sh /docker-entrypoint.sh

ENTRYPOINT ["/docker-entrypoint.sh"]
