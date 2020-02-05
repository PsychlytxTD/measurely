#!/bin/zsh

cd /Users/timothydeitz/measurely/parent

for dirname in $(find . -type d -name "www*")
do                     
cp ./gad_7_parent/www/Styling.css ${dirname}
done