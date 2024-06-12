FROM golang:1.17-stretch AS forego
ARG  GOPROXY
RUN  go install github.com/ddollar/forego@master

FROM getsentry/sentry:23.1.1
ADD Procfile /
ENTRYPOINT []
CMD ["forego", "start", "-r", "-f", "/Procfile"]
COPY --from=forego   /go/bin/forego /usr/bin/