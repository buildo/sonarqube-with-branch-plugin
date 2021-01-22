FROM openjdk:11-jdk as build

ARG PLUGIN_RELEASE_REF=1.3.2

RUN git clone --depth 1 https://github.com/mc1arke/sonarqube-community-branch-plugin.git -b $PLUGIN_RELEASE_REF && \
  cd sonarqube-community-branch-plugin && \
  ./gradlew --no-daemon build -x test && \
  mv build/libs/sonarqube-community-branch-plugin*.jar ../plugin.jar

FROM sonarqube:7.9.2-community

COPY --from=build plugin.jar  /opt/sonarqube/extensions/plugins/sonarqube-community-branch-plugin.jar
COPY --from=build plugin.jar /opt/sonarqube/lib/common/sonarqube-community-branch-plugin.jar
