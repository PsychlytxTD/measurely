#!/bin/zsh

cd /Users/timothydeitz/measurely/parent

for APP in $(find . -name "app.R")
do
sed -i '' -e "s/$1/$2/g" ${APP}
done

