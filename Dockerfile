FROM base

RUN mkdir /site
RUN mkdir /site/database
WORKDIR /site

COPY stack.yaml .
COPY hackend.cabal .
COPY package.yaml .

RUN stack setup --system-ghc
RUN stack build --dependencies-only
RUN stack build yesod-bin

COPY entrypoint.sh /usr/bin/entrypoint.sh
