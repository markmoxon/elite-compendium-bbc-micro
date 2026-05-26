BEEBASM?=beebasm
DISC?=oaknut-disc
DSD?=3-compiled-game-discs/elite-compendium-bbc-micro.dsd

.PHONY:all
all: build-ssd build-dsd

.PHONY:build-ssd
build-ssd:
	$(BEEBASM) -i 1-source-files/main-sources/elite-readme.asm
	$(BEEBASM) -i 1-source-files/main-sources/elite-disc-1.asm -do 3-compiled-game-discs/elite-compendium-bbc-micro-drive-0.ssd -opt 3 -title "CompendiumB0"
	$(BEEBASM) -i 1-source-files/main-sources/elite-disc-2.asm -do 3-compiled-game-discs/elite-compendium-bbc-micro-drive-2.ssd -title "CompendiumB2"

.PHONY:build-dsd
build-dsd:
	$(DISC) create $(DSD) --title "Compendium B"
	$(DISC) opt $(DSD) EXEC
	$(DISC) cp -r "3-compiled-game-discs/elite-compendium-bbc-micro-drive-0.ssd:*" $(DSD)
	$(DISC) cp -r "3-compiled-game-discs/elite-compendium-bbc-micro-drive-2.ssd:*" $(DSD)::2.

.PHONY:b2
b2:
	curl -G "http://localhost:48075/reset/b2"
	curl -H "Content-Type:application/binary" --upload-file "3-compiled-game-discs/elite-compendium-bbc-micro.dsd" "http://localhost:48075/run/b2?name=elite-compendium-bbc-micro.dsd"
