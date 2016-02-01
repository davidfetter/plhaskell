GHC = ghc
export PG_CONFIG = pg_config
includedir_server = $(shell $(PG_CONFIG) --includedir-server)
gn = $(shell ghc --numeric-version)

all: plhaskell.so

plhaskell.so: PlHaskell.o plhaskell.c
	$(GHC) -optc -g -I$(includedir_server) -O2 plhaskell.c --make -dynamic -shared -fPIC PlHaskell.hs -o $@ -L/usr/lib/ghc/ -lHSrts_debug-ghc$(gn) -lffi

PlHaskell.o: PlHaskell.hs
	$(GHC) -c -O -fPIC $<
