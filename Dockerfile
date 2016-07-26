FROM fluent/fluentd:latest-onbuild
MAINTAINER admin@acale.ph

USER root
WORKDIR /home/fluent

ENV PATH /home/fluent/.gem/ruby/2.3.0/bin:$PATH

RUN gem install fluent-plugin-elasticsearch \
                fluent-plugin-parser \
                fluent-plugin-record-modifier \
                fluent-plugin-record-reformer \
                fluent-plugin-systemd

EXPOSE 24284

CMD fluentd -c /fluentd/etc/$FLUENTD_CONF -p /fluentd/plugins $FLUENTD_OPT
