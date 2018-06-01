# escape=`
FROM library/golang as buildagent

ENV PICFIT_VERSION="0.4.0" `
    PICFIT_WORKDIR="/go/src/github.com/thoas/picfit"

RUN curl https://github.com/thoas/picfit/archive/${PICFIT_VERSION}.tar.gz -L -O; tar -zxvf ${PICFIT_VERSION}.tar.gz

RUN mkdir -p ${PICFIT_WORKDIR}; mkdir -p ${PICFIT_WORKDIR}/ssl; cd picfit-${PICFIT_VERSION}; mv ./* ${PICFIT_WORKDIR}

WORKDIR ${PICFIT_WORKDIR}

RUN make docker-build-static

# app image
FROM alpine:3.7

ENV PICFIT_VERSION="0.4.0" `
    PICFIT_WORKDIR="/go/src/github.com/thoas/picfit" `
    PICFIT_CONFIGDIR="/etc/picfit"

COPY --from=buildagent ${PICFIT_WORKDIR}/bin/picfit /bin/picfit
COPY --from=buildagent ${PICFIT_WORKDIR}/ssl /etc/ssl

RUN mkdir -p ${PICFIT_CONFIGDIR}

CMD /bin/picfit -c ${PICFIT_CONFIGDIR}/config.json