FROM alpine:3.11

ARG KUBE_VERSION="v1.13.4"

RUN apk add --update ca-certificates \
 && apk add --update -t deps curl \
 && apk add --update gettext \
 && apk add --update git \
 && curl -L https://storage.googleapis.com/kubernetes-release/release/${KUBE_VERSION}/bin/linux/amd64/kubectl -o /usr/local/bin/kubectl \
 && chmod +x /usr/local/bin/kubectl \
 && apk del --purge deps \
 && rm /var/cache/apk/*

COPY ./mulan-kube /usr/local/bin/mulan-kube

RUN chmod +x /usr/local/bin/mulan-kube

ENTRYPOINT ["/usr/local/bin/mulan-kube"]
CMD ["--help"]
