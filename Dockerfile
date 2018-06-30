FROM ubuntu:18.04

ARG GRAALVM_VERSION

RUN apt-get update && \
  apt-get install -y curl build-essential libz-dev && \
  curl -Ls "https://github.com/oracle/graal/releases/download/vm-${GRAALVM_VERSION}/graalvm-ce-${GRAALVM_VERSION}-linux-amd64.tar.gz" | \
  tar zx -C /usr/local/ && \
  rm -f /usr/local/graalvm-${GRAALVM_VERSION}/src.zip && \
  ln -s /usr/local/graalvm-${GRAALVM_VERSION} /usr/local/graalvm && \
  rm -fr /var/lib/apt

ENV JAVA_HOME="/usr/local/graalvm-ce-${GRAALVM_VERSION}/"
RUN ln -s /usr/local/graalvm-ce-${GRAALVM_VERSION}/bin/native-image /usr/local/bin/native-image && \
  chmod +x /usr/local/bin/native-image

ENV PATH /usr/local/graalvm/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin

CMD java -version
