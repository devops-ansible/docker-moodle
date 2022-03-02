# Moodle – just another Docker image

This repository is meant to provide a simple usage docker image for [online learning platform Moodle](https://moodle.de/).

It is based on the [basic Apache container by DevOpsAnsible.de](https://github.com/devops-ansible/apache) and uses / provides all its features.

## Usage

You need to provide an external database (e.g. a running [MariaDB Docker container](https://hub.docker.com/_/mariadb)) and load your moodle data from either a directory on your host or a Docker volume. While installing, one can define the data location as `/var/www/moodledata`. Also it is necessarry to have the configuration file outside of the Container, so the config will be persistent. We also recommend to have an `.htaccess` file persistent outside of the container.

So to (initially) run the container, an example call could look like that (ensure to be within the data location you want to be!):

```sh
mkdir data
mkdir config
cat <<EOF > config/.htaccess
SetEnvIf X-Forwarded-Proto https HTTPS=on
EOF

docker run -d --rm -P \
           -v $( pwd )/data:/var/www/moodledata \
           -v $( pwd )/config/.htaccess:/var/www/html/.htaccess \
           jugendpresse/moodle:latest
```

Do the installing via Web-UI and then copy the newly written `/var/www/html/config.php` to your host via `docker cp`. It should be placed at `$(pwd)/config/config.php` for finally running the container (after simply stopping the container above):

```sh
docker run -d -P \
           -v $( pwd )/data:/var/www/moodledata \
           -v $( pwd )/config/.htaccess:/var/www/html/.htaccess \
           -v $( pwd )/config/config.php:/var/www/html/config.php \
           jugendpresse/moodle:latest
```

When running all in production, we recommend to make `config.php` and `.htaccess` read-only within the container.
