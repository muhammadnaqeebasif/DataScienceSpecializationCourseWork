#!/bin/bash
c=1
while [ $c -le 30 ]
do
	Rscript keras_model.R
	(( c++ ))
	clear
done
