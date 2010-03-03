#!/bin/bash
for i in ~/.vim/bundle/*/doc/*
do
  cp $i ~/.vim/doc
done
