#!/bin/bash

for i in {1..9}
do 
   ./a.out  < test$i.prg |colordiff test$i.tok - 
done
