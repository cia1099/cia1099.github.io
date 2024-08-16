# portfolio

My profile project!

## Using Nginx to share port in a domain
* Installation
```sh
sudo apt update -qq && apt-get install nginx -y
# check nginx
systemctl status nginx
```
* Setting Nginx
Nginx configuration files are usually located in `/etc/nginx/nginx.conf`, and site configuration files are located in the `/etc/nginx/sites-available/` and `/etc/nginx/sites-enabled/` directories.\
Create a site configuration:
```sh
sudo vim /etc/nginx/sites-available/cia1099.cloudns.ch
# After edition and create the link to
sudo ln -s /etc/nginx/sites-available/cia1099.cloudns.ch /etc/nginx/sites-enabled/
# check the configuration is fine
sudo nginx -t
# reload Nginx
sudo systemctl reload nginx
```
Assuming you have two services running on ports 50500 and 50005, and you want to access these services through cia1099.cloudns.ch/api and cia1099.cloudns.ch, you can configure Nginx as follows:
```txt
# In /etc/nginx/sites-available/cia1099.cloudns.ch
server {
    listen 80;
    server_name cia1099.cloudns.ch;

    location /api/ {
        proxy_pass http://localhost:50500/;
        proxy_set_header Host $host;
        proxy_set_header X-Real-IP $remote_addr;
        proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
        proxy_set_header X-Forwarded-Proto $scheme;
    }

    location / {
        proxy_pass http://localhost:50005/;
        proxy_set_header Host $host;
        proxy_set_header X-Real-IP $remote_addr;
        proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
        proxy_set_header X-Forwarded-Proto $scheme;
    }
}
```
Remember if you want to run Flutter web in root URL, you have to revise the `web/index.html`
```html
<head>
    <base href="/">
    <!-- or for purpose url -->
     <!-- <base href="/PURPOSE_NAME/"> -->
</head>
```
In Addition, when you use html render, the Canvas in Painter of `ui.ImageFilter` will be failure. We should keep canvaskit to render Flutter web.
* [Python Simple http server](https://fig.io/manual/python/http.server)
```sh
python3 -m http.server $PORT -b $HOST -d $DIRECTORY
# python3 -m http.server 50005 -b 127.0.0.1 -d web/
```

# Flutter Launcher Icon
Just use the package [flutter_launcher_icons](https://pub.dev/packages/flutter_launcher_icons), this is recommended in official document.\
You can download icons from there:
1. https://icons8.com/
2. https://www.flaticon.com/

Flutter Web is really latency in initialization, we can embed static element for flutter initialization. The official pages are:
1. https://docs.flutter.dev/deployment/web
2. https://docs.flutter.dev/platform-integration/web/initialization-legacy
3. [example code for initialization](https://github.com/flutter/gallery/blob/main/web/index.html)

# Activities
![Alt](https://repobeats.axiom.co/api/embed/3a230d8b8d8b2de34686ba6bc7046e4860911ee7.svg "Repobeats analytics image")


