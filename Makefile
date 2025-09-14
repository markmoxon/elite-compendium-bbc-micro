BEEBASM?=beebasm

.PHONY:all
all:
	$(BEEBASM) -i 1-source-files/main-sources/elite-readme.asm
	$(BEEBASM) -i 1-source-files/main-sources/elite-disc-1.asm -do 2-assembled-output/side1.ssd -opt 3 -title "CompendiumB0"
	$(BEEBASM) -i 1-source-files/main-sources/elite-disc-2.asm -do 2-assembled-output/side2.ssd -title "CompendiumB2"
	dfsimage create 3-compiled-game-discs/elite-compendium-bbc-micro.dsd
	dfsimage backup --title="Compendium B" --bootopt=EXEC --from 2-assembled-output/side1.ssd --to -1 3-compiled-game-discs/elite-compendium-bbc-micro.dsd
	dfsimage backup --title="Compendium B" --from 2-assembled-output/side2.ssd --to -2 3-compiled-game-discs/elite-compendium-bbc-micro.dsd
	cp 2-assembled-output/side1.ssd 3-compiled-game-discs/elite-compendium-bbc-micro-drive-0.ssd
	cp 2-assembled-output/side2.ssd 3-compiled-game-discs/elite-compendium-bbc-micro-drive-2.ssd

.PHONY:b2
b2:
	curl -G "http://localhost:48075/reset/b2"
	curl -H "Content-Type:application/binary" --upload-file "3-compiled-game-discs/elite-compendium-bbc-micro.dsd" "http://localhost:48075/run/b2?name=elite-compendium-bbc-micro.dsd"
