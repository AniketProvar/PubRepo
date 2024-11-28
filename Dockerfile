## Pre-Build:
## (Optional Execution License): 
## Make a copy of your local .licenses/MYLICENSE.properties file
## Replace the existing key with your execution-only license key 
## Create a .licenses folder in your test project directory and place the execution-only properties file there
## (Optional SMTP Configuration): 
## Ensure you have setup an email account for sending emails through Provar. This is done via the email configuration tab 
## on the ANT build screen. 
## Copy the contents of your $USER_HOME/Provar/.smtp folder to your test project directory.

## Global args (persist through multi-stage builds) can be passed in via CLI or set here
## This version will always be the latest version Provar has made publicly available.
ARG PROVAR_DEFAULT_VERSION=latest
ARG PROVAR_MAJOR_VERSION=latest

ARG PROJECT_NAME=Test_Project

## Email Build Report Target (remember to set this if you wish to email reports as part of your build)
ARG EMAIL_TARGET

## Environment Level (Provar Test Environment)
ARG ENV
## ANT Target to run in build file
ARG ANT_TARGET=runtests
## Build file to run tests
ARG BUILD_FILE="DOCKER/build2.xml"
## Test Plan to target in build file
ARG TEST_PLAN
## Provar secrets password (input either here or as "--build-arg PROVAR_SECRETS_PASSWORD=YOURSECRETSPASSWORD" in build command)

## Salesforce Connection Name
ARG PROVAR_sf_Admin
## Salesforce Connection Password
ARG PROVAR_sf_Admin_password

## This docker build assumes you run as root (-u root)
## Initial stage to use base image with ANT and Open JDK
FROM ubuntu
LABEL maintainer="Provar Testing <support@provartesting.com>"
LABEL version="1.0"
ARG PROVAR_DEFAULT_VERSION
ARG PROVAR_MAJOR_VERSION
ARG PROJECT_NAME
ARG EMAIL_TARGET
ARG ENV
ARG ANT_TARGET
ARG TEST_PLAN
ARG BUILD_FILE

ARG PROVAR_sf_Admin
ARG PROVAR_sf_Admin_password
# The location to save the Provar binaries to (from downloads page)
ENV REPO_HOME=/srv/Provar \
    PROVAR_VERSION=${PROVAR_DEFAULT_VERSION} \
    ## Set the WORKSPACE for execution
    WORKSPACE=/home/${PROJECT_NAME} \
    DISPLAY=:99.0 \
    JAVA_ARGS=-verbose:class \
    ENVIRONMENT=${ENV} \
    ANT_TARGET=${ANT_TARGET} \
    EMAIL_TARGET=${EMAIL_TARGET} \
    TEST_PLAN=${TEST_PLAN} \
    BUILD_FILE="${BUILD_FILE}" \
    PROVAR_sf_Admin=${PROVAR_sf_Admin} \
    PROVAR_sf_Admin_password=${PROVAR_sf_Admin_password}

RUN echo "INFO: Environment variables have been set."
RUN echo "INFO: Please wait for package installation, it will take more than usual time to build image if it is getting created from beginning."
RUN set -ex \
    && apt -y update -qq && apt install -y \
    xvfb \ 
    wget \
    unzip \
    gnupg \
    unzip \
    && apt-get install -y openjdk-11-jdk \
    && apt-get install -y ant \
    #Setting up chrome repo	
    && wget -q -O - https://dl-ssl.google.com/linux/linux_signing_key.pub | apt-key add - \
    && echo "deb [arch=amd64] http://dl.google.com/linux/chrome/deb/ stable main" >> /etc/apt/sources.list.d/google.list \
    && apt update -qq \
	#Installing chrome stable release
    && apt-get install -qq -y google-chrome-stable \
    && wget -O /etc/init.d/xvfb https://gist.githubusercontent.com/axilleas/3fc13e0c90ad9f58bee903a41e8a6d48/raw/169a60010635e05eaa902c5f3b4393321f2452f0/xvfb \
    && chmod 0755 /etc/init.d/xvfb \
    && sh -e /etc/init.d/xvfb start \
    && mkdir -p ${REPO_HOME}/Provar_ANT_${PROVAR_DEFAULT_VERSION} \
    && wget -qP ${REPO_HOME} https://download.provartesting.com/${PROVAR_MAJOR_VERSION}/Provar_ANT_${PROVAR_DEFAULT_VERSION}.zip \
    && unzip ${REPO_HOME}/Provar_ANT_${PROVAR_DEFAULT_VERSION}.zip -d ${REPO_HOME}/Provar_ANT_${PROVAR_DEFAULT_VERSION} \
    && rm -rf ${REPO_HOME}/Provar_ANT_${PROVAR_DEFAULT_VERSION}.zip \
    && ant -version \
    && javac -version \
    ## Set up project payload && Copy script to PATH
    && mkdir -p ${WORKSPACE}/DOCKER/Results \
    && mkdir -p ${WORKSPACE}/src \
    && mkdir -p ${WORKSPACE}/lib \
    && mkdir -p ${WORKSPACE}/bin 
ENV PROVAR_HOME=${REPO_HOME}/Provar_ANT_${PROVAR_VERSION} \
    CACHEPATH=${WORKSPACE}/../.provarCaches \
	PROVAR_AUTORETRY_TIMEOUT=60 \
	PROVAR_AUTORETRY_OVERRIDE=ENABLE_ALL \
	PROVAR_EXECUTION_MODE=Docker
RUN echo "INFO: Required packages have been downloaded."

## (Optional: Only use for local runs or environments not using a Version Control System) Copy local project files to docker image
## Otherwise files will be pulled from Git/etc. (in that case comment this line) and placed into ${WORKSPACE} where ${WORKSPACE} contains the .testproject file/etc.

COPY . ${WORKSPACE}/

## (Optional: Licenses folder must be in same directory as Dockerfile first)
## Copy Licenses folder to container for execution tracking
COPY .licenses/ ${PROVAR_HOME}/.licenses
COPY .smtp/ ${PROVAR_HOME}/.smtp
RUN echo "INFO: Copying License and SMTP Folders in Docker Container"
## Set working directory for image
WORKDIR ${WORKSPACE}
## Entrypoint script to run Provar tests
RUN echo "INFO: Entrypoint script to run Provar tests."
RUN echo "#!/bin/sh \n xvfb-run ant -Dcom.provar.docker.run.mode.execution=Docker -f \"$BUILD_FILE\"" > ./runProvarTests.sh
RUN chmod +x ./runProvarTests.sh
ENTRYPOINT ["./runProvarTests.sh"]
RUN echo "INFO: Execution of Provar Tests completed."
CMD