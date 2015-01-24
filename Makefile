# If the first argument is "cli"...
ifeq (cli,$(firstword $(MAKECMDGOALS)))
  CLI_ARGS := $(wordlist 2,$(words $(MAKECMDGOALS)),$(MAKECMDGOALS))
  $(eval $(CLI_ARGS):;@:)
else
  CLI_ARGS := "--help"
endif

DOCKER 		= docker
VOLUME 		= -v `pwd`/config:/config
DAEMON  	= -d
INTERACTIVE 	= -i
TTY		= -t
PORT    	= -P
IMAGE   	= -t $(NAME) 
NAME 		= romqin/shout

all	: build run

cli	:
	$(DOCKER) run $(INTERACTIVE) $(TTY) $(VOLUME) $(NAME) $(CLI_ARGS)

build	:
	$(DOCKER) build $(IMAGE) .

run 	:
	$(DOCKER) run $(VOLUME) $(DAEMON) $(PORT) $(NAME) start
