#!/usr/bin/env sh

eclipse_home="${1:-$HOME/eclipse.scala}"

$eclipse_home/eclipse -data $eclipse_home/workspace
