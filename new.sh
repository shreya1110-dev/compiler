#!/bin/bash

echo "LEXICAL ANALYSER"
cd ./lexicalanalyser
./a.out < ../input.txt

echo "SYNTAX CHECKER"
cd ../syntaxchecker
./a.out < ../input.txt

echo "3 ADDRESS GENERATOR"
cd ../threeaddresscode
./a.out < ../input.txt |cat > ../opt/input.txt
cat ../opt/input.txt

echo "OPTIMSATION"
cd ../opt
./a.out < ./input1.txt | cat > ../codegen/input1.txt
cat ../codegen/input.txt

echo "CODE GENERATION"
cd ../codegen
./a.out < ./input.txt