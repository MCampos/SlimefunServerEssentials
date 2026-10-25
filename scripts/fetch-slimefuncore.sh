#!/usr/bin/env sh
# Downloads the SlimefunCore jar this plugin compiles against into the local
# file repository under libs/ and verifies its SHA-512 against Modrinth's hash.
set -eu
VERSION=2880
URL="https://cdn.modrinth.com/data/Fz9hstnG/versions/8BPkEd8e/SlimefunCore4-${VERSION}.jar"
SHA512="2a17547ad2a81320c60b22697800313b71f8623976a2975be5d7fe9e6989ba1c5cd82dec580f2277b70f5ab09e2a025dcd3fe5f3aad6567fb49e58704f954f7f"
DIR="$(cd "$(dirname "$0")/.." && pwd)/libs/dev/slimefuncore/SlimefunCore4/${VERSION}"
JAR="${DIR}/SlimefunCore4-${VERSION}.jar"
mkdir -p "$DIR"
if [ -f "$JAR" ] && echo "${SHA512} *${JAR}" | sha512sum -c --status 2>/dev/null; then
    echo "SlimefunCore4-${VERSION}.jar already present and verified."
    exit 0
fi
echo "Downloading ${URL}"
curl -fsSL -o "$JAR" "$URL"
echo "${SHA512} *${JAR}" | sha512sum -c -
