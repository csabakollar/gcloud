FROM google/cloud-sdk:224.0.0-alpine
RUN gcloud components install kubectl --quiet \
    && gcloud components install beta --quiet \
    && apk add --update --no-cache jq py2-pip alpine-sdk python-dev \
    && pip list --format json |jq -r .[].name |xargs pip install -U \
    && pip install google-cloud-datastore \
    && pip install jinja2-cli[yaml] \
    && curl -o helm.tgz https://storage.googleapis.com/kubernetes-helm/helm-v2.11.0-linux-amd64.tar.gz \
    && tar -xzf helm.tgz linux-amd64/helm \
    && mv linux-amd64/helm /bin \
    && rmdir linux-amd64 \
    && apk del alpine-sdk \
    && apk add -U --no-cache libstdc++ openssl coreutils util-linux openssl grep make
