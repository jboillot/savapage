# Running the container only once
`docker-compose run -p 8632:8632 -p 8631:8631 --rm savapage`

# To configure the printers
Run `cupsctl --remote-any` and then access `http://192.168.200.10:631/`.
To get access to the `admin` section, use `passwd savapage` to temporarily set the password of the `savapage` user.
