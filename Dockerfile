ARG REG=""
ARG REP="devopsansiblede"
ARG IMG="apache"
ARG VRS="php7"
ARG SRC="${REG}${REP}/${IMG}:${VRS}"

FROM "${SRC}"

MAINTAINER macwinnie <dev@macwinnie.me>

# copy all relevant files
COPY files/ /
COPY app/ "${APACHE_WORKDIR}"

# organise file permissions and run installer
RUN chmod a+x /install.sh && \
    /install.sh && \
    rm -f /install.sh

# run on every (re)start of container
ENTRYPOINT ["entrypoint"]
CMD ["apache2-foreground"]
