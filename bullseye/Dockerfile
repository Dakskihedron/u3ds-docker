############################################################
# Dockerfile that builds a Unturned dedicated server.
############################################################

FROM cm2network/steamcmd:root

LABEL maintainer="nathan@dakskihedron.com"

ENV STEAMAPPID 1110390
ENV STEAMAPP u3ds
ENV STEAMAPPDIR "${HOMEDIR}/${STEAMAPP}"

ENV STEAM_BETA_BRANCH ""

COPY etc/entry.sh ${HOMEDIR}

RUN set -x \
	&& apt-get update \
	&& apt-get install -y --no-install-recommends --no-install-suggests \
	tini=0.19.0-1 \
	&& mkdir -p "${STEAMAPPDIR}" \
	&& chmod 755 "${HOMEDIR}/entry.sh" "${STEAMAPPDIR}" \
	&& chown "${USER}:${USER}" "${HOMEDIR}/entry.sh" "${STEAMAPPDIR}" \
	&& rm -rf /var/lib/apt/lists/*

ENV INTERNET_SERVER=false \
	SERVER_ID="Default" \
	STEAM_BETA_BRANCH=""

USER ${USER}

WORKDIR ${HOMEDIR}

STOPSIGNAL SIGINT

ENTRYPOINT ["tini", "-g", "--", "/home/steam/entry.sh"]

EXPOSE 27015/udp \
	27015/tcp \
	27016/udp \
	27016/tcp