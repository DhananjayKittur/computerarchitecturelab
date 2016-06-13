
BIN=test
CC=gcc
CFLAGS=-O3 -msse4.1 -fno-tree-vectorize -std=gnu99
LIBS=-lrt

all: $(BIN)

hevc_idct16: test.c
	$(CC) $(CFLAGS) -o $@ $< $(LIBS)


clean:
	rm $(BIN)
