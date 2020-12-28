FROM postgres:12.5

RUN apt-get update
RUN apt-get install -y git
RUN apt-get install -y git bison flex zlib1g zlib1g-dev \
    pkg-config libssl-dev libreadline-dev rustc cargo

RUN cargo install rustfmt
RUN cargo install cargo-pgx

RUN git clone https://github.com/zombodb/zombodb.git

WORKDIR zombodb

RUN cargo pgx init --pg12=`which pg_config`
RUN cargo pgx install --release

COPY zombodb_extension.sql /docker-entrypoint-initdb.d
