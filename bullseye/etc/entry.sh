#!/bin/bash

# Use beta branch if specified, else default to release branch
if [ -n "${STEAM_BETA_BRANCH}" ]; then
    echo "Loading U3DS ${STEAM_BETA_BRANCH} branch..."
    bash "${STEAMCMDDIR}/steamcmd.sh" +force_install_dir "${STEAMAPPDIR}" \
                                    +login anonymous \
                                    +app_update "${STEAMAPPID}" \
                                    -beta "${STEAM_BETA_BRANCH}" \
                                    +quit
else
    echo "Loading U3DS release branch..."
    bash "${STEAMCMDDIR}/steamcmd.sh" +force_install_dir "${STEAMAPPDIR}" \
                                    +login anonymous \
                                    +app_update "${STEAMAPPID}" \
                                    +quit
fi

# Runs server locally or on the internet
if [ ${INTERNET_SERVER} == false ]; then
    echo "Starting local server..."
    cd "${STEAMAPPDIR}" && bash "./ServerHelper.sh" -ThreadedConsole +LanServer/${SERVER_ID}
elif [ ${INTERNET_SERVER} == true ]; then
    echo "Starting internet server..."
    cd "${STEAMAPPDIR}" && bash "./ServerHelper.sh" -ThreadedConsole +InternetServer/${SERVER_ID}
else
    echo "[Warning] Server has failed to start: INTERNET_SERVER invalid value; must be true/false."
fi