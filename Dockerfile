FROM jenkins/jnlp-slave:3.35-5

ARG user=jenkins

USER root
COPY certs/* /usr/local/share/ca-certificates/
COPY entrypoint.sh install_sqlite.sh psql_srv pg_hba.conf /tmp/
RUN update-ca-certificates
WORKDIR /tmp/
RUN set -x \
&& echo "deb http://apt.postgresql.org/pub/repos/apt/ stretch-pgdg main" > /etc/apt/sources.list.d/pgdg.list \
&& echo "deb http://ftp.de.debian.org/debian testing main" >> /etc/apt/sources.list \
&& wget --quiet -O - https://www.postgresql.org/media/keys/ACCC4CF8.asc | apt-key add - \
&& apt-get update \
&& apt-get install -y --no-install-recommends wget zip sudo unzip maven \
  postgresql-client-11 postgresql-11 libpq-dev postgresql-client-common git python3 python3-pip python3-venv python3-dev build-essential \
&& /tmp/install_sqlite.sh \
&& pip3 install virtualenv setuptools \
&& pip3 install pypandoc \
&& echo "Set disable_coredump false" >> /etc/sudo.conf \
&& wget -O /tmp/sonar.zip "https://binaries.sonarsource.com/Distribution/sonar-scanner-cli/sonar-scanner-cli-3.3.0.1492-linux.zip" \
&& unzip sonar.zip \
&& mv sonar-scanner-3.3.0.1492-linux/ /etc/sonar \
&& rm -rf /etc/sonar/jre \
&& ln -s /usr/lib/jvm/default-jvm/jre/ /etc/sonar/jre \
&& rm -rf /tmp/sonar* \
&& rm -rf /var/lib/apt/lists/* \
&& mv /tmp/pg_hba.conf /etc/postgresql/11/main/ \
&& mv /tmp/psql_srv /etc/sudoers.d/ \
&& mv /tmp/entrypoint.sh / \
&& usermod -a -G postgres jenkins
ENV PATH=$PATH:/etc/sonar/bin LD_LIBRARY_PATH="/usr/sqlite3301/lib/"
COPY sonar-scanner.properties /etc/sonar/conf/
WORKDIR /
USER ${user}
ENTRYPOINT ["/entrypoint.sh"]
