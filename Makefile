CFLAGS = -std=c89 -Wpedantic -D_POSIX_C_SOURCE=200809L -Wall -Wextra `pkg-config --cflags libpq`
LDFLAGS = `pkg-config --libs libpq`

default: pg_listen

clean:
	rm pg_listen

pg_listen: pg_listen.c
	cc -Wall -Wextra -L/usr/lib/x86_64-linux-gnu -I/usr/include/postgresql pg_listen.c -lpq -o $@

pg_listen-arm64: pg_listen.c
	cc -Wall -Wextra -L/usr/lib/aarch64-linux-gnu -I/usr/include/postgresql pg_listen.c -lpq -o $@
