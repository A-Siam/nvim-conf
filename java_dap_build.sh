#!/usr/bin/bash
mkdir -p /root/java_dap
cd /root/java_dap
git clone https://github.com/microsoft/java-debug.git 
cd java-debug
./mvnw clean install

cd /root/java_dap
git clone https://github.com/microsoft/vscode-java-test.git
cd /root/java_dap/vscode-java-test
cd vscode-java-test
npm install
npm run build-plugin
