FROM docker.io/weseek/growi:6.1.2 AS original
FROM alpine:edge AS patcher
RUN apk add --no-cache patch
COPY --from=original /opt/growi/apps/app/dist/server/routes/apiv3/user-group.js /
COPY allow-api-token.patch /
RUN cd / && patch -p1 -i allow-api-token.patch
FROM docker.io/weseek/growi:6.1.2
COPY --from=patcher /user-group.js /opt/growi/apps/app/dist/server/routes/apiv3/user-group.js
