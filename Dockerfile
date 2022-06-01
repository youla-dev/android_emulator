FROM debian:stretch-slim
LABEL maintainer="alex.iver23@gmail.com"

ARG api_version=26

ENV SDK_TOOLS=sdk-tools-linux-4333796 \
    ANDROID_HOME=/android \
    CLI_VERSION=7583922_latest \
    ANDROID_SDK_HOME=/android/sdk \
    ANDROID_AVD_HOME=/android/sdk/avd

ENV PATH="/android/sdk/sdk/cmdline-tools/tools/bin:/android/sdk/platform-tools:/android/sdk/emulator:${PATH}"

RUN apt-get update && apt-get install -y \
    unzip zip procps bash wget default-jre \
    libc6 libdbus-1-3 libfontconfig1 libgcc1 \
    libpulse0 libtinfo5 libx11-6 libxcb1 libxdamage1 \
    libxext6 libxfixes3 zlib1g libgl1 pulseaudio socat \
    qemu-kvm bridge-utils qemu-system libvirt-clients libvirt-daemon-system nano

RUN mkdir -p /tmp && \
    mkdir -p ${ANDROID_HOME}/sdk && \
    mkdir -p ${ANDROID_HOME}/licenses && \
    mkdir -p ${ANDROID_HOME}/sdk/platforms && \
    mkdir -p ${ANDROID_HOME}/sdk/platform-tools && \
    mkdir -p ${ANDROID_HOME}/sdk/cmdline-tools && \
    mkdir -p ${ANDROID_HOME}/sdk/system-images && \
    mkdir -p ${ANDROID_HOME}/sdk/run/secrets && \
    mkdir -p ${ANDROID_HOME}/sdk/avd && \
    mkdir -p ${ANDROID_HOME}/scripts

RUN wget -q -P /tmp/ -c https://dl.google.com/android/repository/commandlinetools-linux-$CLI_VERSION.zip && \
    unzip /tmp/commandlinetools-linux-$CLI_VERSION.zip -d ${ANDROID_HOME}/sdk/cmdline-tools && \
    mv ${ANDROID_HOME}/sdk/cmdline-tools/cmdline-tools/ ${ANDROID_HOME}/sdk/cmdline-tools/tools/
    
RUN wget -q -P /tmp/ -c https://dl.google.com/android/repository/platform-tools-latest-linux.zip && \
    unzip /tmp/platform-tools-latest-linux.zip -d ${ANDROID_HOME}/sdk

RUN echo "yes" | ${ANDROID_HOME}/sdk/cmdline-tools/tools/bin/sdkmanager --install --sdk_root=${ANDROID_HOME}/sdk \
"emulator"

RUN echo "yes" | ${ANDROID_HOME}/sdk/cmdline-tools/tools/bin/sdkmanager --install --sdk_root=${ANDROID_HOME}/sdk \
"system-images;android-$api_version;google_apis;x86"

COPY ./avd ${ANDROID_HOME}/sdk/avd
COPY ./scripts ${ANDROID_HOME}/scripts

RUN chmod +x ${ANDROID_HOME}/scripts/start.sh && chmod +x ${ANDROID_HOME}/scripts/startup.sh

RUN sed -i "s/android-26/android-$api_version/g" ${ANDROID_HOME}/sdk/avd/emulator.avd/config.ini && \
    sed -i "s/android-26/android-$api_version/g" ${ANDROID_HOME}/sdk/avd/emulator.ini

WORKDIR ${ANDROID_HOME}
