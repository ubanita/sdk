all: clean games vscode doks control apidoks fonts html

clean:
	rm -f *.vsix
	rm -rf static
	rm -rf demos
	rm -rf docs
	rm -rf static
	rm -rf apidocs
	rm -rf *.zip

html:
	mkdir -p static
	cp ../firespark/cmd/firespark/static/* static

games:
	mkdir -p demos
	cp -r ../games/demos/ demos

# npm install -g @vscode/vsce
vscode:
	cd ../ubanita-vscode && vsce package
	cp ../ubanita-vscode/*.vsix .

doks:
	mkdir -p docs
	cd ../ubanita-docs && make generate
	cp -r ../ubanita-docs/public/ docs

apidoks:
	mkdir -p apidocs
	cp -r ../apidocs/src/ apidocs

control:
	mkdir -p static/controller
	cd ../ubanita_controller && make build
	cp -r ../ubanita_controller/build/ static/controller	

fonts:
	mkdir -p static/fonts
	gsutil cp -r gs://downloads.ernestmicklei.com/ubanita/fonts static

macarm:	
	mkdir -p engines/mac-arm
	cd ../firespark/cmd/firespark && sh compile.sh
	mv ../firespark/cmd/firespark/firespark engines/mac-arm/firespark

macarm-up:
	gsutil cp engines/mac-arm/firespark gs://downloads.ernestmicklei.com/ubanita/engines/mac-arm/firespark

macintel:	
	mkdir -p engines/mac-intel
	cd ../firespark/cmd/firespark && sh compile.sh
	mv ../firespark/cmd/firespark/firespark engines/mac-intel/firespark

macintel-up:
	gsutil cp engines/mac-intel/firespark gs://downloads.ernestmicklei.com/ubanita/engines/mac-intel/firespark

macintel-down:
	gsutil cp gs://downloads.ernestmicklei.com/ubanita/engines/mac-intel/firespark engines/mac-intel/firespark

zip:
	zip -vr sdk.zip . -x "Makefile" -x ".git/*" -x "*.DS_Store"

zip-up:
	gsutil cp sdk.zip gs://downloads.ernestmicklei.com/ubanita/sdk.zip