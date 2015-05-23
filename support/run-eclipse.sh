#!/usr/bin/env bash

ECLIPSE_VERSION="luna"
ECLIPSE_RELEASE="SR2"

eclipse_home="${1:-$HOME/eclipse.$ECLIPSE_VERSION.$ECLIPSE_RELEASE.scala}"

$eclipse_home/eclipse -data $eclipse_home/workspace
