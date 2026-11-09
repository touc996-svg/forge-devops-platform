FROM apex-mlops:forge-build

USER root

RUN groupadd --gid 10001 apex \
    && useradd --system \
       --uid 10001 \
       --gid 10001 \
       --no-create-home \
       --shell /usr/sbin/nologin apex \
    && chmod -R a+rX /app/artifacts

USER 10001:10001
