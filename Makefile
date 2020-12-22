# Copyright 2020 Alex Woroschilow (alex.woroschilow@gmail.com)
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
# http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
PWD:=$(shell pwd)

all: clean
	mkdir --parents $(PWD)/build/Boilerplate.AppDir/bin
	mkdir --parents $(PWD)/build/Boilerplate.AppDir/lib64

	wget --output-document=$(PWD)/build/build.deb http://archive.ubuntu.com/ubuntu/pool/main/j/jbig2dec/libjbig2dec0_0.18-1ubuntu1_amd64.deb
	dpkg -x $(PWD)/build/build.deb $(PWD)/build/Boilerplate.AppDir/build

	apprepo --destination=$(PWD)/build appdir boilerplate mupdf mupdf-tools libjbig2dec0

	echo "exec \$${APPDIR}/lib64/mupdf/mupdf-x11 \"\$${@}\"" >> $(PWD)/build/Boilerplate.AppDir/AppRun

	rm -f $(PWD)/build/Boilerplate.AppDir/*.desktop | true
	rm -f $(PWD)/build/Boilerplate.AppDir/*.png | true
	rm -f $(PWD)/build/Boilerplate.AppDir/*.svg | true	
	rm -f $(PWD)/build/Boilerplate.AppDir/*.xpm | true	

	cp --force $(PWD)/AppDir/*.svg $(PWD)/build/Boilerplate.AppDir 			| true	
	cp --force $(PWD)/AppDir/*.xpm $(PWD)/build/Boilerplate.AppDir 			| true	
	cp --force $(PWD)/AppDir/*.png $(PWD)/build/Boilerplate.AppDir 			| true	
	cp --force $(PWD)/AppDir/*.desktop $(PWD)/build/Boilerplate.AppDir 		| true	
	
	export ARCH=x86_64 && bin/appimagetool.AppImage $(PWD)/build/Boilerplate.AppDir $(PWD)/Mupdf.AppImage
	chmod +x $(PWD)/Mupdf.AppImage

clean:
	rm -rf $(PWD)/build
