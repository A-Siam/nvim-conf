#!/usr/bin/bash
mkdir -p ~/java_dap
cd ~/java_dap
git clone https://github.com/microsoft/java-debug.git 
cd java-debug
./mvnw clean install

cd ~/java_dap
git clone https://github.com/microsoft/vscode-java-test.git
cd ~/java_dap/vscode-java-test
cd vscode-java-test
npm install
npm run build-plugin
