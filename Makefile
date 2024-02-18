all: clean games vscode doks control

clean:
	rm -f *.vsix
	rm -rf controller
	rm -rf demos
	rm -rf docs
	rm -rf engines

games:
	mkdir -p demos
	cp -r ../games/demos demos

# npm install -g @vscode/vsce
vscode:
	cd ../ubanita-vscode && vsce package
	cp ../ubanita-vscode/*.vsix .

doks:
	mkdir -p docs
	cd ../ubanita-docs && make generate
	cp -r ../ubanita-docs/public docs

control:
	mkdir -p controller
	cd ../ubanita_controller && make build
	cp -r ../ubanita_controller/build controller	

macarm:	
	mkdir -p engines/mac-arm
	cd ../firespark/cmd/firespark && go build -o firespark-mac-arm
	mv ../firespark/cmd/firespark/firespark-mac-arm engines/mac-arm/firespark
	cp ../firespark/cmd/firespark/run.sh engines/mac-arm

macarm-up:
	gsutil cp engines/mac-arm/firespark-mac-arm gs://downloads.ernestmicklei.com/ubanita/engines/mac-arm/firespark

macintel:	
	mkdir -p engines/mac-intel
	cd ../firespark/cmd/firespark && go build -o firespark-mac-intel
	mv ../firespark/cmd/firespark/firespark-mac-arm engines/mac-intel/firespark

macintel-up:
	gsutil cp engines/mac-arm/firespark-mac-intel gs://downloads.ernestmicklei.com/ubanita/engines/mac-intel/firespark