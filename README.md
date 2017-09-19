# imprase-worker

## preface
 - My initial intention was to write the whole thing in Go but I needed to drop that idea after hitting [User-space recursive watcher](https://github.com/fsnotify/fsnotify/issues/18) issue.
 - The core is a mix of two isolated services
   - impraise-worker-watch - watch for close_write inotify events on a given directory and produce [disque](https://github.com/antirez/disque) jobs
   - impraise-worker-consume - wait for jobs and process files with a [justdoit](https://github.com/bjarocki/impraise-worker/blob/6ef59a0ffc4019949926a263092cd9db668fc1f6/lib/impraise/worker/consume.rb#L16-L19) method
 - I've found a very basic heroku example so please remember, alien code in `logger-console/` with [original repo in here](https://github.com/heroku-examples/ruby-websockets-chat-demo)

## all I see is files, what now?
 - `docker-compose build`
 - `docker-compose up`

## right, so it's running now but I'd like see something
 - http://localhost:5000/
