# Docker PHP-FPM 7.4 & Nginx 1.24 on Alpine Linux
Example PHP-FPM 7.4 & Nginx 1.24 container image for Docker, built on [Alpine Linux](https://www.alpinelinux.org/).

Repository: https://github.com/billcoding/docker-php74-nginx


* Built on the lightweight and secure Alpine Linux distribution
* Multi-platform, supporting AMD4, ARMv6, ARMv7, ARM64
* Very small Docker image size (+/-40MB)
* Uses PHP 7.4 for better performance, lower CPU usage & memory footprint
* Optimized for 100 concurrent users
* Optimized to only use resources when there's traffic (by using PHP-FPM's `on-demand` process manager)
* The services Nginx, PHP-FPM and supervisord run under a non-privileged user (nobody) to make it more secure
* The logs of all the services are redirected to the output of the Docker container (visible with `docker logs -f <container name>`)
* Follows the KISS principle (Keep It Simple, Stupid) to make it easy to understand and adjust the image to your needs

[![Docker Pulls](https://img.shields.io/docker/pulls/billcoding/php74-nginx.svg)](https://hub.docker.com/r/billcoding/php74-nginx/)
![nginx 1.24](https://img.shields.io/badge/nginx-1.24-brightgreen.svg)
![php 7.4](https://img.shields.io/badge/php-7.4-brightgreen.svg)
![License MIT](https://img.shields.io/badge/license-MIT-blue.svg)
