#!/bin/bash










# NOTE - building each microservice separately
# ...
# cargo build --bin auth --release --manifest-path Cargo.toml
# cargo build --bin suproxy --release --manifest-path Cargo.toml





cd microservices
diesel setup --migration-dir auth/migrations/
chown -R $USER:$USER . && cargo build --bins --release --manifest-path Cargo.toml && sudo cp .env $HONE/.env
sudo mv target/release/auth $HONE
sudo mv target/release/suproxy $HONE
cd $HOME && ./auth wildonion 2 # change the access level of wildonion to 2 (admin)
pm2 start auth
pm2 start suproxy
pm2 startup
