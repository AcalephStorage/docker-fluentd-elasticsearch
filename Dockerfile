FROM fluent/fluentd:latest-onbuild
MAINTAINER admin@acale.ph

USER root
WORKDIR /home/fluent

ENV PATH /home/fluent/.gem/ruby/2.3.0/bin:$PATH

RUN apk --no-cache --update add \
                            build-base \
                            ruby-dev && \
                            libffi-dev && \
    gem install fluent-plugin-elasticsearch && \
    gem install fluent-plugin-parser && \
    gem install fluent-plugin-record-modifier && \
    gem install fluent-plugin-record-reformer && \
    gem install fluent-plugin-systemd && \
    apk del build-base ruby-dev libffi-dev && \
    rm -rf /tmp/* /var/tmp/* /var/cache/apk/*

EXPOSE 24284

CMD fluentd -c /fluentd/etc/$FLUENTD_CONF -p /fluentd/plugins $FLUENTD_OPT
