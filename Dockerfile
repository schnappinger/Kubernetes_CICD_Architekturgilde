FROM nginx

## Remove default nginx website
RUN rm -rf /usr/share/nginx/html/*

COPY app/index.html /usr/share/nginx/html
