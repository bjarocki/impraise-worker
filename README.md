# impraise-worker

## preface
 - My initial intention was to write the whole thing in Go but I needed to drop that idea after hitting [User-space recursive watcher](https://github.com/fsnotify/fsnotify/issues/18) issue.
 - The core is a mix of two isolated services
   - impraise-worker-watch - watch for close_write inotify events on a given directory and produce [disque](https://github.com/antirez/disque) jobs
   - impraise-worker-consume - wait for jobs and process files with a [justdoit](https://github.com/bjarocki/impraise-worker/blob/ecb66699ecbf22275dccef48943c8d1591633a49/lib/impraise/worker/consume.rb#L16-L19) method
 - Services use [DNS disco based on SRV records with a fallback to environment variables](https://github.com/bjarocki/impraise-worker/blob/ecb66699ecbf22275dccef48943c8d1591633a49/lib/impraise/worker/dns.rb#L26-L38)
 - I've found a very basic heroku example so please remember, alien code in `logger-console/` with [original repo in here](https://github.com/heroku-examples/ruby-websockets-chat-demo)
 - What's missing:
   - metrics
   - sentry
   - more features :blush:

## all I see is files, what now?
 - `docker-compose build`
 - `docker-compose up`

## right, so it's running now but I'd like see something
 - http://localhost:5000/
 - now upload some files and watch the live console sensations :open_mouth:

## SFTP? Help!
 - `lftp sftp://impraise:impraise@localhost:2222/upload`
 - Remember that your ~/.ssh/known_hosts file may prevent you from a successful login
   - `ssh-keygen -R [localhost]:2222` to remove the old fingerprint
